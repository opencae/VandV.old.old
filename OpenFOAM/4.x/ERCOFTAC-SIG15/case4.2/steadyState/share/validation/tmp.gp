set terminal postscript enhanced eps color solid font "Times,22"
set output "tmp.eps"
plot "exptData/2a1umx-2.exp" using 2:1 with lp,"< cat ../postProcessing/sets/*/x-50mm_U.xy" using ($4/2.147):($2/0.028) with l
#    EOF
