# Personal layer map

This map describes the current exports in `config/glove80.keymap` and `config/keymap.json`. The base layout is QWERTY with the computer and MoErgo Layout Editor set to Swedish (`sv-SE`). Key combinations in the Symbols layer are HID keycodes interpreted by the Swedish host layout; do not translate them from US keycap legends.

On Glove80, `LH` and `RH` mean left and right half; `T1`–`T6` identify the thumb keys. `&mo` means hold the key to activate the layer and release it to return. The higher-numbered active layer takes precedence.

## Base and layer access

| Position | Base action |
| --- | --- |
| LH T1 / RH T1 | Left Shift / Right Shift |
| LH T2 | Hold Symbols |
| LH T3 | Hold Lower |
| RH T3 | Left GUI/Super |
| RH T2 | Hold Navigation |
| LH T4 / LH T5 | Backspace / Delete |
| LH T6 | Hold Numbers |
| RH T6 | Hold Workbench |
| RH T5 / RH T4 | Enter / Space |
| LH C5R6 | Hold Mouse |

The GUI thumb remains available as a direct fallback. The other base positions keep QWERTY and the existing End, arrow, bracket, Page Up, and Page Down keys. Home is on Navigation at `Y`; the Mouse hold occupies its former base position. The Magic key remains on LH C6R6.

The Mouse key is on LH C5R6, replacing the base Home key there. Home is available on Navigation at the `Y` position. If holding this bottom-row key is uncomfortable, move Mouse to another comfortable hold position in the editor and update this document.

## Home-row modifiers

The home-row modifier keys are `A S D F` on the left and `J K L Ö` on the right; G and H remain ordinary letter keys:

| Key | Hold action | Tapping term | Prior idle |
| --- | --- | ---: | ---: |
| A / Ö | Left GUI | 260 ms | 150 ms |
| S / L | Left Alt / Right Alt | 240 ms | 150 ms |
| D / K | Left Ctrl / Right Ctrl | 210 ms | 150 ms |
| F / J | Left Shift / Right Shift | 190 ms | 100 ms |

These exported behaviors use `tap-preferred`, `quick-tap-ms = 300`, positional hold-trigger filtering, and `hold-trigger-on-release`. The home-row mod configuration is unchanged from the export; these values are not a uniform 300 ms tapping term. The dedicated thumb Shift keys remain available.

## Symbols

Hold LH T2. Bindings below are the actual keycodes in the export; shifted keycodes and Right Alt are interpreted using Swedish input. The arrow and quote entries are text macros.

