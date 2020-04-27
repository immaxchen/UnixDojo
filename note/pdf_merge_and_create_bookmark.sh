#!/bin/bash

out_file="combined.pdf"
tmp_dir="/tmp/pdftk_unite"
bookmarks_file="$tmp_dir/bookmarks.txt"
bookmarks_fmt="BookmarkBegin
BookmarkTitle: %s
BookmarkLevel: 1
BookmarkPageNumber: 1
"

rm -rf "$tmp_dir"
mkdir -p "$tmp_dir"

for f in *.pdf; do
    echo "Bookmarking $f..."
    title="${f%.*}"
    printf "$bookmarks_fmt" "$title" > "$bookmarks_file"
    pdftk "$f" update_info "$bookmarks_file" output "$tmp_dir/$f"
done

pdftk "$tmp_dir"/*.pdf cat output "$out_file"

# https://unix.stackexchange.com/questions/368415/

