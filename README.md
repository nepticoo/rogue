<div align="center">

# 🗡️ Rogue

**A terminal roguelike written from scratch in C — procedural dungeons, permadeath-adjacent stakes, and not a single game engine in sight.**

[![Language](https://img.shields.io/badge/language-C-00599C?style=flat-square&logo=c)](https://en.wikipedia.org/wiki/C_(programming_language))
[![UI](https://img.shields.io/badge/UI-ncursesw-4EAA25?style=flat-square)](https://invisible-island.net/ncurses/)
[![Audio](https://img.shields.io/badge/audio-SDL2__mixer-1E6FBA?style=flat-square&logo=libretro)](https://github.com/libsdl-org/SDL_mixer)
[![License](https://img.shields.io/badge/license-MIT-yellow?style=flat-square)](LICENSE)

*Fundamentals of Programming — Sharif University of Technology, 2024*

</div>

---

## Overview

`Rogue` is a from-scratch reimagining of the 1980 classic, built as a first-year
university project. Every dungeon is generated at runtime, every room is hidden
until you walk into it, and every keystroke goes through a hand-rolled `ncurses`
render loop — no frameworks, no libraries beyond the terminal and an audio mixer.

The project was an exercise in building a complete, stateful application in C:
account management with persistent binary saves, procedural level generation,
fog-of-war visibility, an inventory and item economy, and a full menu system —
all inside an 80×24 terminal.

## Highlights

| | |
|---|---|
| 🎲 **Procedural generation** | Five levels, six rooms each, laid out on a randomized grid and stitched together with generated corridors — no two runs share a map. |
| 🔦 **Fog of war** | Rooms, corridors and doors reveal themselves progressively. Corridors light up cell-by-cell; a room snaps into view the moment you step through its door. |
| 🚪 **Secret rooms** | A hidden *enchant room* is tucked into a random early level, reachable only through a blinking secret door (`?`) you have to find first. |
| 🏆 **Treasure room** | Clear the fourth level's staircase and you drop into a hand-built final chamber — the run's payout. |
| 👤 **Accounts & saves** | Sign-up with email/password validation, a random password generator, guest mode, and save/resume backed by binary `fwrite` snapshots of the entire game state. |
| 🏅 **Global scoreboard** | Ranks every registered player by score, with medals, badges for the current user, and a "first game" timestamp. |
| 🎨 **Themes & difficulty** | Three player colors, three difficulty tiers that scale starting health, trap counts and trap damage. |
| 🎵 **Soundtrack** | Two looping tracks via `SDL2_mixer`, toggleable in-game. |
| 🍖 **Survival systems** | Hunger drains over time, food rots in your pack (fresh → normal → corrupted), health regenerates only when you're fed and out of combat. |

## Gameplay

You are `@`. Descend from level 1 to level 5, hoard gold, and reach the treasure
room alive.

### Map legend

| Symbol | Meaning | Symbol | Meaning |
|:---:|---|:---:|---|
| `@` | You | `^` | Trap (hidden until triggered) |
| `.` | Room floor | `O` | Pillar |
| `#` | Corridor | `<` | Stairs down |
| `+` | Door | `>` | Stairs up / spawn |
| `-` `\|` | Walls | `?` | Secret door |
| 💰 💎 | Gold / black gold | 🏆 | Treasure |
| 🔨 🗡️ 🧹 🏹 ⚔️ | Weapons | 🫓 🍖 🍇 🦠 | Food |

### Controls

**Movement** — classic *vi* keys, eight directions:

```
        y  k  u          ↖  ↑  ↗
        h  ·  l    ⇒     ←  ·  →
        b  j  n          ↙  ↓  ↘
```

| Key | Action |
|:---:|---|
| `e` | Food menu — eat, inspect freshness |
| `i` | Weapon menu — switch your equipped weapon |
| `p` | Spell menu — cast health, speed or damage |
| `m` | Full-level map overview |
| `s` | Search your surroundings (reveals adjacent cells) |
| `f` | Fast-move — repeat the next direction key |
| `g` | Step over an item without picking it up |
| `<` / `,` | Descend to the next level |
| `>` / `.` | Return to the previous level |
| `?` / `/` | Pass through a secret door |
| `Space` | Attack |
| `Enter` | Skip message |
| `q` | Save and quit |

### Arsenal

| Weapon | Damage | Range | Notes |
|---|:---:|:---:|---|
| 🔨 Mace | 5 | melee | Starting weapon, unlimited |
| ⚔️ Sword | 10 | melee | Rare — one per run, if it spawns at all |
| 🗡️ Dagger | 12 | 5 | Thrown, recoverable |
| 🧹 Magic Wand | 15 | 10 | Thrown, highest damage |
| 🏹 Arrow | 5 | 5 | Thrown, plentiful |

### Spells

| Spell | Effect |
|---|---|
| 🫀 Health | +3 HP per turn for 10 turns |
| ⚡ Speed | Enemies move at half rate for 10 turns |
| 💥 Damage | Boosted attack damage |

## Build & run

### Requirements

- `gcc` (or any C99-capable compiler)
- `ncursesw` — wide-character ncurses, for the Unicode glyphs
- `SDL2` and `SDL2_mixer` — for the soundtrack
- A terminal at **at least 80×24** with 256-color and Unicode support

<details>
<summary><strong>Installing dependencies</strong></summary>

**Debian / Ubuntu**
```bash
sudo apt install build-essential libncursesw5-dev libsdl2-dev libsdl2-mixer-dev
```

**Fedora**
```bash
sudo dnf install gcc make ncurses-devel SDL2-devel SDL2_mixer-devel
```

**Arch**
```bash
sudo pacman -S base-devel ncurses sdl2 sdl2_mixer
```

**macOS (Homebrew)**
```bash
brew install ncurses sdl2 sdl2_mixer
```

**Windows** — build under WSL or MSYS2; the game relies on POSIX `mkdir`,
`opendir` and `ncursesw`.

</details>

### Build

```bash
make
```

### Play

```bash
make run
```

> Run the binary from the repository root — the game resolves `assets/` and
> writes player data to `users/` relative to the working directory.

## Project layout

```
.
├── src/
│   ├── head.h            # Shared types, constants and globals
│   ├── main.c            # Entry point, ncurses/color setup, win/lose/save
│   ├── main_menu.c       # Sign-in, sign-up, validation, account files
│   ├── pre_game_menu.c   # Settings, themes, difficulty, music, profile, scoreboard
│   ├── init_game.c       # Procedural generation: rooms, corridors, items, secrets
│   └── play_game.c       # Game loop, rendering, input, inventory, survival systems
├── assets/
│   ├── music1.mp3        # Soundtrack
│   ├── music2.mp3
│   └── emojies.txt       # Unicode escape reference for the in-game glyphs
├── docs/                 # Course handout (not tracked)
├── Makefile
└── LICENSE
```

### Architecture notes

The game is a **single translation unit**: `main.c` textually `#include`s the
other four `.c` files, so one `gcc` invocation builds everything and all state
lives in two file-scope globals (`user`, `user_s`). This keeps the build trivial
and was the pattern taught in the course — a modular build with real headers
and separate objects would be the natural next refactor.

State is modeled as a nested struct tree — `USER` → `LEVEL[5]` → `ROOM[7]` —
which makes saving the entire game a single `fwrite` of the `USER` struct, and
loading it a single `fread`.

Each level keeps four parallel grids: `base` (terrain), `items`, `enemies`, and
`visited` (fog of war), plus `which_room` mapping every cell back to its room.
Rendering composites these layers top-down each frame.

## Project status

This is **Phase 1** of a two-phase course project. The dungeon, generation,
rendering, progression, items, survival systems, accounts and UI are complete.
Enemy AI and combat resolution are stubbed for Phase 2 — `move_enemies()` is
intentionally empty, and the enemy data structures are in place but not yet
driven.

## License

[MIT](LICENSE) — © 2024 Mahdi Abootalebi
