#!/usr/bin/env bash

MASTER_PIPE="master_pipe"
SLAVES=8
SLAVE_FILES_DIRECTORY="fifo"
declare -a SLAVE_FILES
declare -i CURRENT_PROCESS
CURRENT_PROCESS=0

main() {
    cd `dirname "$0"`

    mkfifo "$MASTER_PIPE" || exit 1

    for i in `seq $SLAVES`; do
        file="${SLAVE_FILES_DIRECTORY}/fifo_$i"
        mkfifo "$file" || exit 1
        SLAVE_FILES[$i]="$file"
        ./slave.sh $file &
    done


    while true; do
        cat <"$MASTER_PIPE" >"${SLAVE_FILES[$((CURRENT_PROCESS + 1))]}"
        CURRENT_PROCESS=$(( (CURRENT_PROCESS + 1) % SLAVES ))
    done
}

cleanup() {
    kill $(jobs -p) 2>/dev/null
    rm -f "${SLAVE_FILES[@]}"
    rm -f "$MASTER_PIPE"
}

trap cleanup EXIT
main "$@"
