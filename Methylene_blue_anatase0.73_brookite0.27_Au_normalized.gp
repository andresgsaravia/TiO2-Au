set terminal pngcairo enhanced size 600,450 font "Helvetica, 10"

set style data lines
set output "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.png"

set title "Methylene blue, anatase (0.73), brookite (0.27) and Au"
set xlabel "Wavelength (nm)"
set ylabel "Absorbance (a.u.)"
set xrange[180:1020]
set yrange[-0.5:9]
set xtics 200
set ytics 2
load "styles.gp"
plot "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:9 ls 1 title "0 min",  \
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:8 ls 2 title "5 min",  \
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:7 ls 3 title "15 min", \
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:6 ls 4 title "30 min", \
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:5 ls 5 title "60 min", \
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:4 ls 6 title "90 min", \
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:3 ls 7 title "120 min",\
     "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat" u 1:2 ls 8 title "195 min"

set output
