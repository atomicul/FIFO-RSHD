#!/usr/bin/env bash

MASTER_PIPE="master_pipe"
CLIENT_FILE_SHAPE="/tmp/rshd-%s"
REQUEST_SHAPE="BEGIN-REQ[%s:%s]END-REQ"

cd `dirname "$0"`

while true; do
    echo -n "rshd>"
    read command

    printf "$REQUEST_SHAPE" "$$" "$command" >"$MASTER_PIPE"

    client_file=`printf "$CLIENT_FILE_SHAPE" "$$"`
    mkfifo "$client_file" || exit 1
    cat "$client_file"
    rm -f "$client_file"
done
