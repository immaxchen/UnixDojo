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
else
    content=$(cat "$inputFile")
fi

echo "<table$attribute>"
head -n  $(($headLines))   <(echo "$content") | sed "s/$delimiter/<\/th><th>/g" | sed 's/^/<tr><th>/' | sed 's/$/<\/th><\/tr>/'
tail -n +$(($headLines+1)) <(echo "$content") | sed "s/$delimiter/<\/td><td>/g" | sed 's/^/<tr><td>/' | sed 's/$/<\/td><\/tr>/'
echo "</table>"

