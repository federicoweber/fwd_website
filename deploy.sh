#!/usr/bin/env bash
#
# Deploy the main site to GitHub Pages, publishing the sibling projects in this
# folder as sub-sites under /projects/<slug>/:
#
#   fwd_website       -> https://federicoweber.com/
#   md_labels_maker   -> https://federicoweber.com/projects/minidisc-labels/
#   spotify_recorder  -> https://federicoweber.com/projects/album-sequencer/
#
# Each sub-project is built with its Vite `base` set to the sub-path (so asset
# URLs resolve correctly), then its dist/ is copied into the main site's
# dist/projects/<slug>/. Everything ships in a single gh-pages commit.
#
# Usage:
#   npm run deploy          # build everything and push to GitHub Pages
#   DRY_RUN=1 npm run deploy # build everything into dist/ but skip the push

set -euo pipefail

# Resolve paths relative to this script so it works from any CWD.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # fwd_website/
PARENT="$(cd "$ROOT/.." && pwd)"                        # fwd_projects/
DIST="$ROOT/dist"

# Build a sibling project for a /projects/<slug>/ sub-path and copy it into the
# main dist/. Any trailing args are passed to `env` for the build command — used
# to override build-time VITE_* variables (e.g. to keep personal credentials out
# of a public bundle).
build_subproject() {
  local folder="$1" slug="$2"; shift 2
  local src="$PARENT/$folder"
  local base="/projects/$slug/"
  local out="$DIST/projects/$slug"

  echo "==> [$folder] building for base $base"
  [ -d "$src/node_modules" ] || ( cd "$src" && npm install )
  ( cd "$src" && env "$@" npm run build -- --base="$base" )

  echo "==> [$folder] copying dist/ -> projects/$slug/"
  rm -rf "$out"
  mkdir -p "$out"
  cp -R "$src/dist/." "$out/"
}

echo "==> building main site"
npm run build   # outputs to dist/ (incl. CNAME + .nojekyll from public/)

build_subproject md_labels_maker minidisc-labels

# Spotify: blank the personal Client ID and the 127.0.0.1 redirect URI so they
# are not baked into the public bundle. Visitors supply their own via the app UI.
build_subproject spotify_recorder album-sequencer \
  VITE_SPOTIFY_CLIENT_ID= VITE_SPOTIFY_REDIRECT_URI=

if [ "${DRY_RUN:-}" = "1" ]; then
  echo "==> DRY_RUN=1: skipping push. Assembled site is in $DIST"
  exit 0
fi

echo "==> deploying dist/ to federicoweber.github.io (master)"
npx gh-pages -d dist -b master -t -r git@github.com:federicoweber/federicoweber.github.io.git

echo "==> done"
echo "    https://federicoweber.com/"
echo "    https://federicoweber.com/projects/minidisc-labels/"
echo "    https://federicoweber.com/projects/album-sequencer/"
