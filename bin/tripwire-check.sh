#!/bin/sh
set -e

DIR=$(dirname "$0")

TWDIR=/tmp/tw
CFG=$TWDIR/tw.cfg
DB=$TWDIR/db.twd

exec $DIR/tripwire.sh --check -c $CFG -d $DB "$@"
