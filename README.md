# Pokémon Red and Blue RTC for mGBA

This project is an attempt to synchronize the PC's system time with **pokered**.
It has only been tested on **mGBA 0.10.3** running on Windows 10. This is still a work in progress.

## How it works

New variables have been added to `ram/wram.asm`:

```
wClockBuffer::  ds 60

wRTCHours::     db
wRTCMinutes::   db
wRTCSeconds::   db
wRTCDayOfWeek:: db
wRTCDay::       db
wRTCMonth::     db
wRTCYear::      db
```

These values are empty by default on real hardware and other emulators.

The new function `PrintRealTimeClock` displays a clock box on screen while loading the start menu.
`PrepareClockStrings` handles formatting and displays something like:

```
SUNDAY 00-00-00 00:00:00
```

When building the ROM, `pokered.sym` will contain the addresses from `wRTCHours` to `wRTCYear`.
These addresses are required by the Lua script, so if you modify this project, make sure they always point to the same variables.

For example, `pokered.sym` should contain:

```
00:da39 wRTCHours
00:da3a wRTCMinutes
00:da3b wRTCSeconds
00:da3c wRTCDayOfWeek
00:da3d wRTCDay
00:da3e wRTCMonth
00:da3f wRTCYear
```

And in `pokered-mgba-rtc.lua`:

```
-- based on pokered.sym
local ADDR_HOURS   = 0xDA39
local ADDR_MINUTES = 0xDA3A
local ADDR_SECONDS = 0xDA3B
local ADDR_DOW     = 0xDA3C
local ADDR_DAY     = 0xDA3D
local ADDR_MONTH   = 0xDA3E
local ADDR_YEAR    = 0xDA3F
```

After building the ROM, load it in mGBA.
Then go to `Tools → Scripting...` and select `File → Load Script...`.

Load the Lua script (it can be located anywhere, such as inside your mGBA folder, on this project it's inside the lua folder).
You can load it at any time in game, either from the start screen or after loading a save file.

Feel free to use this project for any purpose!

## Credits

This project was mainly inspired by:

- [**Porygondolier's YouTube video**][youtube]
- [**Pokechattyyellow**][pokechatty]


# Pokémon Red and Blue [![Build Status][ci-badge]][ci]

This is a disassembly of Pokémon Red and Blue.

It builds the following ROMs:

- Pokemon Red (UE) [S][!].gb `sha1: ea9bcae617fdf159b045185467ae58b2e4a48b9a`
- Pokemon Blue (UE) [S][!].gb `sha1: d7037c83e1ae5b39bde3c30787637ba1d4c48ce2`
- BLUEMONS.GB (debug build) `sha1: 5b1456177671b79b263c614ea0e7cc9ac542e9c4`
- dmgapae0.e69.patch `sha1: 0fb5f743696adfe1dbb2e062111f08f9bc5a293a`
- dmgapee0.e68.patch `sha1: ed4be94dc29c64271942c87f2157bca9ca1019c7`

To set up the repository, see [**INSTALL.md**](INSTALL.md).


## See also

- [**Wiki**][wiki] (includes [tutorials][tutorials])
- [**Symbols**][symbols]
- [**Tools**][tools]

You can find us on [Discord (pret, #pokered)](https://discord.gg/d5dubZ3).

For other pret projects, see [pret.github.io](https://pret.github.io/).

[wiki]: https://github.com/pret/pokered/wiki
[tutorials]: https://github.com/pret/pokered/wiki/Tutorials
[symbols]: https://github.com/pret/pokered/tree/symbols
[tools]: https://github.com/pret/gb-asm-tools
[ci]: https://github.com/pret/pokered/actions
[ci-badge]: https://github.com/pret/pokered/actions/workflows/main.yml/badge.svg
[youtube]: https://www.youtube.com/watch?v=HShRGx88Fq8
[pokechatty]: https://github.com/TwitchPlaysPokemon/pokechattyyellow