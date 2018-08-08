#!/bin/bash
set -e

cd "$TRAVIS_BUILD_DIR/ci/aur"

mkdir -p "$HOME/.ssh"
cat sshconfig >> "$HOME/.ssh/config"
openssl aes-256-cbc -K $encrypted_0df9e98ee504_key -iv $encrypted_0df9e98ee504_iv -in aur.enc -out "$HOME/.ssh/aur" -d
ssh-keyscan aur.archlinux.org >> "$HOME/.ssh/known_hosts"
echo "Configured SSH access to AUR"

git clone ssh://aur@aur.archlinux.org/pbar-hello-world-bin.git

export VERSION=$(echo "$TRAVIS_TAG" | tr -d v)
sed -i "s/VERSION/$VERSION/g" PKGBUILD .SRCINFO
echo "Replaced VERSION"

curl -s https://api.github.com/repos/pbar1/hello-world/releases/$TRAVIS_TAG \
| grep "https://github.com/pbar1/hello-world/releases/download" \
| grep "linux" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O hello-world
echo "Downloaded release from GitHub"

export CHECKSUM=$(sha256sum hello-world | cut -d ' ' -f 1)
sed -i "s/CHECKSUM/$CHECKSUM/g" PKGBUILD .SRCINFO
echo "Replaced CHECKSUM"

git git add PKGBUILD .SRCINFO
git commit -m "Deployed $TRAVIS_TAG from Travis CI"
git push
echo "Pushed to AUR"