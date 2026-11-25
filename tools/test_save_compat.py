"""Check two RGBDS builds with PyBoy 2.9 using disposable cartridge RAM.

Usage: python tools/test_save_compat.py old/johtofrontier.gbc new/johtofrontier.gbc
Each ROM needs its matching .sym file.
"""

import argparse
from io import BytesIO
from pathlib import Path

from pyboy import PyBoy


class Game:
    def __init__(self, rom, ram=None):
        self.gb = PyBoy(
            BytesIO(rom.read_bytes()), symbols=str(rom.with_suffix(".sym")),
            ram_file=BytesIO(ram) if ram is not None else None,
            window="null", cgb=True, fast_mode=False, log_level="ERROR",
        )
        self.gb.set_emulation_speed(0)
        self.visited = set()
        for name in ("_TitleScreen", "MainMenuJoypadLoop", "NewGame", "Continue",
                     "PlayerEvents", "StartMenu", "TryLoadSaveFile.backup"):
            self.gb.hook_register(*self.gb.symbol_lookup(name), self.visited.add, name)

    def reach(self, name, button):
        for _ in range(360):
            if name in self.visited:
                return
            self.gb.button(button, 2)
            self.gb.tick(24, False)
        raise AssertionError(f"Failed to reach {name} using {button}")

    def boot(self, menu_action):
        self.reach("_TitleScreen", "a")
        self.reach("MainMenuJoypadLoop", "start")
        self.reach(menu_action, "a")
        self.reach("PlayerEvents", "a")

    def read(self, name, length):
        bank, addr = self.gb.symbol_lookup(name)
        return bytes(self.gb.memory[bank, addr:addr + length])

    def write(self, name, data):
        bank, addr = self.gb.symbol_lookup(name)
        self.gb.memory[bank, addr:addr + len(data)] = data

    def call(self, routine):
        # Use the game's stack and bank shadow. The header is idle after boot,
        # so its in-memory copy can hold a two-byte loop as the return target.
        gb = self.gb
        bank, addr = gb.symbol_lookup(routine)
        top = gb.symbol_lookup("wStackTop")[1]
        gb.memory[0xffff] = 0
        gb.memory[0xff70] = 1
        gb.memory[0x2000] = bank
        gb.memory[gb.symbol_lookup("hROMBank")[1]] = bank
        gb.memory[0, 0x100:0x102] = [0x18, 0xfe]
        gb.memory[top - 2:top] = [0, 1]
        gb.register_file.SP = top - 2
        gb.register_file.PC = addr
        for _ in range(200):
            gb.tick(1, False)
            if gb.register_file.PC == 0x100:
                assert gb.register_file.SP == top, routine
                return gb.register_file.F
        raise AssertionError(f"{routine} failed to return")

    def save(self):
        self.call("SaveGameData")
        for name in ("VerifyChecksum", "VerifyBackupChecksum"):
            assert self.call(name) & 0x80, name
        image = BytesIO()
        self.gb.stop(ram_file=image, rtc_file=BytesIO())
        assert len(image.getvalue()) == 4 * 0x2000
        return image.getvalue()


def verify_load(rom, image, fields, *, backup=False):
    game = Game(rom, image)
    game.boot("Continue")
    assert ("TryLoadSaveFile.backup" in game.visited) == backup
    for name, value in fields.items():
        assert game.read(name, len(value)) == value, name
    game.reach("StartMenu", "start")
    assert game.call("VerifyChecksum") & 0x80, "primary checksum after loading"
    return game


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("older_rom", type=Path)
    parser.add_argument("newer_rom", type=Path)
    args = parser.parse_args()

    old = Game(args.older_rom)
    old.boot("NewGame")
    fields = {
        "wMoney": bytes.fromhex("00 30 39"), "wPlayerID": bytes.fromhex("19 83"),
        "wOptions5": bytes([13]), "wNumItems": bytes([1]), "wItems": bytes([18, 3, 255]),
        "wPartyCount": bytes([1]), "wPartySpecies": bytes([1, 255]),
        "wPartyMon1Species": bytes([1]), "wPartyMon1Level": bytes([5]),
        "wPartyMon1HP": bytes([0, 12]), "wPartyMon1MaxHP": bytes([0, 18]),
    }
    for name, value in fields.items():
        old.write(name, value)
    for name, size in (("wPlayerName", 11), ("wMapGroup", 1), ("wMapNumber", 1),
                       ("wEventFlags", 12)):
        fields[name] = old.read(name, size)
    bank, addr = old.gb.symbol_lookup("sChecksum")
    original = old.save()

    current = verify_load(args.newer_rom, original, fields)
    updated = current.save()
    damaged = bytearray(original)
    damaged[bank * 0x2000 + addr - 0xa000] ^= 1
    verify_load(args.newer_rom, damaged, fields, backup=True).gb.stop(False)
    verify_load(args.older_rom, updated, fields).gb.stop(False)
    print("Passed primary load, backup recovery and reverse compatibility")


if __name__ == "__main__":
    main()
