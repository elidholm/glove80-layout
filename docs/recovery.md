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
4. Confirm that `HID_POINTING` remains enabled in the editor. Keep `CONFIG_ZMK_POINTING=y` and `CONFIG_EXPERIMENTAL_RGB_LAYER=y` in `config/glove80.conf`.
5. Review `docs/layers.md` if you changed layer access, key assignments, modifiers, macros, or settings.
6. Build and test the new firmware before treating it as a recovery version.

Do not hand-edit the editor JSON schema. The editor marks that format experimental and does not guarantee that old JSON will always import.

Preserve `#include "modifier-lighting.dtsi"` in Custom Device-tree. That supported text field is recorded identically in the DTSI and JSON; the included file lives beside the keymap in this repository. Export key assignments from the editor, then build locally or in Actions. The hosted compiler cannot supply this repository's include file or modifier-state patch merely by selecting `community.pr36.per-key-rgb`. An actual editor import/export round-trip remains a manual acceptance check.

## GitHub Actions build

The `.github/workflows/build.yml` workflow runs on pushes, pull requests, and manual dispatch. It reads `config/firmware-revision`, checks out that immutable community PR36 revision, applies `patches/modifier-rgb.patch`, runs native modifier/RGB tests, and builds both halves. It uploads their combined `modifier-lighting.uf2`.

To download a build:

1. Open the repository's **Actions** tab and select a successful **Build** run.
2. Download the `modifier-lighting.uf2` artifact.
3. Retain a known-good copy locally; workflow artifacts may expire.

The community base is `22d6941d055bf05f006c9d4d7088e9564d31ba3a` from [moergo-sc/zmk#36](https://github.com/moergo-sc/zmk/pull/36), which was unmerged when inspected. The [TailorKey RGB guide](https://sites.google.com/view/tailorkey/how-to/rgb) explains why stock firmware is insufficient. Our patch follows PR36's conditional lock-indicator behavior but reads effective HID modifiers, including implicit/masked state, and synchronizes them to the other half. It does not change hold-tap decisions or key output.

Primary implementation references at that revision: [conditional RGB indicators](https://github.com/moergo-sc/zmk/blob/22d6941d055bf05f006c9d4d7088e9564d31ba3a/app/src/behaviors/behavior_underglow_indicators.c), [effective HID modifier calculation](https://github.com/moergo-sc/zmk/blob/22d6941d055bf05f006c9d4d7088e9564d31ba3a/app/src/hid.c), [global split behavior dispatch](https://github.com/moergo-sc/zmk/blob/22d6941d055bf05f006c9d4d7088e9564d31ba3a/app/src/behavior.c), and the [left](https://github.com/moergo-sc/zmk/blob/22d6941d055bf05f006c9d4d7088e9564d31ba3a/app/boards/arm/glove80/glove80_lh.dts)/[right](https://github.com/moergo-sc/zmk/blob/22d6941d055bf05f006c9d4d7088e9564d31ba3a/app/boards/arm/glove80/glove80_rh.dts) LED lookup tables.

The patch also refreshes layer colors on RGB-on/effect selection so a modifier already held is visible immediately. Explicit off retains PR36's layer-enable guard; existing brightness/status/battery rendering remains in place. Updating the base requires reviewing/reapplying the patch and rerunning tests, not just changing the revision text.

## Local build

On Linux with Docker installed:

```bash
./build.sh
```

The resulting `modifier-lighting.uf2` is written to the repository root, leaving the known-good `glove80.uf2` untouched. The script builds the checked-in keymap/configuration and fails if the pinned extension cannot be applied. Arbitrary branch/tag arguments are no longer supported.

For native tests with Nix and a checkout at `src/` prepared exactly as in Actions:

```bash
nix-build tests --argstr test modifiers/rgb-state --no-out-link
nix-build tests --argstr test modifiers/rgb-renderer --no-out-link
```

These compile real ZMK HID/behavior code. The renderer test records frames through a test LED device and emulated power GPIO; it is not a physical keyboard test. The tests/fixtures are carried inside the firmware patch.

## Flash both halves

Have a spare keyboard or on-screen keyboard available. Use a USB data cable and flash the **same combined UF2** to both halves, right half first.

### Right half

1. Switch the right half off and connect it to the computer over USB.
2. Hold physical positions `RH C6R6` and `RH C3R3` while switching the half on. These positions are the bootloader chord regardless of the current keymap.
3. Wait for the `GLV80RHBOOT` USB volume, then copy `modifier-lighting.uf2` onto it.
4. Wait for the volume to disappear as the half reboots.

### Left half

1. Switch the left half off and connect it to the computer over USB.
2. Hold physical positions `LH C6R6` and `LH C3R3` while switching the half on.
3. Copy the same `modifier-lighting.uf2` onto the `GLV80LHBOOT` volume.
4. Wait for the volume to disappear as the half reboots.

The power-up bootloader chords work independently of the running keymap and are the preferred recovery method. Avoid unplugging or powering off during the firmware copy.

To roll back, flash the preserved known-good `glove80.uf2` to both halves using the same procedure.

## Modifier-lighting hardware acceptance

Select layer RGB using the [existing controls](layers.md#modifier-lighting), then compare LEDs with Linux key events using `sudo evtest` on the Glove80 keyboard device:

1. Tap J normally: it types J without creating Shift indication. Hold J as a resolved Shift: F/J and both T1 thumbs turn cyan. A direct thumb Shift should produce the same lighting.
2. Hold L as AltGr: L/RH T6 turn magenta, not S/LH T6. Check every group in the indicator map.
3. Hold both Shifts, then release either one first; the group stays lit until the other releases. Repeat Ctrl and mixed-modifier chords. Check across both halves.
4. Change functional layers while holding. Toggle RGB off: modifier changes must not wake it. Toggle back on while held: the current indicators should appear. Release: those indicators return to black.
5. Verify existing system status, brightness, and battery behavior. Disconnect/reconnect the right half while holding a left-side modifier; confirm no stuck or missing indicators after resynchronization.
6. With the host set to Swedish, verify shifted letters and AltGr+2 producing `@` in a text field. `evtest` reports keycodes, not the host's character translation.

Physical LED positions, Bluetooth reconnection, Swedish text output, and editor round-tripping must be checked on the actual device/editor before calling this firmware known-good. No automated test establishes those facts.

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
