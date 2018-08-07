#!/bin/bash
set -e

cd "$TRAVIS_BUILD_DIR/ci/choco"

cp "$TRAVIS_BUILD_DIR/LICENSE" LICENSE.txt
export VERSION=$(echo "$TRAVIS_TAG" | tr -d v)
sed -i "s/VERSION/$VERSION/g" "hello-world.nuspec"

curl -s https://api.github.com/repos/pbar1/hello-world/releases/$TRAVIS_TAG \
| grep "https://github.com/pbar1/hello-world/releases/download" \
| grep "windows" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O hello-world.exe

function choco(){ sudo docker run --rm -v "$(pwd)":"$(pwd)" -w "$(pwd)" linuturk/mono-choco "$@" ;}
choco pack
choco push -s https://push.chocolatey.org/ -k "$CHOCO_API_KEY" --what-if
