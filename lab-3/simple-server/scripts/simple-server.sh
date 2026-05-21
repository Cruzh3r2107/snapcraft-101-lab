#!/bin/sh

main() {
  set -eu

  SERVER_PORT="$(snapctl get daemon.port)"
  SERVER_HOST="$(snapctl get daemon.host)"
  SERVER_MSG="$(snapctl get daemon.msg)"

  while :; do
    echo "ncat started on '${SERVER_HOST}:${SERVER_PORT}', with message '${SERVER_MSG}'"
    echo "${SERVER_MSG}" | ncat -4 --listen --send-only "${SERVER_HOST}" "${SERVER_PORT}"
  done
}

main "$@"
