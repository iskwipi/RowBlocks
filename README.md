# RowBlocks

A Breakout/Arkanoid-style arcade game written entirely in 16-bit x86 assembly for DOS. Built as a single-file COM program targeting real-mode DOS with VGA Mode 13h graphics and PC speaker audio.

---

## Gameplay

Move the paddle left and right to bounce the ball and destroy all the bricks on screen. Clear every brick to advance to the next level. You start with **3 lives** — lose them all and the game resets.

### Controls

| Key | Action |
|-----|--------|
| `A` | Move paddle left |
| `D` | Move paddle right |
| `ESC` | Quit to DOS |

> Any key also unpauses the game after losing all lives (at the game-over screen).

---

## Features

- **VGA Mode 13h** — 320×200 resolution, 256-colour graphics
- **Custom keyboard ISR** — replaces INT 09h for smooth, responsive key input without BIOS overhead
- **V-Retrace sync** — drawing is synchronised to the display's vertical retrace to eliminate tearing
- **PC speaker audio** — distinct sounds for ball bounce, block break, life lost, and level clear
- **HUD** — live score (top-right) and remaining lives drawn as heart icons (bottom-left), rendered from hand-crafted pixel bitmaps
- **Coloured brick rows** — five rows of bricks each drawn in a distinct VGA palette colour
- **Infinite levels** — completing a level rebuilds the brick grid and restarts

---

## Technical Overview

| Detail | Value |
|--------|-------|
| Assembler | NASM |
| Bit mode | 16-bit real mode |
| Binary format | DOS COM (`.com`) |
| Origin | `0x100` |
| Video mode | INT 10h Mode 13h (320×200, 256 colours) |
| VRAM segment | `0xA000` |
| Target OS | MS-DOS / FreeDOS |

### Key Routines

| Routine | Description |
|---------|-------------|
| `KEYBOARD_ISR` | Custom INT 09h handler; tracks press/release state for A, D, and ESC |
| `INSTALL_ISR` / `RESTORE_ISR` | Hooks and unhooks the keyboard interrupt vector |
| `WAIT_FOR_VRETRACE` | Polls the VGA status register (`0x3DA`) to synchronise rendering |
| `UPDATE_BALL_POSITION` | Moves the ball and applies directional speed bytes |
| `CHECK_WALL_COLLISIONS` | Reflects the ball off the screen borders; triggers life loss on bottom exit |
| `CHECK_PADDLE_COLLISION` | AABB collision between ball and paddle |
| `CHECK_LEVEL_COLLISION` | Iterates the block grid to detect and resolve ball–brick collisions |
| `DRAW_LEVEL` | Renders the full scene: background, border, bricks, paddle, ball, and HUD |
| `REBUILD_LEVEL` | Resets the block and colour bitmaps to start a new level |
| `SET_SPEAKER_FREQ` / `SPEAKER_ON` / `SPEAKER_OFF` | Directly programs the 8253 PIT (port `0x42`/`0x43`) and PC speaker (port `0x61`) |

---

## Building

### Requirements

- [NASM](https://www.nasm.us/) (any recent version)
- A DOS environment to run the output — options include:
  - [DOSBox](https://www.dosbox.com/)
  - [FreeDOS](https://www.freedos.org/) (bare metal or VM)
  - Any real MS-DOS machine

### Assemble

```bash
nasm -f bin game.asm -o game.com
```

### Run (DOSBox example)

```
mount c /path/to/your/game/folder
c:
game.com
```

---

## Project Structure

```
.
└── game.asm   # Complete game source — graphics, input, physics, audio, HUD
```

---

## License

This project is provided as-is for educational and archival purposes.
