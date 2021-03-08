#!/bin/bash

CMDGRP1=()
CMDGRP2=()
CMDGRP3=()
CMDGRP4=()
CMDGRP5=()
CMDGRP6=()

GRPCNT=1

while [[ $# -gt 0 ]]; do
    case "$1" in
        --)
        ((GRPCNT++))
        shift
        ;;
        *)
        case "$GRPCNT" in
            1)
            CMDGRP1+=("$1")
            ;;
            2)
            CMDGRP2+=("$1")
            ;;
            3)
            CMDGRP3+=("$1")
            ;;
            4)
            CMDGRP4+=("$1")
            ;;
            5)
            CMDGRP5+=("$1")
            ;;
            6)
            CMDGRP6+=("$1")
            ;;
            *)
            echo "[error] exceed maximum supported group count" >&2
            exit 1
            ;;
        esac
        shift
        ;;
    esac
done

case "$GRPCNT" in
    1)
    "${CMDGRP1[@]}"
    ;;
    2)
    "${CMDGRP1[@]}" | "${CMDGRP2[@]}"
    ;;
    3)
    "${CMDGRP1[@]}" | "${CMDGRP2[@]}" | "${CMDGRP3[@]}"
    ;;
    4)
    "${CMDGRP1[@]}" | "${CMDGRP2[@]}" | "${CMDGRP3[@]}" | "${CMDGRP4[@]}"
    ;;
    5)
    "${CMDGRP1[@]}" | "${CMDGRP2[@]}" | "${CMDGRP3[@]}" | "${CMDGRP4[@]}" | "${CMDGRP5[@]}"
    ;;
    6)
    "${CMDGRP1[@]}" | "${CMDGRP2[@]}" | "${CMDGRP3[@]}" | "${CMDGRP4[@]}" | "${CMDGRP5[@]}" | "${CMDGRP6[@]}"
    ;;
    *)
    echo "[error] exceed maximum supported group count" >&2
    exit 1
    ;;
esac

