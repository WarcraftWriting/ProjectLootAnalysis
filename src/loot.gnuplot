# Expected Columns:
#  1 : int    : seconds since epoch
#  2 : float  : level
#  3 : int    : copper
#  4 : int    : earned
#  5 : string : event

set xlabel "Level"
set ylabel "Gold"
set logscale y # logscale allows copper to be visible at very low amounts
set xrange [1:90] # can I use a variable here?
set xtics out 10
set mxtics 2
set ytics ("1 C" 0.001, "1 S" 0.01, "10 S" 0.1, "1 G" 1, "10 G" 10, \
           "100 G" 100, "1K G" 1000, "10K G" 10000, "100K G" 100000)
set ytics add ("5K" 5000)
#set yrange [1:] # setting this just compresses the remaining data
set key on outside

set terminal svg font "Helvetica Neue" size 1200,600 enhanced
set output "out/loot.svg"

plot "data/current.dat" using 2:($3/10000) title "Balance" with lines, \
     "" using 2:($4/10000) title "Earned" with lines, \
     5000 title "5K Gold" with lines, \
     10000 title "10K Gold" with lines

#show fontpath
