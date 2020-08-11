#!/bin/bash

TEXT="hello world
merry christmas"

declare -A DICT
while read -r KEY VAL; do
    DICT[$KEY]=$VAL
done <<< "$TEXT"

echo ${DICT["merry"]}
echo ${DICT["hello"]}

