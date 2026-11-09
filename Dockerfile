FROM nixpkgs/nix:nixos-23.11

ENV PATH=/root/.nix-profile/bin:/usr/bin:/bin

RUN <<EOF
    set -euo pipefail
    nix-env -iA cachix -f https://cachix.org/api/v1/install
    cachix use moergo-glove80-zmk-dev
    mkdir /config
    # Mirror ZMK repository to make it easier to reference both branches and
    # tags without remote namespacing
    git clone --mirror https://github.com/moergo-sc/zmk /zmk
    GIT_DIR=/zmk git worktree add --detach /src
EOF

ARG FIRMWARE_REVISION
ENV FIRMWARE_REVISION=$FIRMWARE_REVISION

# Cache dependencies for the exact community base used by both local and CI builds.
RUN <<EOF
    cd /src
    git fetch origin "$FIRMWARE_REVISION" || exit
    git checkout -q --detach "$FIRMWARE_REVISION" || exit
    nix-shell --run true -A zmk ./default.nix
EOF

COPY --chmod=755 <<EOF /bin/entrypoint.sh
#!/usr/bin/env bash
    set -euo pipefail
    if [[ \$(< /config/config/firmware-revision) != \$FIRMWARE_REVISION ]]; then
      echo 'Firmware pin changed; rebuild the image with ./build.sh.' >&2
      exit 1
    fi

    cd /src
    git apply --check /config/patches/modifier-rgb.patch
    git apply /config/patches/modifier-rgb.patch

    echo 'Building Glove80 firmware' >&2
    cd /config
    nix-build ./config --arg firmware 'import /src/default.nix {}' -j2 -o /tmp/combined --show-trace
    install -o "\$UID" -g "\$GID" /tmp/combined/glove80.uf2 ./modifier-lighting.uf2
EOF

ENTRYPOINT ["/bin/entrypoint.sh"]

# Run build.sh to use this file
