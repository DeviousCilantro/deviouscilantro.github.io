#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/cv"
latexmk -pdf cv.tex
mkdir -p "$ROOT/static/assets/pdf"
cp cv.pdf "$ROOT/static/assets/pdf/archisman-dutta-cv.pdf"
