#!/bin/bash

attribute=
delimiter=\\t
headLines=1
inputFile=-

while [[ $# -gt 0 ]]; do
    case "$1" in
        -a|--attribute)
        attribute=" $2"
        shift; shift
        ;;
        -d|--delimiter)
        delimiter="$2"
        shift; shift
        ;;
        -h|--headLines)
        headLines="$2"
        shift; shift
        ;;
        *)
        inputFile="$1"
        shift
        ;;
    esac
done

if [ "$inputFile" = "-" ] && [ -t 0 ]; then
    >&2 echo "$0: need input from a file or a pipe"; exit 1
fi

hcount=0
rcount=0
echo "<table$attribute>"
while read INPUT; do
    if [ $hcount -lt $headLines ]; then
        echo "<tr><th>$INPUT</th></tr>" | sed "s/$delimiter/<\/th><th>/g"
        ((hcount++))
    else
        [[ $((rcount%2)) -eq 0 ]] && attr='' || attr=' class="striped"'
        echo "<tr$attr><td>$INPUT</td></tr>" | sed "s/$delimiter/<\/td><td>/g"
        ((rcount++))
    fi
done < "$inputFile"
echo "</table>"

