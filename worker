#!/usr/bin/env bash

INPUT="${1:-unnamed}"

main() {
    while true; do
        request=`cat "$INPUT"`
        output=`head -n1 <<<"$request" | xargs`
        command=`sed '1d' <<<"$request" | xargs`
        bash -c "$command" > "$output"
    done
}

main "$@"
