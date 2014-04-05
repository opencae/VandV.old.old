set terminal postscript enhanced eps color solid 20
set output "U.eps"
set xlabel "Iteration number" 
set ylabel "Velocity [m/s]" 
set logscale y
set style data line
plot \
     "< grep 'U' ../postProcessing/MinMax/0/fieldMinMax.dat" using 1:8 title "Maximum"\
     ,"< sed -e 's/(//' -e 's/)//' ../postProcessing/Average/0/cellSource.dat" using 1:(sqrt($3*$3+$4*$4+$5*$5)) title "Average"
#    EOF
