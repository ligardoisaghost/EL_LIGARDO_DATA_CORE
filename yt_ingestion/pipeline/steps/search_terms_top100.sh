#!/usr/bin/env bash
set -e

# Use the latest DAILY processed file
INPUT_FILE=$(ls data/processed | grep 'YT_ANALYTICS_DAILY_' | sort | tail -1)
INFILE="data/processed/$INPUT_FILE"

OUT_DIR="public_exports"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/search_terms_top100_$(date +%Y%m%d).json"

echo "[RUN] Search-term frequency from $INFILE"

# If DAILY file is missing or empty, bail cleanly
if [ ! -s "$INFILE" ]; then
  echo "[WARN] $INFILE is empty or missing; writing empty search-term summary"
  echo "[]" > "$OUT"
  echo "[DONE] Search-term summary (empty) written to $OUT"
  exit 0
fi

# Each line is JSON like:
# {"date": "...", "content_id": "...", "title": "...", "views": ...}
# We build a bag-of-words over titles.

jq -s '
  # Grab titles as strings
  map(.title // "") |

  # Normalize: lowercase, strip non-alphanumeric to spaces
  map(ascii_downcase | gsub("[^a-z0-9 ]"; " ")) |

  # Split into words & flatten
  map(split(" ")) | flatten |

  # Drop blanks
  map(select(. != "")) |

  # Filter out boring stopwords / junk
  map(
    select(. as $w |
      [
        "the","and","for","you","your","with","that",
        "this","from","are","was","just","have","has",
        "short","shorts","official","video","music"
      ] | index($w) | not)
  ) |

  # Group + count
  group_by(.) |
  map({ term: .[0], count: length }) |

  # Sort descending and take top 100
  sort_by(-.count) |
  .[0:100]
' "$INFILE" > "$OUT"

echo "[DONE] Wrote search-term summary to $OUT"
