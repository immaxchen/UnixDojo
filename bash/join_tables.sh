#!/bin/bash

echo "
===== unix join, limits: 2 files, 1 sorted key ====="

echo "
inner join on 1st file 1st field = 2nd file 3rd field, field separator = tab
"

join -t $'\t' -1 1 -2 3 <(sort -k 1 sample-1.tsv) <(sort -k 3 sample-2.tsv)

echo "
left outer join, will not have empty field if no output format given
"

join -t $'\t' -1 1 -2 3 -a 1 <(sort -k 1 sample-1.tsv) <(sort -k 3 sample-2.tsv)

echo "
full outer join, need to specify output format, here fill 0 for missing values
"

join -t $'\t' -1 1 -2 3 -a 1 -a 2 -o 0 1.2 1.3 2.1 2.2 -e 0 <(sort -k 1 sample-1.tsv) <(sort -k 3 sample-2.tsv)

echo "
inner join on 2 keys
"

join -t $'\t' -o 1.2 1.3 1.4 2.4 2.5 <(awk 'BEGIN{FS=OFS="\t"} {print $1"|"$2, $0}' sample-1.tsv | sort -k 1) <(awk 'BEGIN{FS=OFS="\t"} {print $1"|"$2, $0}' sample-3.tsv | sort -k 1)

echo "
===== awk script ====="

echo "
inner join on 1st file 1st field = 2nd file 3rd field, field separator = tab
"

awk 'BEGIN{FS=OFS="\t"} NR==FNR {arr[$1]=$2 FS $3; next} $3 in arr {print $0, arr[$3]}' sample-1.tsv sample-2.tsv

echo "
inner join on 2 keys
"

awk 'BEGIN{FS=OFS="\t"} NR==FNR {arr[$1, $2]=$3 FS $4; next} ($1, $2) in arr {print $0, arr[$1, $2]}' sample-3.tsv sample-1.tsv


