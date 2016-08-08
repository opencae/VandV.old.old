set terminal postscript enhanced eps color solid 20
set output "omega.eps"
set xlabel "Iteration number" 
set ylabel "Specific turbulence dissipation [1/s]" 
set logscale y
set style data line
set key below box
plot \
      "< awk -F '\t' '(NR==1) {n=(NF==6?5:6)} ($2==\"omega\") {print $1,$n}' ../postProcessing/MinMax/*/fieldMinMax.dat" using 1:2 title "Maximum"\
     ,"< cat ../postProcessing/MinMax/*/fieldMinMax.dat | grep 'omega'" using 1:3 title "Minimum"
#     ,"< sed -e 's/(//' -e 's/)//' ../postProcessing/Average/0/cellSource.dat" using 1:8 title "Average"\
#    EOF
