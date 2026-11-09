#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/backup_demo"
SRC="$BASE/data/"
DEST="$BASE/backups"
LOG="$BASE/backup.log"
STAMP=$(date +%Y-%m-%d_%H-%M-%S)
LATEST="$DEST/latest"


mkdir -p "$DEST"
echo "[$(date '+%F %T')] Backup started" >> "$LOG"

if [ -e "$LATEST" ]; then
  rsync -a --delete --link-dest="$LATEST/" "$SRC" "$DEST/$STAMP/" >> "$LOG" 2>&1
else
  rsync -a --delete "$SRC" "$DEST/$STAMP/" >> "$LOG" 2>&1
fi


ln -sfn "$DEST/$STAMP" "$LATEST"
echo "[$(date '+%F %T')] Backup finished: $STAMP" >> "$LOG"


