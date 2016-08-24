set terminal postscript enhanced eps color solid 17
set size ratio 0 1,0.45
set pointsize 0.4
set xtics ("-2" -2, "-1" -1, "0" 0, "1" 1, "2" 2, "3" 3, "4" 4, "5" 5, "6" 6, "7" 7, "8" 8, "9" 9, "10" 10, "11" 11, "12" 12, "13" 13, "14" 14, "15" 15)
set grid
set noytics
set xrange [ -2.5 : 17 ]
set yrange [ 0 : 3 ]
set key horizontal box at 9, 3.45
set xlabel "[x/H]" offset 32,1.55
set lmargin 0
set rmargin 0
unset border
set arrow from -2,3 to 15,3 nohead lw 3
set arrow from -2,1 to 0,1 nohead lw 3
set arrow from 0,1 to 0,0 nohead lw 3
set arrow from 0,0 to 15,0 nohead lw 3
set arrow from 15,0 to 15,3 nohead lw 3 lt 0
set arrow from -2,1 to -2,3 nohead lw 3 lt 0

scale=0.2
set output "profileV.eps"
set x2label "[V/U_c]" offset -18,-1.5
set x2tics (sprintf("%g",-scale) -1, "0" 0, sprintf("%g",scale) 1)
set arrow from -1,3 to -1,3.1 nohead lw 1
set arrow from 0,3 to 0,3.1 nohead lw 1
set arrow from 1,3 to 1,3.1 nohead lw 1

RMSE=`awk -F ',' 'NR>=1105 && NR<=2425 && /^[0-9]/ { print $5}' plot/exptData/fc_bs007.csv | paste - postProcessing/sample/*/measuringPoints_U.xy | awk '{sesum+=($1-$6)^2} END {print sqrt(sesum/NR)}'`
print "RMSE(V/Uc): ",RMSE
set label sprintf("RMSE: %.4g",RMSE) left at 10,3.3

plot \
"< awk -F ',' 'NR==1105,NR==1185 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale):1 title "Exp" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1188,NR==1309 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+1):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1312,NR==1433 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+2):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1436,NR==1557 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+3):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1560,NR==1681 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+4):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1684,NR==1805 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+5):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1808,NR==1929 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+6):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==1932,NR==2053 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+7):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==2056,NR==2177 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+8):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==2180,NR==2301 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+9):1 title "" with p pt 1 lc 1,\
"< awk -F ',' 'NR==2304,NR==2425 {print $2,$5}' plot/exptData/fc_bs007.csv" using ($2/scale+10):1 title "" with p pt 1 lc 1,\
"< cat postProcessing/sample/*/x=-2H_U.xy" using ($5/scale-2):2  title "CFD" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=-1H_U.xy" using ($5/scale-1):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=0H_U.xy" using ($5/scale  ):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=1H_U.xy" using ($5/scale+1):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=2H_U.xy" using ($5/scale+2):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=3H_U.xy" using ($5/scale+3):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=4H_U.xy" using ($5/scale+4):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=5H_U.xy" using ($5/scale+5):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=6H_U.xy" using ($5/scale+6):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=7H_U.xy" using ($5/scale+7):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=8H_U.xy" using ($5/scale+8):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=9H_U.xy" using ($5/scale+9):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=10H_U.xy" using ($5/scale+10):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=11H_U.xy" using ($5/scale+11):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=12H_U.xy" using ($5/scale+12):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=13H_U.xy" using ($5/scale+13):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=14H_U.xy" using ($5/scale+14):2  title "" with l lt 1 lc 0, \
"< cat postProcessing/sample/*/x=15H_U.xy" using ($5/scale+15):2  title "" with l lt 1 lc 0
#    EOF
