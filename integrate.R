# Here we calculate the integrals in the region 500-800nm
# for the normalized datasets.

# Read all the data files
mb_norm               <- read.table("Methylene_blue_normalized.dat", header = TRUE)
mbAn0.28Br0.72_norm   <- read.table("Methylene_blue_anatase0.28_brookite0.72_normalized.dat", header = TRUE)
mbAn0.28Br0.72Au_norm <- read.table("Methylene_blue_anatase0.28_brookite0.72_Au_normalized.dat", header = TRUE)
mbAn0.73Br0.27_norm   <- read.table("Methylene_blue_anatase0.73_brookite0.27_normalized.dat", header = TRUE)
mbAn0.73Br0.27Au_norm <- read.table("Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat", header = TRUE)

# Interpolate the datasets into splines
mb_spl               <- apply(mb_norm[,-1], 2, splinefun, x = mb_norm$Wavelength)
mbAn0.28Br0.72_spl   <- apply(mbAn0.28Br0.72_norm[,-1], 2, splinefun, x = mbAn0.28Br0.72_norm$Wavelength)
mbAn0.28Br0.72Au_spl <- apply(mbAn0.28Br0.72Au_norm[,-1], 2, splinefun, x = mbAn0.28Br0.72Au_norm$Wavelength)
mbAn0.73Br0.27_spl   <- apply(mbAn0.73Br0.27_norm[,-1], 2, splinefun, x = mbAn0.73Br0.27_norm$Wavelength)
mbAn0.73Br0.27Au_spl <- apply(mbAn0.73Br0.27Au_norm[,-1], 2, splinefun, x = mbAn0.73Br0.27Au_norm$Wavelength)

# Integrate
low_limit <- 500
up_limit  <- 800
tol <- 1e-3
mb_int               <- lapply(mb_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.28Br0.72_int   <- lapply(mbAn0.28Br0.72_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.28Br0.72Au_int <- lapply(mbAn0.28Br0.72Au_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.73Br0.27_int   <- lapply(mbAn0.73Br0.27_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)
mbAn0.73Br0.27Au_int <- lapply(mbAn0.73Br0.27Au_spl, integrate, lower = low_limit, upper = up_limit, subdivisions = 300, rel.tol = tol)

# Get only the values
mb_int_val <- sapply(mb_int, function(x) x$value)
mbAn0.28Br0.72_int_val <- sapply(mbAn0.28Br0.72_int, function(x) x$value)
mbAn0.28Br0.72Au_int_val <- sapply(mbAn0.28Br0.72Au_int, function(x) x$value)
mbAn0.73Br0.27_int_val <- sapply(mbAn0.73Br0.27_int, function(x) x$value)
mbAn0.73Br0.27Au_int_val <- sapply(mbAn0.73Br0.27Au_int, function(x) x$value)

# Join them in a reversed way
ints <- data.frame(c(0,5,15,30,60,90,120,195),
                   rev(mb_int_val),
                   rev(mbAn0.28Br0.72_int_val),
                   rev(mbAn0.28Br0.72Au_int_val),
                   rev(mbAn0.73Br0.27_int_val),
                   rev(mbAn0.73Br0.27Au_int_val))
row.names(ints) <- NULL
names(ints) <- c("time",
                 "Methylene_blue", 
                 "Methylene_blue_anatase0.28_brookite0.72", 
                 "Methylene_blue_anatase0.28_brookite0.72_Au", 
                 "Methylene_blue_anatase0.73_brookite0.27",
                 "Methylene_blue_anatase0.73_brookite0.27_Au")

# Normalize by the maximum value
maxs <- apply(ints, 2, max)
ints <- sweep(ints, 2, maxs, "/")
ints[1] <- c(0,5,15,30,60,90,120,195)
# Plots
pal <- palette(rainbow(5))

png(filename = "Integrals.png", width = 600, height = 450, units = "px")
plot(ints$time, ints$Methylene_blue, type = "n", 
     xlim=c(0,200), ylim=c(0,1), xlab = "Time (mins)", ylab = "Integral (a.u.)")
points(ints$time, ints$Methylene_blue, col = pal[1], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.28_brookite0.72, col = pal[2], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.28_brookite0.72_Au, col = pal[3], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.73_brookite0.27, col = pal[4], type = "b")
points(ints$time, ints$Methylene_blue_anatase0.73_brookite0.27_Au, col = pal[5], type = "b")
legend("topright", col = pal, legend = c("Methylene blue", 
                                         "Methylene blue, anatase (0.28%),brookite (0.72%)", 
                                         "Methylene blue, anatase (0.28%) brookite (0.72%), Au", 
                                         "Methylene blue, anatase (0.73%) brookite (0.27%)",
                                         "Methylene blue, anatase (0.73%) brookite (0.27%) Au"), lwd = 1)
dev.off()