set terminal postscript eps color solid font "helvetica,17" linewidth 1.5
set output "residual.eps"
set logscale y
set xlabel "Time"
set ylabel "Residual"
set grid
set style data line
plot \
"postProcessing/residuals/0/residuals.dat" using 1:2 title "p",\
"" using 1:3  title "Ux",\
"" using 1:4  title "Uy",\
"" using 1:5  title "k",\
"" using 1:6  title "epsilon"
#    EOF
