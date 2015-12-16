#!/bin/bash

set -e

NAME="Petr Kletecka"
URL=http://metabase.cpantesters.org/tail/log.txt
ARCH="i486-linux-thread-multi x86_64-linux-thread-multi darwin-2level MSWin32-x86-multi-thread-64int"

TMPFILE=`mktemp -p /tmp/`
wget -qO $TMPFILE $URL 

UPDATE="N"

for foo in $ARCH
do
	UPDATE="$UPDATE:`grep "$NAME" $TMPFILE | grep $foo | wc -l`"
done

rrdtool update metabase.rrd $UPDATE

rm $TMPFILE
