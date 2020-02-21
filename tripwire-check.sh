#!/bin/sh
set -e

DIR=$(dirname "$0")

TWDIR=/tmp/tw
CFG=$TWDIR/tw.cfg
DB=$TWDIR/db.twd

if [[ ! -e $DB ]]; then
    echo "Initializing Tripwire DB"
    $DIR/tripwire-init.sh
fi

$DIR/tripwire --check -c $CFG -d $DB "$@"
