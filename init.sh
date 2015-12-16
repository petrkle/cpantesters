#!/bin/bash

set -e

DB=metabase.rrd

if [ ! -e $DB ]
then

	rrdtool create $DB \
		--step 300 \
		DS:linux32:GAUGE:600:U:U \
		DS:linux64:GAUGE:600:U:U \
		DS:macosx:GAUGE:600:U:U \
		DS:windows:GAUGE:600:U:U \
		RRA:AVERAGE:0.5:1:105120 \
		RRA:AVERAGE:0.5:1:105120 \
		RRA:AVERAGE:0.5:1:105120 \
		RRA:AVERAGE:0.5:1:105120

fi
