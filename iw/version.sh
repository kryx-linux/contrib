#!/bin/sh

VERSION="0.9.9"
OUT="version.h"

echo "#define IW_VERSION \"$VERSION-nogit\"" > "$OUT"
