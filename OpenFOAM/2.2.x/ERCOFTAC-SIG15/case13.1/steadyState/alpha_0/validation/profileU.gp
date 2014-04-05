set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "profileU.eps"
set pointsize 1.4
set ylabel "{/Times-Italic z/D} [-]"
set xlabel "{/Times-Italic V_r/U_j} [-]"
set xrange [0:0.3]
set yrange [0.0:0.8]
set title "{/Symbol-Italic a} = 0.0"
set key below box
plot "exptData/fig5a.dat" index 0 using 1:2 with p pt 1 lc 0 title "Exp.", \
"< cat ../kEpsilon/postProcessing/sets/*/zH_0_U.xy" using ($3)/8.7:($1)/0.025 with l lt 1 title "kEpsilon",\
"< cat ../kOmega/postProcessing/sets/*/zH_0_U.xy" using ($3)/8.7:($1)/0.025 with l lt 1 lc rgb "green" title "kOmega",\
"< cat ../kOmegaSST/postProcessing/sets/*/zH_0_U.xy" using ($3)/8.7:($1)/0.025 with l lt 1 lc rgb "blue" title "kOmegaSST",\
"< cat ../realizableKE/postProcessing/sets/*/zH_0_U.xy" using ($3)/8.7:($1)/0.025 with l lt 1 lc rgb "magenta" title "realizableKE",\
"< cat ../RNGkEpsilon/postProcessing/sets/*/zH_0_U.xy" using ($3)/8.7:($1)/0.025 with l lt 1 lc rgb "dark-green" title "RNGkEpsilon"

