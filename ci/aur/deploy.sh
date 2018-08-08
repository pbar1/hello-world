#!/bin/bash
set -e

cd "$TRAVIS_BUILD_DIR/ci/aur"

mkdir -p "$HOME/.ssh"
cat "./sshconfig" >> "$HOME/.ssh/config"

git clone ssh://aur@aur.archlinux.org/pbar-hello-world-bin.git

export VERSION=$(echo "$TRAVIS_TAG" | tr -d v)
sed -i "s/VERSION/$VERSION/g" PKGBUILD .SRCINFO

# curl -s https://api.github.com/repos/pbar1/hello-world/releases/$TRAVIS_TAG \
# | grep "https://github.com/pbar1/hello-world/releases/download" \
# | grep "linux" \
# | cut -d : -f 2,3 \
# | tr -d \" \
# | wget -qi - -O hello-world

# export CHECKSUM=$(sha256sum hello-world | cut -d ' ' -f 1)
# sed -i "s/CHECKSUM/$CHECKSUM/g" PKGBUILD .SRCINFO

# git git add PKGBUILD .SRCINFO
# git commit -m "Deployed $TRAVIS_TAG from Travis CI"
# git push
