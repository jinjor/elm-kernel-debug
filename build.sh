#!/bin/bash

set -e

author=elm
package=virtual-dom
repo=https://github.com/$author/$package.git

if [ ! -e $package ]; then
  git clone $repo
fi

cd `dirname $0`
here=`pwd`
export ELM_HOME=$here

cd $package
version=`cat elm.json | jq -e .version | tr -d '"'`
rm -rf ./elm-stuff
elm make --docs=documentation.json
cd $here

target_dir=0.19.0/package/$author/$package/$version
rm -rf $target_dir
mkdir -p $target_dir
cp -r $package/* $target_dir

cd app
rm -rf ./elm-stuff
elm make src/Main.elm
cd $here
