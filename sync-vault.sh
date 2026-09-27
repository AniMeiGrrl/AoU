#!/bin/sh
set -eu

VAULT="../Age of Umbra"

for folder in Attachments Items Lore Organizations People Places Sessions "Spells and Abilities"; do
  rsync -a --delete --exclude="Party Portrait.png" "$VAULT/$folder/" "content/$folder/"
done

python3 - <<'PYTHON'
from pathlib import Path
from datetime import date, datetime
import re
sessions = sorted(Path("content/Sessions").glob("????-??-?? Game Notes.md"))
if sessions:
    latest = sessions[-1].stem
    session_date = datetime.strptime(latest[:10], "%Y-%m-%d")
    label = f"{session_date:%B} {session_date.day}, {session_date.year}"
    today = date.today()
    updated = f"{today:%B} {today.day}, {today.year}"
    homepage = Path("content/index.md")
    text = homepage.read_text()
    text = re.sub(r"^\*\*Latest session:\*\*.*$", f"**Latest session:** [[{latest}|{label}]]  ", text, flags=re.M)
    text = re.sub(r"^\*\*Last updated:\*\*.*$", f"**Last updated:** {updated}", text, flags=re.M)
    homepage.write_text(text)
PYTHON

echo "Age of Umbra content synchronized."
