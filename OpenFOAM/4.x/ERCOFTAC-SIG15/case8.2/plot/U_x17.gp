set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "U_x17.eps"
set pointsize 1.4
set ylabel "{/Times-Italic y/H} [-]"
set xlabel "{/Times-Italic U/Ub} [-]"
set xrange [-0.1:0.6]
set yrange [0:5]
set title "{/Times-Italic x/H} = 17 [-]"
set key below box
plot \
     "plot/exptData/m__U%.x17" index 0 using 2:1 with p pt 1 lc 0 title "Exp.",\
     "< cat postProcessing/sample/*/section_17_U.xy" using ($2)/20:($1)/0.015 with l lt 1 title "CFD"

