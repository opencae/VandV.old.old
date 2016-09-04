set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "U_x4.eps"
set pointsize 1.4
set ylabel "{/Times-Italic y/H} [-]"
set xlabel "{/Times-Italic U/U_c} [-]"
set xrange [-0.2:1]
set yrange [-1:2]
set title "{/Times-Italic x/H} = 4.0 [-]"
set key below box
plot \
     "plot/exptData/x_H_4.dat" index 0 using 2:1 with p pt 1 lc 0 title "Exp.",\
     "< cat postProcessing/sample/*/x_H-4_U.xy" using ($2)/3.02:(($1)-0.02)/0.02 with l lt 1 title "CFD"

