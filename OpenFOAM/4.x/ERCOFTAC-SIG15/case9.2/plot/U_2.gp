set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "U_2.eps"
set pointsize 1.4
set ylabel "{/Times-Italic y/h} [-]"
set xlabel "{/Times-Italic U/U_b} [-]"
set xrange [-0.2:1.2]
set yrange [0:3.5]
set title "{/Times-Italic x/h} = 2.0 [-]"
set key below box
plot \
     "plot/exptData/data-004" index 0 using 2:1 with p pt 1 lc 0 title "Exp.",\
     "< cat postProcessing/sample/*/x2_U.xy" using ($2)/7.872:($1)/0.028 with l lt 1 title "CFD"

