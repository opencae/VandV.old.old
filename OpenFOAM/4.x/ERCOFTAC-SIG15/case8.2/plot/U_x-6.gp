set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "U_x-6.eps"
set pointsize 1.4
set ylabel "{/Times-Italic y/H} [-]"
set xlabel "{/Times-Italic U/Ub} [-]"
set xrange [0:1.2]
set yrange [3.7:4.7]
set title "{/Times-Italic x/H} = -6 [-]"
set key below box
plot \
     "plot/exptData/m__U%.x-6" index 0 using 2:1 with p pt 1 lc 0 title "Exp.",\
     "< cat postProcessing/sample/*/section_-6_U.xy" using ($2)/20:($1)/0.015 with l lt 1 title "CFD"

