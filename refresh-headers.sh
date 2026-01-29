#!/usr/bin/env bash

set -euo pipefail

base_dir="$(pwd)"

get_file_date() {
    local file="$1"

    # try birth time
    local raw
    raw="$(stat -c %w "$file" 2>/dev/null || echo "-")"

    # fallback to modification time
    if [[ -z "$raw" || "$raw" == "-" ]]; then
        raw="$(stat -c %y "$file")"
    fi

    # remove nanoseconds if present
    raw="${raw%%.*}"

    # try parsing
    if date -d "$raw" +"%Y-%m-%d" >/dev/null 2>&1; then
        date -d "$raw" +"%Y-%m-%d"
    else
        date +"%Y-%m-%d"
    fi
}

while IFS= read -r -d '' file; do
    rel_path="${file#$base_dir/}"

    created_date="$(get_file_date "$file")"

    header="/*
  $rel_path

  created by ludw
  on $created_date
*/"

    tmp="$(mktemp)"

    if head -n 1 "$file" | grep -q '^/\*'; then
        awk '
        BEGIN { skipping=0; done=0 }
        {
            if (!done && $0 ~ /^\/\*/) { skipping=1 }
            if (skipping) {
                if ($0 ~ /\*\//) { skipping=0; done=1; next }
                next
            }
            print
        }' "$file" > "$tmp"
    else
        cp "$file" "$tmp"
    fi

    {
        echo "$header"
        echo
        cat "$tmp"
    } > "$file"

    rm "$tmp"

done < <(find "$base_dir" -type f -name "*.nix" -print0)

echo "headers processed."
