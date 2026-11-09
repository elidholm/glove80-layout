{ source ? ../src, test ? "modifiers/rgb-renderer", half ? "lh" }:
let
  firmware = import source {};
  pkgs = import (source + "/nix/pinned-nixpkgs.nix") {};
in
(firmware.zmk.override { board = "native_posix_64"; }).overrideAttrs (old:
let
  testSource = if test == "modifiers/rgb-renderer" then pkgs.runCommand "source" {} ''
    cp -r ${old.src} $out
    chmod -R u+w $out
    cp ${../config/modifier-lighting.dtsi} $out/app/tests/${test}/modifier-lighting.dtsi
    {
      echo '/ { underglow-layer {'
      sed -n '/pixel-lookup =/,/;/p' $out/app/boards/arm/glove80/glove80_${half}.dts
      echo '}; };'
    } >> $out/app/tests/${test}/native_posix_64.keymap
  '' else old.src;
in {
  src = testSource;
  nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.gcc ];
  cmakeFlags = [
    "-DZEPHYR_BASE=${firmware.zephyr}/zephyr"
    "-DBOARD=native_posix_64"
    "-DZEPHYR_TOOLCHAIN_VARIANT=host"
    "-DCMAKE_C_COMPILER=${pkgs.gcc}/bin/gcc"
    "-DCMAKE_CXX_COMPILER=${pkgs.gcc}/bin/g++"
    "-DZMK_CONFIG=${testSource}/app/tests/${test}"
    "-DDTC_OVERLAY_FILE=${testSource}/app/boards/native_posix_64.overlay;${testSource}/app/tests/${test}/native_posix_64.keymap"
    "-DCONFIG_ASSERT=y"
    "-DZEPHYR_MODULES=${pkgs.lib.concatStringsSep ";" old.passthru.zephyrModuleDeps}"
  ] ++ pkgs.lib.optional (builtins.pathExists (source + "/app/tests/${test}/mock"))
    "-DZMK_EXTRA_MODULES=${testSource}/app/tests/${test}/mock";
  installPhase = ''
    mkdir -p $out
    ./zephyr/zmk.exe > $out/full.log || {
      cat $out/full.log
      exit 1
    }
    sed -e 's/.*> //' $out/full.log |
      sed -n -f ${testSource}/app/tests/${test}/events.patterns > $out/events.log
    diff -u ${testSource}/app/tests/${test}/keycode_events.snapshot $out/events.log
  '';
})
