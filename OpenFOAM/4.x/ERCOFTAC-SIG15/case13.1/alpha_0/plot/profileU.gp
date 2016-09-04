set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "profileU.eps"
set pointsize 1.4
set ylabel "{/Times-Italic z/D} [-]"
set xlabel "{/Times-Italic Vr/Uj} [-]"
set xrange [0:0.3]
set yrange [0.0:0.8]
set key below box
plot "plot/exptData/fig5a.dat" index 0 using 1:2 with p pt 1 lc 0 title "Exp.", \
"< cat postProcessing/sample/*/zH_0_U.xy" using ($3)/8.7:($1)/0.025 with l lt 1 title "CFD"

