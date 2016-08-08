set terminal postscript eps color solid 22
set output "res.eps"
set logscale y 10
set xlabel "Iteration number"
set ylabel "Initial Residual"
set grid
set style data line
plot "../logs/p_0" title "p",\
     "../logs/k_0" title "k",\
     "../logs/epsilon_0" title "epsilon",\
     "../logs/Ux_0" title "Ux",\
     "../logs/Uy_0" title "Uy",\
     "../logs/Uz_0" title "Uz"
#    EOF
