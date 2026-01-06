#!/usr/bin/env bash

INPUT="${1:-unnamed}"

while true; do
    echo "$INPUT: $(cat $INPUT)"
done
