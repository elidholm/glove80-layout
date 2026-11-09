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

## Modifier lighting

In community PR36 **layer-RGB mode**, the following physical keys select colors immediately while **Base is the highest active typing layer**. Ordinary letter taps also light their group while down; indication does not wait for hold-tap resolution. Macro-generated modifiers do not trigger indication. Lighting never changes what an indicator key does.

| Physical trigger keys | Color | Home-row indicators | Thumb indicators |
| --- | --- | --- | --- |
| F, J, LH T1, RH T1 | Cyan | F and J | LH T1 and RH T1 |
| D, K | Green | D and K | LH T2 and RH T2 |
| S | Orange | S | LH T6 |
| L | Magenta | L | RH T6 |
| A, Ö, RH T3 | Yellow | A and Ö | RH T3 |

Groups combine independently: J+D lights Shift and Ctrl; releasing J leaves Ctrl. A group stays lit until its last physical trigger releases. Inactive keys are black. Leaving Base suppresses all groups; returning to Base shows whichever trigger keys are still physically held, including keys first pressed on another layer. Explicit RGB-off suppresses indication, and normal RGB effects do not display modifier colors. Brightness, system status, and battery protection still use the existing renderer.

The Ctrl/Alt/AltGr thumb positions are **indicator targets, not trigger keys or new modifier bindings**. They still access their existing layers; pressing them leaves Base and therefore suppresses indication.

Hold **Magic** at LH C6R6 to access the existing RGB controls: the Base T position toggles RGB, G advances the effect, R/F increase/decrease brightness. Effects cycle through solid, breathe, spectrum, swirl, and layer RGB; from the default swirl, G once selects layer RGB. Release Magic, then hold Shift to check the colors (repeat the cycle if a different effect was previously saved). The system status display can temporarily cover indications. No key assignments were added for lighting.

This requires the pinned custom build described in [recovery](recovery.md), not just the hosted community selector. See its hardware acceptance checklist before relying on a new UF2.

## Semantic layer lighting

The same layer-RGB effect automatically switches to static semantic colors on Symbols, Numbers, and Workbench; no effect cycling or extra typing layer is needed. The inventories below are the approved specification. All colors are raw RGB values, scaled by the existing brightness renderer.

| Color | RGB | Meaning within the target layer |
| --- | --- | --- |
| Cyan | `00FFFF` | Numbers digits; Symbols punctuation; Workbench Docker |
| Orange | `FF8000` | Numbers/Symbols operators |
| Yellow | `FFFF00` | Numbers decimal point; Workbench Make/Pytest |
| Violet | `8000FF` | Function keys, including generic F13–F16 |
| Green | `00FF00` | Symbols paired delimiters; Workbench Git |
| Magenta | `FF00FF` | Symbols quoting/escaping |
| Dim white | `404040` | Symbols return-to-Base control |

Inherited `&trans` keys remain functional but **dark**, as do disabled and unclassified keys. Explicit black RGB bindings prevent colors leaking from lower active layers. No unclassified explicit assignments remain in these three inventories; F13–F16 are classified only as function keys, not as assumed host actions.

Higher active layers take precedence: Factory > Magic > Mouse > Workbench > Numbers > Navigation > Symbols > Lower > Base. Thus Numbers+Symbols shows Numbers, and adding Workbench shows Workbench. Lower, Navigation, Mouse, Magic, and Factory have no semantic maps and remain unlit apart from existing system-status displays. Returning to Base restores its physical-key indicators for keys still held.

Physical coordinates below follow the keymap's `POS_LH_*`/`POS_RH_*` definitions. Column sequences are listed in the indicated order, not inferred from US keycap legends. Outputs were resolved using standard Swedish `se(basic)` XKB and Compose data (`/usr/share/X11/xkb/symbols/se` and `latin`); a different host variant can change them. Extra held modifiers can also change text; the colors describe each binding's normal, unchorded use.

## Symbols

Hold LH T2. Each row lists physical positions, corresponding bindings/outputs, and its lighting category.

