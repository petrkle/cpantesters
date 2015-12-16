#!/bin/bash

set -e

DB=metabase.rrd
OUT=.
GRAPHS="6h 1d 2d 7d 14d 21d"

echo '<html>
<head>
<title>cpantester</title>
<meta http-equiv="refresh" content="300">
</head>
<body style="text-align:center;">' > $OUT/index.html

for GRAPH in $GRAPHS
do

	rrdtool graph $OUT/$GRAPH.png -a PNG --title="cpantesters $GRAPH" \
		--end now --start end-$GRAPH \
		-w 1000 -h 430 \
		--disable-rrdtool-tag \
		"DEF:linux32=$DB:linux32:AVERAGE" "AREA:linux32#ff0000:Linux 32-bit" \
		"DEF:linux64=$DB:linux64:AVERAGE" "STACK:linux64#990000:Linux 64-bit" \
		"DEF:macosx=$DB:macosx:AVERAGE" "STACK:macosx#009900:Mac OS X" \
		"DEF:windows=$DB:windows:AVERAGE" "STACK:windows#000099:Windows" \
		> /dev/null

	echo "<img src=\"$GRAPH.png?`date +%s`\" style=\"margin-top:1em;\"/>" >> $OUT/index.html

done

echo '</body>
</html>' >> $OUT/index.html
