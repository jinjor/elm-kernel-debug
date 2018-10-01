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

target_module=0.19.0/package/$author/$package
target_dir=$target_module/$version
rm -rf $target_dir
mkdir -p $target_dir
cp -r $package/* $target_dir

cd app
rm -rf ./elm-stuff
elm make src/Main.elm --output=../index.html
cd $here

number_of_versions=`ls $target_module | wc -w | tr -d '[:space:]'`

if [ $number_of_versions -gt 1 ]
  then
  echo ""
  echo "[WARNING] $number_of_versions versions of $package were found at $target_module:"
  ls $target_module
  echo "Your modified code may not be compiled in."
  echo "Consider modifying the version in $package/elm.json"
fi
