#!/bin/bash

for i in podman image skopeo storage shortnames; do
  version=$(curl -sSL https://api.github.com/repos/containers/${i}/releases | jq -r '.[0].tag_name')
  printf "%s: %s\n" "$i" "$version"
done
