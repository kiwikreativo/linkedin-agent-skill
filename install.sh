#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
scope=${1:-global}

case "$scope" in
  --global|global)
    target=${AGENTS_HOME:-"$HOME/.agents"}/skills
    ;;
  --local|local)
    target="$PWD/.agents/skills"
    ;;
  *)
    echo "Usage: $0 [--global|--local]" >&2
    exit 2
    ;;
esac

mkdir -p "$target"
for skill in "$repo_dir"/skills/li-*; do
  [ -d "$skill" ] || continue
  name=${skill##*/}
  rm -rf "$target/$name"
  cp -R "$skill" "$target/$name"
done
echo "Installed LinkedIn skills to $target"
