set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "U_0.65.eps"
set pointsize 1.4
set ylabel "{/Times-Italic y/c} [-]"
set xlabel "{/Times-Italic U/Uinf} [-]"
set xrange [-0.2:1.2]
set yrange [0.11:0.18]
set title "{/Times-Italic x/c} = 0.65 [-]"
set key below box
plot "exptData/x0.65off.dat" index 0 using 3:2 with p pt 1 lc 0 title "Exp.", "< cat ../postProcessing/sets/*/section_065_U.xy" using ($2)/34.6:($1)/0.42 with l lt 1 title "CFD"

