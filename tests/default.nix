{ source ? ../src, test ? "modifiers/rgb-state" }:
let
  firmware = import source {};
  pkgs = import (source + "/nix/pinned-nixpkgs.nix") {};
in
(firmware.zmk.override { board = "native_posix_64"; }).overrideAttrs (old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.gcc ];
  cmakeFlags = [
    "-DZEPHYR_BASE=${firmware.zephyr}/zephyr"
    "-DBOARD=native_posix_64"
    "-DZEPHYR_TOOLCHAIN_VARIANT=host"
    "-DCMAKE_C_COMPILER=${pkgs.gcc}/bin/gcc"
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc}/bin/g++"
    "-DZMK_CONFIG=${old.src}/app/tests/${test}"
    "-DDTC_OVERLAY_FILE=${old.src}/app/boards/native_posix_64.overlay;${old.src}/app/tests/${test}/native_posix_64.keymap"
    "-DCONFIG_ASSERT=y"
    "-DZEPHYR_MODULES=${pkgs.lib.concatStringsSep ";" old.passthru.zephyrModuleDeps}"
  ] ++ pkgs.lib.optional (builtins.pathExists (source + "/app/tests/${test}/mock"))
    "-DZMK_EXTRA_MODULES=${old.src}/app/tests/${test}/mock";
  installPhase = ''
    mkdir -p $out
    ./zephyr/zmk.exe > $out/full.log
    sed -e 's/.*> //' $out/full.log |
      sed -n -f ${old.src}/app/tests/${test}/events.patterns > $out/events.log
    diff -u ${old.src}/app/tests/${test}/keycode_events.snapshot $out/events.log
  '';
})
