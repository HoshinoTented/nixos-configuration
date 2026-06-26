#!/usr/bin/env bash

# For other computer that apply local changes on this nix configuration, it should have a "local" branch with upstream "master".
# The "local" branch should have only one commit ahead (easy for rebasing), so this script is used to squash new changes on "local" branch.

set -eu

base="$(git rev-parse HEAD~2)"
master="$(git rev-parse master)"

if [[ "${1:-}" == "-f" ]]
then
    force=true
    echo "Force squashing"
else
    force=false
fi

if [[ "$force" == true || "$base" == "$master" ]]
then
    git reset --soft HEAD~2 && git commit -m "local"
else
    echo "branch master: $master doesn't match grandparent commit: $base, abort"
    exit 1
fi
