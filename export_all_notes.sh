#!/usr/bin/env sh

set -euo pipefail

notes_dump=~/Documents/notes_dump

[[ -d  $notes_dump ]] || mkdir $notes_dump

IFS=$'\n'
for n in $(./list_all_notes.applescript | sed -e 's/, /\n/g' | head -3); do
    ./dump_note.applescript $n
    mv ~/Documents/${n}.docx $notes_dump
done
