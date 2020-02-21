#!/bin/sh
set -e

DIR=$(dirname "$0")

TWDIR=/tmp/tw
DB=$TWDIR/db.twd

if [[ ! -e $DB ]]; then
    echo "Initializing Tripwire DB"
    $DIR/tripwire-init.sh
fi

exec $DIR/tripwire "$@"
