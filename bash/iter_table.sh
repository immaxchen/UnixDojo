#!/bin/bash

{ read -r HEADER; CONTENT=$(cat -); } < <(cat ../data/sample-1.tsv)

declare -A "COL=($(awk 'BEGIN{FS="\t"} {for (i=1;i<=NF;i++) printf "[%s]=%i ",$i,i-1;}' <<< "$HEADER"))"

for name in "${!COL[@]}"; do
    echo "COL=$name, IDX=${COL[$name]}"
done

i=0
while IFS=$'\t' read -r -a ROW; do
    ((i++))
    C=${ROW[${COL[C]}]}
    B=${ROW[${COL[B]}]}
    A=${ROW[${COL[A]}]}
    echo "ROW=$i, A=$A, B=$B, C=$C"
done <<< "$CONTENT"


