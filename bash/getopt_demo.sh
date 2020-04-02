#!/bin/bash

# ============================== Args Parsing ==============================

# Reference -- https://stackoverflow.com/questions/192249/

o=dfvo:
l=debug,force,verbose,output:
parsed=$(getopt -o $o -l $l -n "$0" -- "$@")

if [[ $? -ne 0 ]]; then
    exit 1
fi

debug=n
force=n
verbose=n
outputFile=/dev/null

eval set -- "$parsed"
while true; do
    case "$1" in
        -d|--debug)
            debug=y
            shift
            ;;
        -f|--force)
            force=y
            shift
            ;;
        -v|--verbose)
            verbose=y
            shift
            ;;
        -o|--output)
            outputFile="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "$0: invalid option -- '$1'"
            shift
            ;;
    esac
done

if [ -f "$1" ]; then
    inputFile="$1"
else
    if [ -t 0 ]; then
        echo "$0: missing or incorrect input"
        exit 2
    fi
    inputFile=/dev/stdin
fi

# ============================== Main Program ==============================


echo "debug: $debug
force: $force
verbose: $verbose
output: $outputFile
input: "

cat "$inputFile"


