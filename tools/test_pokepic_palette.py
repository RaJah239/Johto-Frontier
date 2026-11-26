"""Check that a Surf Pokepic keeps nearby object colors during its message."""

import argparse
from pathlib import Path

from test_save_compat import Game


def check(rom):
    game = Game(rom)
    gb = game.gb
    game.boot("NewGame")
    gb.tick(90, False)

    bank, address = gb.symbol_lookup("ScriptCommandTable")
    dispatch = bytes(gb.memory[bank, address:address + 512])

    def opcode(name):
        pointer = gb.symbol_lookup("Script_" + name)[1].to_bytes(2, "little")
        return next(i // 2 for i in range(0, len(dispatch), 2)
                    if dispatch[i:i + 2] == pointer)

    def queue(script):
        gb.memory[0, 0x104:0x104 + len(script)] = script
        game.write("wMapReentryScriptQueueFlag", bytes([1, 1, 4, 1]))

    queue([opcode("warp"), 14, 1, 3, 6, opcode("end")])
    for _ in range(400):
        gb.tick(1, False)
        if game.read("wMapGroup", 2) == bytes([14, 1]):
            break
    else:
        raise AssertionError("Route 12 warp did not finish")
    gb.tick(120, False)

    # Place the player beside Route 12's rocks and select the night rain
    # palette through the same routines the map setup uses.
    game.write("wFieldWeather", bytes([1]))
    game.write("wTimeOfDayPal", bytes([2]))
    setup = []
    for routine in ("SelectWeatherObjPalette", "LoadMapPals", "UpdateTimePals"):
        bank, address = gb.symbol_lookup(routine)
        setup += [opcode("callasm"), bank, address & 255, address >> 8]
    queue(setup + [opcode("end")])
    gb.tick(45, False)
    assert game.read("wWeatherPalSlot", 1) == bytes([2])
    assert game.read("wLoadedObjPal0", 2) == bytes([0, 3])

    expected = game.read("wOBPals1", 16)[8:16]
    assert game.read("wOBPals2", 16)[8:16] == expected
    bank, address = gb.symbol_lookup("UsedSurfScript")
    game.write("wMapReentryScriptQueueFlag",
               bytes([1, bank, address & 255, address >> 8]))

    saw_message = False
    for frame in range(110):
        if frame % 26 == 0:
            gb.button("a", 2)
        gb.tick(1, False)
        if game.read("wScriptRunning", 1) == bytes([255]):
            saw_message = True
            assert game.read("wOBPals2", 16)[8:16] == expected, frame
    assert saw_message
    assert game.read("wOBPals2", 16)[8:16] == expected
    gb.stop(False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("rom", type=Path)
    check(parser.parse_args().rom)
    print("Passed Route 12 rock palette through Surf Pokepic and message")
