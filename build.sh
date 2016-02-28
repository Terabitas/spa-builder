#!/bin/bash -e

source /env.sh

# Build
cd $pkgPathContainer
git init
git add --all .
git commit -m"Auto"
/go/bin/godep save ./...
git add --all .
git commit -a -m"Auto"

echo "Building [$1] within [$2]"
`CGO_ENABLED=${CGO_ENABLED:-0} go build -a --installsuffix cgo --ldflags="${LDFLAGS:--s}" $2`

# Grab the last segment from the package name
name=${1##*/}

if [ -e "/var/run/docker.sock" ] && [ -e "$pkgPathContainer/Dockerfile" ];
then
  cd $pkgPathContainer

  # Default TAG_NAME to package name if not set explicitly
  tagName=${tagName:-"$name":latest}

  # Build the image from the Dockerfile in the package directory
  docker build -t $3 .
fi
