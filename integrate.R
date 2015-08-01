# Here we calculate the integrals in the region 625-680nm
# for the normalized datasets.

# Read all the data files
mb_norm               <- read.table("Methylene_blue_normalized.dat", header = TRUE)
mbAn0.14Br0.86_norm   <- read.table("Methylene_blue_anatase0.14_brookite0.86_normalized.dat", header = TRUE)
mbAn0.14Br0.86Au_norm <- read.table("Methylene_blue_anatase0.14_brookite0.86_Au_normalized.dat", header = TRUE)
mbAn0.73Br0.27_norm   <- read.table("Methylene_blue_anatase0.73_brookite0.27_normalized.dat", header = TRUE)
mbAn0.73Br0.27Au_norm <- read.table("Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat", header = TRUE)
degussap25_norm       <- read.table("Degussa_P25_normalized.dat", header = TRUE)

# Interpolate the datasets into splines
mb_spl               <- apply(mb_norm[,-1], 2, splinefun, x = mb_norm$Wavelength)
mbAn0.14Br0.86_spl   <- apply(mbAn0.14Br0.86_norm[,-1], 2, splinefun, x = mbAn0.14Br0.86_norm$Wavelength)
mbAn0.14Br0.86Au_spl <- apply(mbAn0.14Br0.86Au_norm[,-1], 2, splinefun, x = mbAn0.14Br0.86Au_norm$Wavelength)
mbAn0.73Br0.27_spl   <- apply(mbAn0.73Br0.27_norm[,-1], 2, splinefun, x = mbAn0.73Br0.27_norm$Wavelength)
mbAn0.73Br0.27Au_spl <- apply(mbAn0.73Br0.27Au_norm[,-1], 2, splinefun, x = mbAn0.73Br0.27Au_norm$Wavelength)
degussap25_spl       <- apply(degussap25_norm[,-1], 2, splinefun, x = degussap25_norm$Wavelength)

# Integrate
low_limit <- 625
up_limit  <- 680
tol <- 1e-3
mb_int               <- lapply(mb_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.14Br0.86_int   <- lapply(mbAn0.14Br0.86_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.14Br0.86Au_int <- lapply(mbAn0.14Br0.86Au_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.73Br0.27_int   <- lapply(mbAn0.73Br0.27_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.73Br0.27Au_int <- lapply(mbAn0.73Br0.27Au_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
degussap25_int       <- lapply(degussap25_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)

# Get only the values
mb_int_val               <- sapply(mb_int, function(x) x$value)
mbAn0.14Br0.86_int_val   <- sapply(mbAn0.14Br0.86_int, function(x) x$value)
mbAn0.14Br0.86Au_int_val <- sapply(mbAn0.14Br0.86Au_int, function(x) x$value)
mbAn0.73Br0.27_int_val   <- sapply(mbAn0.73Br0.27_int, function(x) x$value)
mbAn0.73Br0.27Au_int_val <- sapply(mbAn0.73Br0.27Au_int, function(x) x$value)
degussap25_int_val       <- sapply(degussap25_int, function(x) x$value)

# Join them in a reversed way
ints <- data.frame(c(0,5,15,30,60,90,120,195),
                   rev(mb_int_val),
                   rev(mbAn0.14Br0.86_int_val),
                   rev(mbAn0.14Br0.86Au_int_val),
                   rev(mbAn0.73Br0.27_int_val),
                   rev(mbAn0.73Br0.27Au_int_val),
                   rev(degussap25_int_val))
row.names(ints) <- NULL
names(ints) <- c("time",
                 "Methylene_blue", 
                 "Methylene_blue_anatase0.14_brookite0.86", 
                 "Methylene_blue_anatase0.14_brookite0.86_Au", 
                 "Methylene_blue_anatase0.73_brookite0.27",
                 "Methylene_blue_anatase0.73_brookite0.27_Au",
                 "Degussa_P25")

# Normalize by the maximum value
maxs <- apply(ints, 2, max)
ints <- sweep(ints, 2, maxs, "/")
ints[1] <- c(0,5,15,30,60,90,120,195)

# Plots
pal <- c("#000000", "#ff0000", "#0000ff", "#008000", "#ff0065", "#00ff00")

png(filename = "Integrals.png", width = 600, height = 450, units = "px")
plot(ints$time, ints$Methylene_blue, type = "n", 
     xlim=c(0,200), ylim=c(0,1), xlab = "Time (mins)", ylab = "Integral (a.u.)")
points(ints$time, ints$Methylene_blue,                             col = pal[1], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.14_brookite0.86,    col = pal[2], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.14_brookite0.86_Au, col = pal[3], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.73_brookite0.27,    col = pal[4], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.73_brookite0.27_Au, col = pal[5], type = "b")
points(ints$time, ints$Degussa_P25,                                col = pal[6], type = "b")
legend("topright", col = pal, legend = c("Methylene blue", 
                                         "Methylene blue, anatase (0.14),brookite (0.86)", 
                                         "Methylene blue, anatase (0.14) brookite (0.86), Au", 
                                         "Methylene blue, anatase (0.73) brookite (0.27)",
                                         "Methylene blue, anatase (0.73) brookite (0.27) Au",
                                         "Degussa P25"), lwd = 1)
dev.off()
