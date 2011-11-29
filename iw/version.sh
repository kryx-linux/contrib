#!/bin/sh

VERSION="#VER#"
OUT="$1"

echo '#include "iw.h"' > "$OUT"
echo "const char iw_version[] = \"$VERSION\";" >> "$OUT"

