set terminal png truecolor size 1920,1080
set output '/foo/feigenbaum.png'

set xrange [3.4:4]
set grid
unset label
plot '/foo/out.csv' with dots lc black notitle
