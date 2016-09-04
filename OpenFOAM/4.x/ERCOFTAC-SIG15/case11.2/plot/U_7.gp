set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "U_7.eps"
set pointsize 1.4
set ylabel "{/Times-Italic y} [m]"
set xlabel "{/Times-Italic U} [m/s]"
set xrange [0:30]
set yrange [0.0:0.1]
set title "{/Times-Italic z/H} = 0.0 [-]"
set key below box
plot "plot/exptData/lbump3LDV/7yandu.dat" index 0 using 3:($2)/1000000 with p pt 1 lc 0 title "Exp.", "< cat postProcessing/sample/*/z_7_U.xy" using 2:1 with l lt 1 title "CFD"

