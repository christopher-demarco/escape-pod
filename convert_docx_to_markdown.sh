#!/usr/bin/env sh

set -eu -o pipefail

noteTitle=$1
pandoc ${noteTitle}.docx -f docx -t markdown --extract-media=${noteTitle}_media -o ${noteTitle}.md
