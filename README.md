# Edvin's Glove80 layout

Personal ZMK keymap for a MoErgo Glove80 used with Swedish (`sv-SE`) input on Ubuntu Linux. The layout keeps QWERTY and home-row mods, and adds layers for symbols, navigation, numbers/function keys, command prefixes, and mouse control.

## Files

- [`config/glove80.keymap`](config/glove80.keymap) is the ZMK keymap exported from the MoErgo Layout Editor and used by this repository's builds.
- [`config/keymap.json`](config/keymap.json) is the matching editor backup. Its format is experimental; retain the exported file unchanged when possible.
- [`config/glove80.conf`](config/glove80.conf) enables pointing and PR36 layer RGB.
- [`config/modifier-lighting.dtsi`](config/modifier-lighting.dtsi) defines Base indicators and semantic Numbers/Symbols/Workbench colors, included by both editor backups.
- [`config/firmware-revision`](config/firmware-revision) pins community PR36; [`patches/modifier-rgb.patch`](patches/modifier-rgb.patch) adds physical-key RGB predicates and split synchronization.
- [`docs/layers.md`](docs/layers.md) documents this layout's actual layer maps, thumb access, home-row mods, and text macros.
- [`docs/recovery.md`](docs/recovery.md) covers editor exports, GitHub builds, firmware downloads, and flashing both halves.

## Build and install

Pushing a change to GitHub starts the **Build** workflow. Download `modifier-lighting.uf2` from the completed workflow run's artifact and follow [`docs/recovery.md`](docs/recovery.md) to install it. The existing `glove80.uf2` is not overwritten.

For a local Docker build on Linux, run `./build.sh`. Local and CI builds use the same pinned, patched community firmware; revision arguments are intentionally rejected.

Select **layer RGB** with the existing Magic-layer effect control to enable the indicators on **Base only**. Shift is cyan, Ctrl green, Left Alt orange, AltGr magenta, and GUI yellow. Listed physical keys light their groups immediately, including ordinary letter taps; macro-generated modifiers do not. Normal RGB effects do not show these indicators. See [the indicator map and controls](docs/layers.md#modifier-lighting).

The same effect automatically shows semantic colors on **Numbers, Symbols, and Workbench**. Digits, symbol families, Git/Docker/build commands, and function keys have distinct colors. Inherited transparent keys stay dark. See the [approved palette and inventory](docs/layers.md#semantic-layer-lighting); no extra RGB effect or key bindings are required.

## Editing and backups

The MoErgo Layout Editor is the source of truth for editing this layout. After changing it, export the keymap DTSI and replace `config/glove80.keymap`; export JSON and replace `config/keymap.json` as a paired backup. Preserve `#include "modifier-lighting.dtsi"` in Custom Device-tree and both settings in `config/glove80.conf`. Build here: the hosted community firmware does not contain this repository's modifier-state extension or include file.

See [the personal layer map](docs/layers.md) before changing layer access or macros. Build and test a change before relying on it; keep a known-good UF2 as described in [`docs/recovery.md`](docs/recovery.md).
