#!/bin/sh

postProcess -latestTime -func sample > log.sample 2>&1

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

RMSEU=`grep "RMSE(U" log.gnuplot | awk -F ' ' '{print $2}'`
RMSEV=`grep "RMSE(V" log.gnuplot | awk -F ' ' '{print $2}'`
RMSEk=`grep "RMSE(k" log.gnuplot | awk -F ' ' '{print $2}'`
RMSEsum=`echo "${RMSEU} + ${RMSEV} + ${RMSEk}" | bc -l`

cat log.gnuplot
echo "RMSE(U/Uc)+RMSE(V/Uc)+RMSE(k/Uc^2): $RMSEsum"

epsfiles="residual.eps profileU.eps profileV.eps profilek.eps"
base=`basename ${PWD}`
CONVERT=$(which convert 2> /dev/null)
if [ ! "x$CONVERT" = "x" ]
then
    $CONVERT -density 300 $epsfiles $base.pdf
else
    echo "convert not installed" >&2
fi
