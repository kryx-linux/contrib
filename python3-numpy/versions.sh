#!/bin/bash

source Pkgfile

prt-get depinst git 2>/dev/null 1>/dev/null

git clone https://github.com/numpy/numpy.git --branch v$version 2>/dev/null 1>/dev/null
(
  cd numpy
  git submodule status --recursive | while read -r commit _path _; do
    module="$(basename $_path)"
    echo "_${module//-/_}=${commit:1:40}"
  done
  git submodule status --recursive | while read -r _ _path _; do
    echo $_path
  done
)

rm -rf numpy