| Physical positions | Binding → Swedish output, in position order | Group/color |
| --- | --- | --- |
| LH C3/C2 R3 | `LS(N8)` / `LS(N9)` → `(` / `)` | Delimiters, green |
| LH C3/C2 R4 | `RA(N8)` / `RA(N9)` → `[` / `]` | Delimiters, green |
| LH C3/C2 R5 | `RA(N7)` / `RA(N0)` → `{` / `}` | Delimiters, green |
| LH C3/C2 R6 | `NON_US_BSLH` / `LS(NON_US_BSLH)` → `<` / `>` | Delimiters, green |
| LH C5R3; LH C1R3; RH C1R3 | `LS(N1)` / `LS(N5)` / `LS(N6)` → `!` / `%` / `&` | Operators, orange |
| LH C1R4; RH C3/C4 R4 | `LS(N0)` / `FSLH` / `MINUS` → `=` / `-` / `+` | Operators, orange |
| LH C5R5; LH C1R5 | `LS(N7)` / `PythonReturn` → `/` / `->` | Operators, orange |
| RH C6R4; RH C4R6 | `Circumflex` / `Tilde` → literal `^` / `~` | Operators, orange |
| LH C6R3 | `BSLH` → apostrophe | Quoting/escaping, magenta |
| RH C2R3; LH C6R4 | `LS(EQUAL)` → dead grave; `Backtick` → literal backtick | Quoting/escaping, magenta |
| RH C5R4; RH C5R5 | `LS(N2)` → double quote; `TrippleQuote` → three double quotes | Quoting/escaping, magenta |
| LH C4R5 | `RA(MINUS)` → backslash | Quoting/escaping, magenta |
| LH C4R3; LH C5/C4 R4 | `RA(N2)` / `LS(N3)` / `RA(N4)` → `@` / `#` / `$` | Punctuation, cyan |
| RH C1R4; RH C1/C2/C3 R5 | `LS(DOT)` / `LS(COMMA)` / `COMMA` / `DOT` → `:` / `;` / `,` / `.` | Punctuation, cyan |
| RH C2R4; RH C4R5 | `LS(FSLH)` / `LS(MINUS)` → `_` / `?` | Punctuation, cyan |
| LH T3 | `&to LAYER_Base` → return to Base | Control, dim white |

All other positions are transparent and dark, including the inherited thumb Shift keys. The categories are deliberate primary classifications: `<`/`>` can also be comparisons, and `^`/`~` have several programming uses.

`Backtick`, `Circumflex`, and `Tilde` emit a dead-key sequence followed by Space, producing the literal character. The separate `LS(EQUAL)` binding leaves a pending dead grave; it is not the literal-backtick macro.

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

Hold LH T6.

| Physical positions | Binding → Swedish output/action, in position order | Group/color |
| --- | --- | --- |
| RH C2/C3/C4 R3 | `N7` / `N8` / `N9` → `7` / `8` / `9` | Digits, cyan |
| RH C1/C2/C3/C4 R4 | `N0` / `N4` / `N5` / `N6` → `0` / `4` / `5` / `6` | Digits, cyan |
| RH C2/C3/C4 R5 | `N1` / `N2` / `N3` → `1` / `2` / `3` | Digits, cyan |
| RH C5 R3/R4/R5 | `LS(N7)` / `LS(BSLH)` / `FSLH` → `/` / `*` / `-` | Operators, orange |
| RH C1R5 | `DOT` → `.` | Decimal, yellow |
| LH C5/C4/C3/C2/C1 R3 | `F1` / `F2` / `F3` / `F4` / `F5` | Function keys, violet |
| LH C5/C4/C3/C2/C1 R4 | `F6` / `F7` / `F8` / `F9` / `F10` | Function keys, violet |
| LH C5/C4 R5 | `F11` / `F12` | Function keys, violet |
| LH C3/C2/C1 R5 | `&none` → disabled | Dark |

All other keys inherit their actions and remain dark, including the physical number row. These are ordinary number-row HID keycodes, not keypad keys; Num Lock does not affect them. There is no dedicated plus binding in this layer; none was added.

## Workbench text macros

Hold RH T6. A macro types the listed text, including the final space. It does **not** press Enter or execute a command. Start at a suitable prompt/cursor position and review the resulting text before running it.

Here `_` denotes the trailing space, not an underscore typed by the macro.

| Physical positions | Expanded macro text/action, in position order | Group/color |
| --- | --- | --- |
| LH C5R3 | `python -m pytest_` | Build/test, yellow |
| LH C4/C3/C2/C1 R3 | `make test_` / `make lint_` / `make check_` / `make fmt_` | Build/test, yellow |
| LH C5R4 | `make ci_` | Build/test, yellow |
| LH C4/C3 R4 | `git status_` / `git diff_` | Git, green |
| RH C1/C2/C3/C4/C5 R3 | `docker ps_` / `docker logs -f_` / `docker exec -it_` / `docker compose_` / `docker inspect_` | Docker, cyan |
| RH C1/C2 R4 | `docker build -t_` / `docker run -rm_` | Docker, cyan |
| RH C3/C4/C5 R4 | `docker compose logs -f_` / `docker compose up_` / `docker compose config_` | Docker, cyan |
| LH C5/C4/C3/C2 R5 | F13 / F14 / F15 / F16 | Generic function keys, violet |

All other positions are transparent and dark. F13–F16 emit the verified function-key codes; their host shortcut meanings have not been established. If they do not reach an application, check its mappings, the terminal, and the firmware's HID report configuration.

The existing `DockerRun` macro emits **`docker run -rm `**, not `docker run --rm `. Its output has deliberately not been corrected as part of this lighting-only change; review it before executing any resulting command.

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
