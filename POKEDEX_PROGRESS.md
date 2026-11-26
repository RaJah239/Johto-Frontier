# Pokédex migration progress

- Source: `POKEDEX_LIST.txt` (SHA-256 `0D3F5BDEFD9F01A901CE2936CE19C085AEAB67B956BDB8AE88613A447F1B15AD`), identical to `new_dex_final.asm`; 253 entries.
- Baseline: 252 species; `make -j4 johtofrontier.gbc d` passed.
- Completed removals (all normal/debug builds passed):
  - Victini `9bd824744`, Regigigas `52fbaf859`, Registeel `dddacebcc`, Regice `a1d1f2ac4`, Regirock `ccf9195ed`, Nidoking `fbc968b80`, Riolu `40377dbdf`, Swinub `c87ca7b1b`, Smoochum `d529f30e4`, Wyrdeer `4a88c096f`, Stantler `4fe9088fb`, Dewgong `c0022620d`, Seel `88ebdcea2`, Horsea `648e91248`, Mantine `3253631e3`, Octillery `5da4a5438`, Remoraid `0b01fb02c`, Magnemite `52dcf319e`, Elekid `b182f09c5`, Voltorb `24dc81af4`, Cyndaquil `45ed84146`, Totodile `ccce6ae0a`, Chikorita `01802e2bc`, Togepi `6591ef753`, Charmander `248c064e7`, Squirtle `63941b7a2`, Turtwig `a7c05c60c`, Grotle `25837076b`, Torchic `582913dcc`, Rowlet `2287fa5f2`, Dartrix `4db33c8d5`, Decidueye `24a2367be`, Ralts `150bf1dcc`, Sunkern `3799e9b8d`, Sunflora `3b7b00c85`, Pidgey `9dea30d56`, Zubat `704b7d03e`, Teddiursa `c500058f9`, Mareep `0430f74ae`, Wimpod `8216c0c0c`, Golisopod `2e8d2bacb`, Rhyhorn `f05640fc9`, Gastly `6ad1c1c7b`, Natu `c5e3242ac`, Katu `5bd0a96b7`, Xatu `99b7a276c`, Growlithe `120151ebe`, Arcanine `5c78c7ef4`, Gible `ff2ff782d`, Makuhita `5c932f842`, Hariyama `31592b42f`, Iron Moth `c38b1c46e`, Tropius `40eea521d`, Electrode `85116a0ad`, Tangela `7d9d89fcc`, Tangrowth `0132e7161`, Litwick `977fb0b9a`, Lampent `53b705996`.
  - Encounter slots use retained species; the Magnemite-only Rusty trainer NPC was removed. Runtime emulator testing has not been done.
- Next: continue adding listed species one at a time per verified commit. Reorder retained species and indexed tables to source order before final verification.
- Remaining removals: none.
- Completed additions: Glaceon `c59d29236`.
- Completed additions: Leafeon `b4a5a09d2`.
- Completed additions: Poliwhirl `9a3754ccb`.
- Completed additions: Poliwrath (Urshifu-like stats; verified; this commit).
- Remaining additions: POLITOED, MAWILE, DUOSION, REUNICLUS, COTTONEE, WHIMSICOTT, MACHOKE, MACHAMP, SLOWKING, FOONGUS, AMOONGUSS, DIPPLIN, HYDRAPPLE, ROSELIA, ROSERADE, KADABRA, ALAKAZAM, VULPIX, NINETALES, NINETALES_A, IVYSAUR, VENUSAUR, SABLEYE, SHELLDER, CLOYSTER, VIKAVOLT, DUSCLOPS, DUSKNOIR, EELEKTROSS, DHELMISE, DRAGALGE, HONCHKROW, MARSHTOMP, SWAMPERT, JUMPLUFF, GROVYLE, SCEPTILE, CRABOMINABLE, DONDOZO, CYCLIZAR, KROOKODILE, RHYPERIOR, MIMIKYU, DUGTRIO_A, MAGMORTAR, PRIMARINA, EXPLOUD, TYRANTRUM, DRAGONITE, HYDREIGON, GOODRA, DRAGAPULT, BAXCALIBUR, VOLCANION, MELMETAL.
- Name normalization to confirm against source/reference data: Slyveon→SYLVEON, BaltoyIcon→BALTOY, Marshtop→MARSHTOMP, Mr.Mime→MR__MIME, Ninetales (Aloan)→NINETALES_A, Dugtrio.A→DUGTRIO_A, Rotom (Wash)→ROTOM, Ho-Oh→HO_OH, N-Own→NOWN. `Poliwrath (Urshifu like stats)` is treated as POLIWRATH.
- Asset gaps in `C:\Users\RaJah239\Desktop\pokemon_sprites`: SHELLDER, CLOYSTER, EXPLOUD, DRAGONITE; DUGTRIO_A may be the `dugtrio - shattered` folder. Check supplied reference projects before implementing these species. Do not silently substitute graphics.
- Review: Zubat removal leaves 30 generic `L@` trainer placeholders with empty parties in `data/trainers/parties.asm`; verify these classes are unused or remove/rework the placeholder trainers before release.
- Runtime limitation: emulator checks have not been performed. Species IDs shift during this migration, so existing saves may be incompatible; verify at the end.

- Review: Removing Gastly leaves the five generic Sage/Ping trainer parties empty in `data/trainers/parties.asm`; check whether these placeholders are used before release.
