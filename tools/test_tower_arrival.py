"""Replay three Battle Tower arrivals in PyBoy with disposable cartridge RAM.

Usage: python tools/test_tower_arrival.py path/to/johtofrontier.gbc
The ROM needs its matching .sym file.
"""

import argparse
from io import BytesIO
from pathlib import Path

from test_save_compat import Game


def prepare_room(rom):
    game = Game(rom)
    game.boot("NewGame")
    game.gb.tick(90, False)
    fields = {
        "wPartyCount": [1], "wPartySpecies": [1, 255], "wPartyMon1Species": [1],
        "wPartyMon1Level": [50], "wPartyMon1HP": [0, 150], "wPartyMon1MaxHP": [0, 150],
        "wBTChoiceOfLvlGroup": [1],
    }
    for name, values in fields.items():
        game.write(name, bytes(values))
    state = BytesIO()
    game.gb.save_state(state)
    game.gb.stop(False)
    return state


def arrival(rom, state, previous):
    game = Game(rom)
    gb = game.gb
    state.seek(0)
    gb.load_state(state)
    streak = len(previous)
    game.write("sNrOfBeatenBattleTowerTrainers", bytes([streak]))
    game.write("sBTTrainers", bytes(previous + [255] * (7 - streak)))
    for name in ("LoadOpponentTrainerAndPokemonWithOTSprite", "Script_appear",
                 "Script_warpsound", "Script_battletowertext", "BattleMenu"):
        gb.hook_register(*gb.symbol_lookup(name), game.visited.add, name)

    premature_loads = []

    def check_sprite_load(_):
        if "LoadOpponentTrainerAndPokemonWithOTSprite" in game.visited and "Script_appear" not in game.visited:
            premature_loads.append(gb.register_file.A)

    gb.hook_register(*gb.symbol_lookup("GetSpriteVTile"), check_sprite_load, None)

    def seed_selection(_):
        gb.memory[gb.symbol_lookup("hRandomAdd")[1]] = 17 + 37 * streak

    gb.hook_register(*gb.symbol_lookup("LoadOpponentTrainerAndPokemon"), seed_selection, None)
    # Queue the actual warp opcode. Its arguments come from the second hallway
    # warp event (y, x, destination warp, group, map). The script executes from
    # the private copy of the cartridge header, after boot.
    bank, addr = gb.symbol_lookup("ScriptCommandTable")
    dispatch = bytes(gb.memory[bank, addr:addr + 512])

    def opcode(command):
        pointer = gb.symbol_lookup("Script_" + command)[1].to_bytes(2, "little")
        return next(i // 2 for i in range(0, len(dispatch), 2) if dispatch[i:i + 2] == pointer)

    bank, addr = gb.symbol_lookup("BattleTowerHallway_MapEvents")
    # def_warp_events emits the number of warp events before the first entry.
    group, number = gb.memory[bank, addr + 9:addr + 11]
    gb.memory[0, 0x104:0x10a] = [opcode("warp"), group, number, 3, 7, opcode("end")]
    game.write("wMapReentryScriptQueueFlag", bytes([1, 1, 4, 1]))

    def wait_for(name):
        for _ in range(1200):
            if name in game.visited:
                return
            gb.tick(1, True)
        raise AssertionError(f"Did not reach {name} on room entry {streak + 1}, map {game.read('wMapGroup', 2).hex()}")

    wait_for("LoadOpponentTrainerAndPokemonWithOTSprite")
    assert game.read("wMap1ObjectStructID", 1) == b"\xff"
    # Player and receptionist stand still while the opponent enters.
    areas = [(64, 56, 80, 76), (32, 104, 48, 125)]
    before = [gb.screen.image.crop(area).tobytes() for area in areas]
    attendant = game.read("wMap2Object", 2)
    wait_for("Script_warpsound")
    assert not premature_loads, f"Requested sprites before appear: {premature_loads}"
    frames = 0
    while "Script_battletowertext" not in game.visited:
        assert frames < 180
        assert game.read("wMap2Object", 2) == attendant
        assert [gb.screen.image.crop(area).tobytes() for area in areas] == before
        gb.tick(1, True)
        frames += 1
    assert frames > 10
    trainer = game.read("wBT_OTTrainerClass", 1)
    bank, addr = gb.symbol_lookup("BTTrainerClassSprites")
    sprite = bytes([gb.memory[bank, addr + trainer[0] - 1]])
    slot = game.read("wMap1ObjectStructID", 1)[0]
    assert 0 < slot < 13
    assert sprite == game.read("wMap1ObjectSprite", 1) == game.read(f"wObject{slot}Sprite", 1)
    game.reach("BattleMenu", "a")
    assert game.read("wOtherTrainerClass", 1) == trainer
    opponent = game.read("sBTTrainers", 7)[streak]
    assert opponent not in previous
    gb.stop(False)
    print(f"Arrival {streak + 1}: trainer {opponent}, sprite {sprite[0]}, {frames} frames checked")
    return opponent


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("rom", type=Path)
    rom = parser.parse_args().rom
    state = prepare_room(rom)
    opponents = []
    for _ in range(3):
        opponents.append(arrival(rom, state, opponents))
