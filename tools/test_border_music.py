"""Check border music with PyBoy. Run with a release .gbc and matching .sym."""

import argparse
from pathlib import Path

from test_save_compat import Game


def check_border(rom, skip_bicycle=False, override=False):
    game = Game(rom)
    gb = game.gb
    game.boot("NewGame")
    gb.tick(90, False)
    game.write("wNumKeyItems", bytes([1]))
    game.write("wKeyItems", bytes([7, 255]))  # BICYCLE, end
    game.write("wOverworldMusicOverride", bytes([0]))
    game.write("wNewBarkTownSceneID", bytes([1]))  # allow leaving town
    options = game.read("wOptions5", 1)[0] & ~1
    game.write("wOptions5", bytes([options | skip_bicycle]))
    bank, addr = gb.symbol_lookup("ScriptCommandTable")
    dispatch = bytes(gb.memory[bank, addr:addr + 512])

    def opcode(name):
        pointer = gb.symbol_lookup("Script_" + name)[1].to_bytes(2, "little")
        return next(i // 2 for i in range(0, len(dispatch), 2) if dispatch[i:i + 2] == pointer)

    def queue(script):
        # Reuse the private cartridge header as event-script storage after boot.
        gb.memory[0, 0x104:0x104 + len(script)] = script
        game.write("wMapReentryScriptQueueFlag", bytes([1, 1, 4, 1]))

    def wait(name, value, button=None):
        for frame in range(500):
            if game.read(name, len(value)) == value:
                return
            if button and frame % 14 == 0:
                gb.button(button, 2)
            gb.tick(1, False)
        raise AssertionError(f"{name} did not reach {value.hex()}")

    def verify_song(song):
        gb.tick(140, False)
        for name in ("wMapMusic", "wChannel1MusicID"):
            actual = game.read(name, 1)[0]
            assert actual == song, f"{name}: expected song {song}, got {actual}"

    def bike(state):
        bank, addr = gb.symbol_lookup("BikeFunction")
        queued = gb.symbol_lookup("wQueuedScriptBank")[1]
        game.write("wUsingItemWithSelect", bytes([1]))
        queue([opcode("callasm"), bank, addr & 255, addr >> 8,
               opcode("memjump"), queued & 255, queued >> 8])
        wait("wPlayerState", bytes([state]), "a")
        gb.tick(90, False)

    town, route = bytes([15, 4]), bytes([15, 3])
    town_song, route_song, bicycle_song = 51, 44, 14
    queue([opcode("warp"), *town, 0, 8, opcode("end")])
    wait("wMapGroup", town)
    gb.tick(180, False)
    verify_song(town_song)
    wait("wMapGroup", route, "left")
    verify_song(route_song)
    if override:
        game.write("wOverworldMusicOverride", bytes([route_song]))
    bike(1)
    verify_song(route_song if skip_bicycle or override else bicycle_song)
    wait("wMapGroup", town, "right")
    destination_song = town_song if skip_bicycle else bicycle_song
    verify_song(route_song if override else destination_song)
    bike(0)
    verify_song(route_song if override else town_song)
    gb.stop(False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("rom", type=Path)
    path = parser.parse_args().rom
    check_border(path)
    check_border(path, skip_bicycle=True)
    check_border(path, override=True)
    print("Passed walking, riding, dismounting, disabled bicycle music and saved music override")
