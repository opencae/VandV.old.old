set terminal postscript enhanced eps color solid 20
set output "epsilon.eps"
set xlabel "Iteration number" 
set ylabel "Turbulent kinetic energy dissipation rate [m^2/s^3]" 
set logscale y
set style data line
plot \
     "< grep 'epsilon' ../postProcessing/MinMax/0/fieldMinMax.dat" using 1:3 title "Minimum"\
     ,"< sed -e 's/(//' -e 's/)//' ../postProcessing/Average/0/cellSource.dat" using 1:8 title "Average"\
     ,"< grep 'epsilon' ../postProcessing/MinMax/0/fieldMinMax.dat" using 1:8 title "Maximum"
#    EOF
