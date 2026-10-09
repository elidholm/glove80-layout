# Edvin's Glove80 layout

Personal ZMK keymap for a MoErgo Glove80 used with Swedish (`sv-SE`) input on Ubuntu Linux. The layout keeps QWERTY and home-row mods, and adds layers for symbols, navigation, numbers/function keys, command prefixes, and mouse control.

## Files

- [`config/glove80.keymap`](config/glove80.keymap) is the ZMK keymap exported from the MoErgo Layout Editor and used by this repository's builds.
- [`config/keymap.json`](config/keymap.json) is the matching editor backup. Its format is experimental; retain the exported file unchanged when possible.
- [`config/glove80.conf`](config/glove80.conf) enables ZMK pointing-device support required by the Mouse layer.
- [`docs/layers.md`](docs/layers.md) documents this layout's actual layer maps, thumb access, home-row mods, and text macros.
- [`docs/recovery.md`](docs/recovery.md) covers editor exports, GitHub builds, firmware downloads, and flashing both halves.

## Build and install

Pushing a change to GitHub starts the **Build** workflow. Download `glove80.uf2` from the completed workflow run's artifact and follow [`docs/recovery.md`](docs/recovery.md) to install it.

For a local Docker build on Linux, run `./build.sh`; optionally pass the MoErgo ZMK branch or tag as its first argument. The build script use the checked-in keymap and configuration.

## Editing and backups

The MoErgo Layout Editor is the source of truth for editing this layout. After changing it, export the keymap DTSI and replace `config/glove80.keymap`; export JSON and replace `config/keymap.json` as a paired backup. Keep the pointing setting enabled in `config/glove80.conf` when rebuilding.

See [the personal layer map](docs/layers.md) before changing layer access or macros. Build and test a change before relying on it; keep a known-good UF2 as described in [`docs/recovery.md`](docs/recovery.md).
