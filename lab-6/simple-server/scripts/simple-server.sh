#!/bin/sh
 
readonly MESSAGE_PATH="/etc/simple-server/message.md"
 
get_content() {
  [ -f "${MESSAGE_PATH}" ] || {
    echo "$SERVER_MSG"
    exit 0
  }
  cat "${MESSAGE_PATH}"
}
 
main() {
  set -eu
 
  SERVER_PORT="$(snapctl get daemon.port)"
  SERVER_HOST="$(snapctl get daemon.host)"
  SERVER_MSG="$(snapctl get daemon.msg)"
 
  while :; do
    echo "ncat started on '${SERVER_HOST}:${SERVER_PORT}'"
    get_content | ncat -4 --listen --send-only "${SERVER_HOST}" "${SERVER_PORT}"
  done
}
 
main "$@"
