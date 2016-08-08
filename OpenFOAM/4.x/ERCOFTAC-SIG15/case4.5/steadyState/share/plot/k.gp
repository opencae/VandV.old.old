set terminal postscript enhanced eps color solid 20
set output "k.eps"
set xlabel "Iteration number" 
set ylabel "Turbulent kinetic energy [m^2/s^2]" 
set logscale y
set style data line
plot \
     "< grep 'k' ../postProcessing/MinMax/0/fieldMinMax.dat" using 1:3 title "Minimum"\
     ,"< sed -e 's/(//' -e 's/)//' ../postProcessing/Average/0/cellSource.dat" using 1:7 title "Average"\
     ,"< grep 'k' ../postProcessing/MinMax/0/fieldMinMax.dat" using 1:8 title "Maximum"
#    EOF
