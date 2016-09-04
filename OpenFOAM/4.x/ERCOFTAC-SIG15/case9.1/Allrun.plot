#!/bin/sh
# Source tutorial run functions
. $WM_PROJECT_DIR/bin/tools/RunFunctions

runApplication -s sample \
    postProcess -latestTime -func sample

GNUPLOT=$(which gnuplot 2> /dev/null)
if [ "x$GNUPLOT" = "x" ]
then
    echo "Gnuplot not installed" >&2
    exit 1
fi

(
for file in plot/*.gp
do
  $GNUPLOT $file 
done
) > log.gnuplot 2>&1

plot/createGraphs > log.createGraphs 2>&1

epsfiles="*.eps"
base=`basename ${PWD}`
CONVERT=$(which convert 2> /dev/null)
if [ ! "x$CONVERT" = "x" ]
then
    $CONVERT -density 300 $epsfiles $base.pdf
else
    echo "convert not installed" >&2
fi
