set terminal postscript enhanced eps color solid 20
set output "U.eps"
set xlabel "Iteration number" 
set ylabel "Velocity [m/s]" 
ymax=`grep "U" ../postProcessing/MinMax/*/fieldMinMax.dat | tail -n 1 | awk -F '\t' '{print $(NF==6?5:6)*2}'` 
set yrange [0:ymax]
set style data line
set key below box
plot \
     "< awk -F '\t' '(NR==1) {n=(NF==6?5:6)} ($2==\"U\") {print $1,$n}' ../postProcessing/MinMax/*/fieldMinMax.dat" using 1:2 title "Maximum"\
#     ,"< sed -e 's/(//' -e 's/)//' ../postProcessing/Average/0/cellSource.dat" using 1:(sqrt($3*$3+$4*$4+$5*$5)) title "Average"
#    EOF
