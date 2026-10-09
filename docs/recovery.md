# Editing, building, and restoring this Glove80

This repository is for one MoErgo Glove80 layout: Edvin's Swedish `sv-SE` developer keymap. It does not define a general-purpose ZMK configuration for other keyboards.

## Keep the exports in sync

The MoErgo Layout Editor is the source of truth for editing. The repository keeps two exports:

- `config/keymap.json`: editor backup. JSON import/export is experimental in MoErgo; keep a copy of each known-good export.
- `config/glove80.keymap`: ZMK keymap DTSI consumed by the build.

To update the repository after changing the layout:

1. Save a copy of both current files.
2. In the editor, export the keymap DTSI and JSON.
3. Replace `config/glove80.keymap` and `config/keymap.json` with the matching exports.
4. Confirm that `HID_POINTING` remains enabled in the editor and that `config/glove80.conf` contains `CONFIG_ZMK_POINTING=y`.
5. Review `docs/layers.md` if you changed layer access, key assignments, modifiers, macros, or settings.
6. Build and test the new firmware before treating it as a recovery version.

Do not hand-edit the editor JSON schema. The editor marks that format experimental and does not guarantee that old JSON will always import.

## GitHub Actions build

The `.github/workflows/build.yml` workflow runs on pushes, pull requests, and manual dispatch. It checks out this repository and the MoErgo ZMK `main` branch, builds both Glove80 halves, combines them, and uploads `glove80.uf2`.

To download a build:

1. Open the repository's **Actions** tab and select a successful **Build** run.
2. Download the `glove80.uf2` artifact.
3. Retain a known-good copy locally; workflow artifacts may expire.

The workflow currently tracks `moergo-sc/zmk` at `main`, so rebuilding the same keymap later may use newer firmware. For a repeatable historical build, retain the released UF2 and record the ZMK revision used by that build. Do not assume that a new build is identical just because the keymap did not change.

## Local build

On Linux with Docker installed:

```bash
./build.sh
```

Pass a MoErgo ZMK branch or tag as the optional first argument to select a revision. The resulting `glove80.uf2` is written to the repository root. `build.bat` is the Windows counterpart. These scripts build from the checked-in `config/glove80.keymap` and `config/glove80.conf`.

## Flash both halves

Have a spare keyboard or on-screen keyboard available. Use a USB data cable and flash the **same combined UF2** to both halves, right half first.

### Right half

1. Switch the right half off and connect it to the computer over USB.
2. Hold physical positions `RH C6R6` and `RH C3R3` while switching the half on. These positions are the bootloader chord regardless of the current keymap.
3. Wait for the `GLV80RHBOOT` USB volume, then copy `glove80.uf2` onto it.
4. Wait for the volume to disappear as the half reboots.

### Left half

1. Switch the left half off and connect it to the computer over USB.
2. Hold physical positions `LH C6R6` and `LH C3R3` while switching the half on.
3. Copy the same `glove80.uf2` onto the `GLV80LHBOOT` volume.
4. Wait for the volume to disappear as the half reboots.

The power-up bootloader chords work independently of the running keymap and are the preferred recovery method. Avoid unplugging or powering off during the firmware copy.

## Mouse support and first-use checks

This keymap adds mouse HID support. After the first firmware with pointing support is installed, the host must recognize the changed HID report descriptor: reboot Ubuntu when using USB, or remove/re-pair the keyboard when using Bluetooth.

After flashing, check:

- Base typing and Swedish characters, including dead-key macros.
- Every momentary layer returns to Base when its hold key is released.
- Workbench macros insert text but do not submit it.
- Mouse movement, scrolling, and buttons work after the host refresh/re-pair.
- The Magic bootloader and output-selection actions are reachable.

Keep the paired JSON/DTSI exports and a verified UF2 from the same layout revision. Tag known-good repository states and attach their UF2 to a GitHub Release if they should remain available beyond Actions artifact retention.

## Using this layout with another keyboard

This firmware is built specifically for Glove80 left and right halves. The editor JSON and keymap DTSI are not universal keyboard formats. For another ZMK keyboard, port the behavior and layer design into that keyboard's own configuration, adapting physical key positions, available keys, pointing support, and build targets. For another Glove80, the combined UF2 can be installed directly, but Bluetooth pairing state is not transferred with the keymap.
