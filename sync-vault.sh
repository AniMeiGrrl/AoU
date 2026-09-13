#!/bin/sh
set -eu

VAULT="../Age of Umbra"

for folder in Attachments Items Lore Organizations People Places Sessions "Spells and Abilities"; do
  rsync -a --delete "$VAULT/$folder/" "content/$folder/"
done

echo "Age of Umbra content synchronized."
