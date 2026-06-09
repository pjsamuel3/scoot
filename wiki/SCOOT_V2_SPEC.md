# SCOOT V2 — 3D Scooter Trick Game Spec

Designed by a kid. Built for real.

This is a new game inspired by the original SCOOT HTML game but reimagined as a proper 3D console-style title. Do **not** modify the original `scooter-game.html`.

---

## Vision

A third-person / first-person freestyle scooter game set in an open world. Think Tony Hawk's Pro Skater meets GTA camera style. You ride around a skate park / open world, hit ramps, grind rails, and pull off real tricks with a 3-second cooldown between each one so every trick feels earned and deliberate.

---

## Platform Target

**Primary:** PlayStation 4 / PlayStation 5  
**Development machines:** MacBook Pro or Windows 11 PC  
**Engine:** [Godot 4](https://godotengine.org/) — free, open source, exports to Windows/Mac/Linux and with a PS4/PS5 export template (requires Sony developer registration for final console builds; all development and playtesting happens on PC/Mac).

> **PS4/PS5 publishing note for Dad:** To ship on PlayStation you need a PlayStation Partner account (free to apply at partners.playstation.com). Godot 4 supports PS4/PS5 via official export templates available to registered partners. All development and testing can be done entirely on a MacBook Pro or Windows 11 PC — no console devkit required until final certification.

---

## Engine & Tech Stack

| Thing | Choice | Why |
|---|---|---|
| Engine | Godot 4.x | Free, runs on Mac + Windows, strong 3D, GDScript is easy to learn |
| Language | GDScript (Python-like) | Beginner friendly, no build step |
| Renderer | Forward+ (Godot default) | Good shadows, glow, post-processing |
| Physics | Godot built-in CharacterBody3D | Reliable for character movement |
| Audio | Godot AudioStreamPlayer3D | Spatial sound for environment |
| Version control | Git (this repo) | Already set up |

---

## Camera System

Two modes, toggle with a single button press (PlayStation: **Triangle** / Keyboard: **V**).

### Mode 1 — GTA Follow Cam (default)
- Camera sits behind and slightly above the rider, ~3–4m back
- Smoothly follows the player with a small lag (lerp factor ~0.1) so it feels weighty
- Camera tilts slightly down during tricks to keep the rider in frame
- During a flip/spin the camera pulls back slightly (FOV increase) for drama

### Mode 2 — First Person
- Camera attaches to the rider's head/helmet position
- Handlebars and front of scooter visible at bottom of screen
- Slight head-bob when riding over rough ground
- On tricks: camera rotates with the rider's body — very disorienting and fun

> Toggle is instant, no transition animation needed. State persists until toggled again.

---

## Controls

### Keyboard (Mac/Windows dev)
| Key | Action |
|---|---|
| WASD / Arrow keys | Move / steer |
| SPACE | Jump |
| V | Toggle camera (follow ↔ first person) |
| T | Tail Whip |
| F | Front Flip |
| B | Back Flip |
| 1 | 180 |
| 3 | 360 |
| S | Bar Spin |
| R | Bri Flip |
| N | No-Hander |
| G | Grind (auto-triggers near a rail) |
| P | Slap the Finger |
| Shift | Pump / boost speed |
| Esc | Pause menu |

### PlayStation Controller
| Button | Action |
|---|---|
| Left stick | Move / steer |
| Cross (X) | Jump |
| Triangle | Toggle camera |
| Square | Tail Whip |
| Circle | Bar Spin |
| R1 | Front Flip |
| L1 | Back Flip |
| R2 | 180 |
| L2 | 360 |
| R3 (stick click) | Bri Flip |
| L3 (stick click) | No-Hander |
| D-pad Up | Slap the Finger |
| D-pad Down | Grind |
| Options | Pause |

---

## Trick System

### The 3-Second Cooldown Rule
- After landing any trick, a cooldown bar appears on screen
- No trick input is accepted until the bar fills (3 seconds)
- This makes each trick feel like a big moment — not button mashing
- If you attempt a trick during cooldown, the character shakes their head (quick animation)
- Cooldown resets on landing, not on trick execution (so mid-air combos still chain)

### Combo Window
- While airborne you can chain multiple tricks before landing
- Combo multiplier increases per trick in the air (2x, 3x, 4x…)
- Landing cleanly banks the combo score
- Bailing (falling off) loses the combo

### Tricks — What They Actually Look Like

All tricks require the rider to be in the air (after a jump or off a ramp).

---

#### Tail Whip
Rider holds the handlebars steady. Kicks the deck of the scooter in a horizontal circle with their feet — the deck spins 360° around the headtube while the bars stay still. Rider catches the deck with their feet on landing.

**Animation:** deck rotates around the fork axis, rider's legs kick to the side and come back under.

---

#### Front Flip
Rider and scooter rotate forward together (towards the direction of travel), full 360° rotation.

**Animation:** entire character+scooter node rotates forward on the X axis.

---

#### Back Flip
Rider and scooter rotate backward (away from direction of travel), full 360°.

**Animation:** entire character+scooter node rotates backward on the X axis. Opposite to front flip.

---

#### 180
Rider jumps and rotates 180° horizontally — lands riding backwards (fakie).

**Animation:** Y axis rotation, 180°. Rider lands facing opposite direction.

---

#### 360
Same as 180 but a full 360° spin — lands forward.

**Animation:** Y axis rotation, 360°.

---

#### Bar Spin
Rider holds the deck steady with their feet. Spins the handlebars 360° horizontally (around the fork/steerer tube axis) with their hands, catches them.

**Animation:** handlebar node spins on its vertical axis while the rest of the scooter/rider stays level.

---

#### Bri Flip (the real one — this is important)
Invented by Brian Boston. **This is NOT just a flip.** Here is exactly what happens:

1. Rider launches into the air
2. Rider kicks the scooter deck OUT and AWAY from their body — the whole scooter swings out like a Tail Whip
3. **At the same time**, the rider's body does a **backflip** (rotating backward)
4. The scooter rotates separately — 360° around the headtube (like a Tail Whip) — while drifting further from the rider
5. Rider and scooter are briefly separated in the air — scooter swings back in
6. Rider catches the deck with their feet and the bars with their hands simultaneously on the way down
7. Lands clean

**Animation:** Split the rider and scooter into two nodes briefly. Rider node backflips (X axis backward). Scooter node simultaneously does a Tail Whip rotation (deck spins around fork). Both nodes re-merge at the landing keyframe. This is the most complex animation in the game — it should look noticeably different from all other tricks.

**Score:** Bri Flip is worth 3× the base points of a Tail Whip.

---

#### No-Hander
Rider takes both hands off the handlebars mid-air, extends arms out to the sides, then grabs back.

**Animation:** arm bones rotate outward while scooter floats level.

---

#### Slap the Finger (original game trick)
Rider slaps the finger/deck in a downward motion mid-air — stylish flair move.

**Animation:** one hand shoots down and slaps the deck, then comes back up.

---

#### Grind
Rider lands on a rail or edge and slides along it. Auto-triggers when jumping toward a rail at the right angle.

**Animation:** scooter deck sits on rail, slight forward bob animation while sliding.

---

## Scoring

| Trick | Base Points |
|---|---|
| 180 | 100 |
| Bar Spin | 150 |
| Tail Whip | 200 |
| No-Hander | 200 |
| Slap the Finger | 200 |
| Front Flip | 300 |
| Back Flip | 300 |
| 360 | 350 |
| Grind (per second) | 100/s |
| Bri Flip | 600 |

Combo multiplier applied on top. Max multiplier: 10×.

Coins earned = score ÷ 100 (rounded down), same as original game.

---

## World / Environments

### Skate Park (starting world)
- Open outdoor skate park with multiple areas
- Half-pipe, quarter pipes, fun box, grind rails, manual pad
- Trees, fencing, graffiti walls
- Day/night cycle (toggle in settings)
- Wind system from original game: affects trees and ambient sound

### Indoor Warehouse (unlock with coins)
- Same vibe as original game's indoor environment but 3D
- Hanging lamps with glow
- Concrete floor, graffiti tags
- Tighter space — harder grinding lines

### Street (unlock with coins)
- GTA-style open street block
- Curbs, benches, stairs, handrails to grind
- Cars parked (static, not moving)

---

## Shop

Same items as original game, plus:
- New scooter skins (change 3D model texture/colour)
- Helmet skins
- Trick trail effects (coloured streak behind scooter during tricks)

---

## HUD

- Score (top left) with glow effect
- Combo multiplier (below score, only shows when > 1×)
- Coin counter (top right)
- Cooldown bar (bottom centre — fills over 3 seconds after landing)
- Current trick name toast (centre screen, big punchy text, fades after 1.5s)
- Camera mode indicator (small icon, top right corner)
- FPS counter (toggleable, top right)

---

## Settings Menu

- Toggle FPS display
- Toggle day/night
- Toggle wind
- Toggle birds (flying across sky)
- Music volume
- SFX volume
- Camera sensitivity (follow cam)
- Invert Y axis (first person)

---

## Project Folder Structure (Godot 4)

```
scoot-v2/
├── project.godot
├── scenes/
│   ├── main_menu.tscn
│   ├── game.tscn
│   ├── player/
│   │   ├── player.tscn          # CharacterBody3D + camera rig
│   │   └── player.gd
│   ├── tricks/
│   │   └── trick_system.gd      # Cooldown, scoring, combo logic
│   ├── environments/
│   │   ├── skate_park.tscn
│   │   ├── warehouse.tscn
│   │   └── street.tscn
│   └── ui/
│       ├── hud.tscn
│       ├── shop.tscn
│       └── settings.tscn
├── assets/
│   ├── models/                  # .glb scooter and rider models
│   ├── textures/
│   ├── sounds/
│   └── music/
└── exports/
    ├── mac/
    ├── windows/
    └── ps5/                     # requires Sony partner export template
```

---

## Getting Started on a New Machine

### Prerequisites
1. Download **Godot 4** (latest stable) from https://godotengine.org/download — it's a single executable, no installer needed. Works on Mac and Windows.
2. Clone this repo: `git clone <repo-url>`
3. Open Godot → Import → select `scoot-v2/project.godot`

### Mac-specific
- Godot runs natively on Apple Silicon (M1/M2/M3) and Intel Macs
- No Xcode required for development, only for iOS export
- For PS5 export: install the Godot PS5 export template (available after Sony partner registration)

### Windows 11-specific
- Download the Windows 64-bit Godot executable
- No Visual Studio required for development
- For PS4/PS5 export: same Sony partner template, works on Windows

### First thing to build
Start with `player.tscn` — get the character moving, jumping, and the camera toggle working before adding any tricks. Validate the feel before building the trick system.

---

## What Makes This Different From V1

| Feature | V1 (HTML) | V2 (Godot 3D) |
|---|---|---|
| Camera | Fixed 2D side view | Follow cam + first person toggle |
| World | 2D flat environments | 3D open world areas |
| Trick cooldown | None (spam freely) | 3-second cooldown per trick |
| Bri Flip | Simple animation | Accurate split-node backflip + tailwhip combo |
| Platform | Browser only | Mac, Windows, PS4, PS5 |
| Movement | Static player, background scrolls | Full 3D movement in world |

---

*Spec written 2026-06-09. Game designed by a kid who knows what a Bri trick actually is.*
