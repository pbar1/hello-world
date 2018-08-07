#!/bin/bash
set -e

cd "$TRAVIS_BUILD_DIR/ci/choco"

cp "$TRAVIS_BUILD_DIR/bin/*.exe" hello-world.exe
cp "$TRAVIS_BUILD_DIR/LICENSE" LICENSE.txt
export VERSION=$(cat "$TRAVIS_BUILD_DIR/.version")
sed -i "s/VERSION/$VERSION/g" "*.nuspec"

function choco(){ sudo docker run --rm -v "$(pwd)":"$(pwd)" -w "$(pwd)" linuturk/mono-choco "$@" ;}
choco pack
choco push -s https://push.chocolatey.org/ -k "$CHOCO_API_KEY" --what-if
