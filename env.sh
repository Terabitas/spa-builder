#!/bin/bash

appToBuild="$1"
containerToBuild="$2"
tagName="$3"

# Grab just first path listed in GOPATH
goPath="${GOPATH%%:*}"

# For private repos
#git config --global url."git@bitbucket.org:".insteadOf "https://bitbucket.org/"
git config --global user.email "go@nildev.io"
git config --global user.name "nildev"

# Construct Go package path
pkgPathApp="$goPath/src/$2/app"
pkgPathContainer="$goPath/src/$2"

# Construct path to mounted src for local builds
localPkgPathApp="/app-src"
localPkgPathContainer="/src/$2"

if [ ! -d "$localPkgPathContainer" ]; then
    echo "Get $2"
    go get -d $2
else
    echo "cp -r $localPkgPathContainer/. $pkgPathContainer/"
    mkdir -p $pkgPathContainer
    cp -r $localPkgPathContainer/. $pkgPathContainer/
    echo "$localPkgPathContainer copy to $pkgPathContainer"
fi
cd $pkgPathContainer
/go/bin/godep restore

# Fetch app
if [ ! -d "$localPkgPathApp" ]; then
    echo "git clone $1 $pkgPathApp"
    git clone $1 $pkgPathApp
else
    echo "cp -r $localPkgPathApp $pkgPathApp"
    cp -r $localPkgPathApp $pkgPathApp
fi
