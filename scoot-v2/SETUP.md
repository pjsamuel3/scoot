# SCOOT — Setup Guide

Hey Matteo! Here's how to get the game running.

---

## Step 1 — Download Godot

Go to https://godotengine.org/download and download **Godot 4** (the standard version, not .NET).

- **Mac:** Download the macOS build, unzip it, drag the app somewhere easy to find (like your Desktop or Applications folder).
- **Windows:** Download the Windows 64-bit build, unzip it.

Godot is just a single file — no installer needed.

---

## Step 2 — Open the Project

1. Open Godot
2. Click **Import**
3. Navigate to the `scoot-v2` folder in this repo
4. Select `project.godot`
5. Click **Import & Edit**

---

## Step 3 — Hit Play

Press **F5** (or the Play button at the top right) to run the game.

You'll start in the 3D world. Use the mouse to look around.

---

## Controls

| Key | Action |
|-----|--------|
| **W A S D** | Ride around |
| **Space** | Jump |
| **Mouse** | Look / camera |
| **V** | Toggle follow cam ↔ first person |

### Tricks (press while in the air after a jump)

| Key | Trick | Points |
|-----|-------|--------|
| **T** | Tail Whip | 200 |
| **F** | Front Flip | 300 |
| **B** | Back Flip | 300 |
| **1** | 180 | 100 |
| **3** | 360 | 350 |
| **Y** | Bar Spin | 150 |
| **N** | No-Hander | 200 |
| **R** | Bri Flip | 600 |
| **P** | Slap the Finger | 200 |

### Scoring
- Chain tricks in the air before landing — each extra trick multiplies the score (2x, 3x, 4x...)
- After you land, a 3-second cooldown kicks in before you can do the next trick — make it count!
- Score ÷ 100 = coins earned

---

## What's in the Game

- 3D open world with terrain, trees, jump pads, and a big sky
- Third-person follow camera (or first-person if you want the wild view)
- HUD: score top-left, coins top-right, trick name flashes big in the middle, cooldown bar at the bottom
- All 9 tricks from the spec are wired up

---

## What Comes Next

This is the POC — the gameplay is already real. What's still to build:

- [ ] An actual scooter 3D model (right now you're using the robot character from the base project)
- [ ] Trick animations on the model (flip rotations, bar spin, etc.)
- [ ] Grind rails
- [ ] Skate park environment (quarter pipes, ramps, fun box)
- [ ] Shop, settings, main menu
- [ ] Sound effects for tricks
- [ ] PS5 export (needs Sony partner account)

---

*Built June 2026. Designed by Matteo.*
