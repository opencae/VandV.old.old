set terminal postscript enhanced eps color solid 20
set output "epsilon.eps"
set xlabel "Iteration number" 
set ylabel "Turbulent kinetic energy dissipation rate [m^2/s^3]" 
set logscale y
set style data line
set key below box
plot \
     "< awk -F '\t' '(NR==1) {n=(NF==6?5:6)} ($2==\"epsilon\") {print $1,$n}' ../postProcessing/MinMax/*/fieldMinMax.dat" using 1:2 title "Maximum"\
     ,"< cat ../postProcessing/MinMax/*/fieldMinMax.dat | grep 'epsilon'" using 1:8 title "Maximum"
#     ,"< sed -e 's/(//' -e 's/)//' ../postProcessing/Average/0/cellSource.dat" using 1:8 title "Average"\
#    EOF
