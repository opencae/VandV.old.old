# 出力ファイルの設定
set terminal postscript enhanced eps color solid "Times,22" lw 2
set output "Ux-profile.eps"

# 関数の設定
r=0.05
theta=35*pi/180
Ux(x)=(x/40)*r
Z(x)=x/1000
slant(x)=0.338-0.222*sin(theta) + (-tan(theta)*x)
geo(x)= ( x < -0.222*cos(theta) ? 0.338 : slant(x) )

# 軸の設定
set pointsize 1.4
set xlabel "{/Times-Italic x} [m]"
set ylabel "{/Times-Italic z} [m]"
set key below box
set xrange [-0.3:0.2]
set yrange [0.0:0.5]

# 形状・速度分布描画
set arrow from -0.3,0.05 to 0.0,0.05 nohead lc rgbcolor "black" lw 2
set arrow from  0.0,0.05 to 0.0,0.338-0.222*sin(theta) nohead lc rgbcolor "black" lw 2
plot \
     dummy=0, \
     [-0.3:0.0] geo(x) with lines linecolor rgbcolor "black" lw 2 title "", \
     "Exp/x-223.txt" using (-0.223+Ux($4)):(Z($3)) with points pt 7 lc 7 title "Exp.", \
     "postProcessing/sample/500/x-223_U.xy" using (-0.223+Ux($4)):3 with line lt 1 lc 0 title "CFD", \
     "Exp/x-203.txt" using (-0.203+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-203_U.xy" using (-0.203+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-183.txt" using (-0.183+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-183_U.xy" using (-0.183+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-163.txt" using (-0.163+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-163_U.xy" using (-0.163+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-143.txt" using (-0.143+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-143_U.xy" using (-0.143+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-123.txt" using (-0.123+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-123_U.xy" using (-0.123+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-103.txt" using (-0.103+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-103_U.xy" using (-0.103+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-83.txt" using (-0.083+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-83_U.xy" using (-0.083+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-63.txt" using (-0.063+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-63_U.xy" using (-0.063+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-43.txt" using (-0.043+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-43_U.xy" using (-0.043+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-23.txt" using (-0.023+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-23_U.xy" using (-0.023+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x-3.txt" using (-0.003+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x-3_U.xy" using (-0.003+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x+37.txt" using (0.037+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x+37_U.xy" using (0.037+Ux($4)):3 with line lt 1 lc 0 title "", \
     "Exp/x+87.txt" using (0.087+Ux($4)):(Z($3)) with points pt 7 lc 7 title "", \
     "postProcessing/sample/500/x+87_U.xy" using (0.087+Ux($4)):3 with line lt 1 lc 0 title ""
