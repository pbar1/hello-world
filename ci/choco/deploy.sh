#!/bin/bash

cd "$(dirname "$0")"
function choco(){ sudo docker run --rm -v $(pwd):$(pwd) -w $(pwd) linuturk/mono-choco "$@" ;}
export VERSION=$(cat ../../.version)
cp ../../bin/*.exe hello-world.exe
cp ../../LICENSE LICENSE.txt
sed -i "s/VERSION/$VERSION/g" buildassets/*.nuspec
choco pack
choco push -s https://push.chocolatey.org/ -k "$CHOCO_API_KEY" --what-if