| Base key | Binding | Base key | Binding |
| --- | --- | --- | --- |
| Tab | `BSLH` | Y | `LS(N6)` |
| Q | `LS(N1)` | U | `LS(EQUAL)` |
| W | `RA(N2)` | I, O, P, `\` | Transparent |
| E | `LS(N8)` | Esc | `Backtick` macro |
| R | `LS(N9)` | A | `LS(N3)` |
| T | `LS(N5)` | S | `RA(N4)` |
| D | `RA(N8)` | F | `RA(N9)` |
| G | `LS(N0)` | H | `LS(DOT)` |
| J | `LS(FSLH)` | K | `FSLH` |
| L | `MINUS` | Ö | `LS(N2)` |
| Ä | `Circumflex` macro | Z | `LS(N7)` |
| X | `RA(MINUS)` | C | `RA(N7)` |
| V | `RA(N8)` | B | `RA(N0)` |
| B | `PythonReturn` macro | N | `LS(COMMA)` |
| M | `COMMA` | , | `DOT` |
| . | `LS(MINUS)` | - | `TrippleQuote` macro |
| LH C3R6 / LH C2R6 | `NON_US_BSLH` / `LS(NON_US_BSLH)` | RH C4R6 | `Tilde` macro |

The remaining positions are transparent. LH T1 is Shift, LH T3 returns to Base, and other thumb positions are transparent on this layer.

`Backtick`, `Circumflex`, and `Tilde` emit their dead-key sequence followed by Space, producing the literal character with the standard Swedish layout. `PythonReturn` emits `->`; `TrippleQuote` emits three double quotes.

## Navigation

Hold RH T2. This layer supplies direct modifiers on the left and navigation on the right:

| Left-hand key | Action | Right-hand key | Action |
| --- | --- | --- | --- |
| A | Left GUI | H / J / K / L | Left / Down / Up / Right |
| S | Left Alt | Ö | Delete |
| D | Left Ctrl | Y / U / I / O | Home / Page Down / Page Up / End |
| F | Left Shift | P | Backspace |
| G | Right Alt | N / M / , / . | Ctrl+Left / Ctrl+Right / Ctrl+Home / Ctrl+End |
| Z / X / C | Escape / Tab / Shift+Tab | - | Escape |
| V / B | Ctrl+R / Ctrl+L | | |

On the QWERTY letter row, Q/W/E/R invoke tmux Ctrl+A `p` (previous window), `n` (next window), `z` (zoom pane), and `w` (window chooser), respectively. These macros send the prefix and suffix as key events and do not type shell text. Neovim's normal-mode keys and Space leader remain on Base.

## Numbers and function keys

Hold LH T6. The left side maps Q/W/E/R/T to F1–F5, A/S/D/F/G to F6–F10, and Z/X to F11/F12. The right side maps U/I/O/P to 7/8/9/slash, J/K/L/Ö to 4/5/6/asterisk, and M/,/./- to 1/2/3/minus. H produces 0 and N produces the decimal point. Unlisted positions are transparent or `&none` as shown in the exported keymap.

These are ordinary number-row HID keycodes, not keypad keys; they do not depend on Num Lock. On Swedish input, the punctuation follows the host layout.

## Workbench text macros

Hold RH T6. A macro types the listed text, including the final space. It does **not** press Enter or execute a command. Start at a suitable prompt/cursor position and review the resulting text before running it.

| Base key | Text inserted |
| --- | --- |
| Q | `python -m pytest_` |
| W / E / R / T | `make test_` / `make lint_` / `make check_` / `make fmt_` |
| A | `make ci_` |
| S / D | `git status_` / `git diff_` |
| Y / U / I / O / P | `docker ps_` / `docker logs -f_` / `docker exec -it_` / `docker compose_` / `docker inspect_` |
| H / J | `docker build -t_` / `docker run --rm_` |
| K / L / Ö | `docker compose logs -f_` / `docker compose up_` / `docker compose config_` |
| Z / X / C / V | F13 / F14 / F15 / F16 |

F13–F16 are intended for the user's Neovim diagnostic, next-diagnostic, rename, and code-action mappings. Those mappings must be configured separately in Neovim. If they do not reach Neovim, check the terminal's key handling and the firmware's HID report configuration.

The `make` text prefixes reflect the user's projects and are not universal Pants commands. The macros contain no credentials, Enter, or destructive operations.

## Mouse

Hold LH C5R6. Mouse support is enabled by `CONFIG_ZMK_POINTING=y` in `config/glove80.conf`. The mouse buttons and scrolling/movement assignments are:

| Base key | Action |
| --- | --- |
| T / Y | Mouse back / mouse forward |
| U / I / O / P | Scroll left / down / up / right |
| A | Hold Ctrl |
| S / D / F | Middle click / right click / left click |
| G | Hold Shift |
| H / J / K / L | Move left / down / up / right |
| N / M / , / . | Fine movement left / down / up / right (`150` max velocity) |

To drag, hold Mouse, hold F for left button, and move with H/J/K/L. Release F before releasing Mouse. Use the physical mouse for prolonged pointer work; this layer is for brief repositioning and occasional clicks.

## Lower, Magic, and Factory

Lower is still a momentary layer on LH T3. Its function row maps F1–F5 to brightness down/up, previous track, next track, and play/pause; F6–F10 map to mute, volume down/up, Print Screen, and Pause/Break. Its home row retains `TrippleQuote`, `PythonReturn`, and the punctuation bindings from the export; Symbols is the primary programming-symbol layer.

Magic remains the system layer for Bluetooth profile/output selection, RGB, reset, and bootloader actions. Factory is a switch-test layer activated from Magic. It has no mapped route back; power-cycle the keyboard to leave it. Avoid activating Factory during normal use.
