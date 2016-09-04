set terminal postscript enhanced eps color solid font "Times,22" lw 2 
set output "x_-50mm_U.eps"

Uo=2.147
h=0.028

set pointsize 1.4
set xlabel "{/Times-Italic U/Uo} [-]"
set ylabel "{/Times-Italic y/h} [-]"
set title "{/Times-Italic x} = -50mm"
set key below box

plot \
     "plot/exptData/2a1umx-2.exp" using 2:1 with p pt 1 lc 0title "Exp.",\
     "< cat postProcessing/sample/*/x_-50mm_U.xy" using ($4/Uo):($2/h) with l lt 1 title "CFD"
#    EOF
