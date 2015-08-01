# This script only normalizes the data
# We subtract the minimum in the region above 800nm
# and multiply by the maximum in that region.
# We save the normalized data and produce plots for it


# Read all the data files
mb               <- read.table("Methylene_blue.dat")
mbAn0.14Br0.86   <- read.table("Methylene_blue_anatase0.14_brookite0.86.dat")
mbAn0.14Br0.86Au <- read.table("Methylene_blue_anatase0.14_brookite0.86_Au.dat")
mbAn0.73Br0.27   <- read.table("Methylene_blue_anatase0.73_brookite0.27.dat")
mbAn0.73Br0.27Au <- read.table("Methylene_blue_anatase0.73_brookite0.27_Au.dat")
degussap25       <- read.table("Degussa_P25.dat")
# Correct names
names(mb)               <- c("Wavelength", "min195", "min120", "min90", "min60", "min30", "min15", "min5", "min0")
names(mbAn0.14Br0.86)   <- c("Wavelength", "min195", "min120", "min90", "min60", "min30", "min15", "min5", "min0")
names(mbAn0.14Br0.86Au) <- c("Wavelength", "min195", "min120", "min90", "min60", "min30", "min15", "min5", "min0")
names(mbAn0.73Br0.27)   <- c("Wavelength", "min195", "min120", "min90", "min60", "min30", "min15", "min5", "min0")
names(mbAn0.73Br0.27Au) <- c("Wavelength", "min195", "min120", "min90", "min60", "min30", "min15", "min5", "min0")
names(degussap25)       <- c("Wavelength", "min195", "min120", "min90", "min60", "min30", "min15", "min5", "min0")

# Finding the minimum values
mb_min               <- apply(mb[mb$Wavelength > 800,], 2, min)
mbAn0.14Br0.86_min   <- apply(mbAn0.14Br0.86[mbAn0.14Br0.86$Wavelength > 800,], 2, min)
mbAn0.14Br0.86Au_min <- apply(mbAn0.14Br0.86Au[mbAn0.14Br0.86Au$Wavelength > 800,], 2, min)
mbAn0.73Br0.27_min   <- apply(mbAn0.73Br0.27[mbAn0.73Br0.27$Wavelength > 800,], 2, min)
mbAn0.73Br0.27Au_min <- apply(mbAn0.73Br0.27Au[mbAn0.73Br0.27Au$Wavelength > 800,], 2, min)
degussap25_min       <- apply(degussap25[degussap25$Wavelength > 800,], 2, min)

# Subtracting the minimum values
mb_norm               <- sweep(mb, 2, mb_min, "-")
mbAn0.14Br0.86_norm   <- sweep(mbAn0.14Br0.86, 2, mbAn0.14Br0.86_min, "-")
mbAn0.14Br0.86Au_norm <- sweep(mbAn0.14Br0.86Au, 2, mbAn0.14Br0.86Au_min, "-")
mbAn0.73Br0.27_norm   <- sweep(mbAn0.73Br0.27, 2, mbAn0.73Br0.27_min, "-")
mbAn0.73Br0.27Au_norm <- sweep(mbAn0.73Br0.27Au, 2, mbAn0.73Br0.27Au_min, "-")
degussap25_norm       <- sweep(degussap25, 2, degussap25_min, "-")

# Finding the maximum values
mb_max               <- apply(mb_norm[mb$Wavelength > 800,], 2, max)
mbAn0.14Br0.86_max   <- apply(mbAn0.14Br0.86_norm[mbAn0.14Br0.86$Wavelength > 800,], 2, max)
mbAn0.14Br0.86Au_max <- apply(mbAn0.14Br0.86Au_norm[mbAn0.14Br0.86Au$Wavelength > 800,], 2, max)
mbAn0.73Br0.27_max   <- apply(mbAn0.73Br0.27_norm[mbAn0.73Br0.27$Wavelength > 800,], 2, max)
mbAn0.73Br0.27Au_max <- apply(mbAn0.73Br0.27Au_norm[mbAn0.73Br0.27Au$Wavelength > 800,], 2, max)
degussap25_max       <- apply(degussap25_norm[degussap25$Wavelength > 800,], 2, max)

# Dividing by the maximum values
mb_norm               <- sweep(mb_norm, 2, mb_max, "/")
mbAn0.14Br0.86_norm   <- sweep(mbAn0.14Br0.86_norm, 2, mbAn0.14Br0.86_max, "/")
mbAn0.14Br0.86Au_norm <- sweep(mbAn0.14Br0.86Au_norm, 2, mbAn0.14Br0.86Au_max, "/")
mbAn0.73Br0.27_norm   <- sweep(mbAn0.73Br0.27_norm, 2, mbAn0.73Br0.27_max, "/")
mbAn0.73Br0.27Au_norm <- sweep(mbAn0.73Br0.27Au_norm, 2, mbAn0.73Br0.27Au_max, "/")
degussap25_norm       <- sweep(degussap25_norm, 2, degussap25_max, "/")

# Restoring the values of the first column
mb_norm$Wavelength               <- mb$Wavelength
mbAn0.14Br0.86_norm$Wavelength   <- mbAn0.14Br0.86$Wavelength
mbAn0.14Br0.86Au_norm$Wavelength <- mbAn0.14Br0.86Au$Wavelength
mbAn0.73Br0.27_norm$Wavelength   <- mbAn0.73Br0.27$Wavelength
mbAn0.73Br0.27Au_norm$Wavelength <- mbAn0.73Br0.27$Wavelength
degussap25_norm$Wavelength       <- degussap25$Wavelength

# Save the normalized data
write.table(mb_norm,               file = "Methylene_blue_normalized.dat", row.names = FALSE)
write.table(mbAn0.14Br0.86_norm,   file = "Methylene_blue_anatase0.14_brookite0.86_normalized.dat", row.names = FALSE)
write.table(mbAn0.14Br0.86Au_norm, file = "Methylene_blue_anatase0.14_brookite0.86_Au_normalized.dat", row.names = FALSE)
write.table(mbAn0.73Br0.27_norm,   file = "Methylene_blue_anatase0.73_brookite0.27_normalized.dat", row.names = FALSE)
write.table(mbAn0.73Br0.27Au_norm, file = "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.dat", row.names = FALSE)
write.table(degussap25_norm,       file = "Degussa_P25_normalized.dat", row.names = FALSE)


# Plots
pal <- palette(rainbow(9))

png(filename = "Methylene_blue_normalized.png", width = 600, height = 450, units = "px")
plot(mb_norm$Wavelength, mb_norm$min0, type = "n", 
     xlim=c(200,1000), ylim=c(0,8), xlab = "Wavelength (nm)", ylab = "Absorbance (a.u.)")
lines(mb_norm$Wavelength, mb_norm$min0, type = "l", col = pal[1])
lines(mb_norm$Wavelength, mb_norm$min5, type = "l", col = pal[2])
lines(mb_norm$Wavelength, mb_norm$min15, type = "l", col = pal[3])
lines(mb_norm$Wavelength, mb_norm$min30, type = "l", col = pal[4])
lines(mb_norm$Wavelength, mb_norm$min60, type = "l", col = pal[5])
lines(mb_norm$Wavelength, mb_norm$min90, type = "l", col = pal[6])
lines(mb_norm$Wavelength, mb_norm$min120, type = "l", col = pal[7])
lines(mb_norm$Wavelength, mb_norm$min195, type = "l", col = pal[8])
legend("topright", col = pal, legend = c("0 min","5 min","15 min","30 min","60 min","90 min","120 min","195 min"), lwd = 1)
title("Methylene blue (normalized)")
dev.off()

png(filename = "Methylene_blue_anatase0.14_brookite0.86_normalized.png", width = 600, height = 450, units = "px")
plot(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min0, type = "n", 
     xlim=c(200,1000), ylim=c(0,4), xlab = "Wavelength (nm)", ylab = "Absorbance (a.u.)")
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min0, type = "l", col = pal[1])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min5, type = "l", col = pal[2])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min15, type = "l", col = pal[3])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min30, type = "l", col = pal[4])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min60, type = "l", col = pal[5])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min90, type = "l", col = pal[6])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min120, type = "l", col = pal[7])
lines(mbAn0.14Br0.86_norm$Wavelength, mbAn0.14Br0.86_norm$min195, type = "l", col = pal[8])
legend("topright", col = pal, legend = c("0 min","5 min","15 min","30 min","60 min","90 min","120 min","195 min"), lwd = 1)
title("Methylene blue, anatase (0.14) and brookite (0.86) (normalized)")
dev.off()

png(filename = "Methylene_blue_anatase0.14_brookite0.86_Au_normalized.png", width = 600, height = 450, units = "px")
plot(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min0, type = "n", 
     xlim=c(200,1000), ylim=c(0,10), xlab = "Wavelength (nm)", ylab = "Absorbance (a.u.)")
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min0, type = "l", col = pal[1])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min5, type = "l", col = pal[2])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min15, type = "l", col = pal[3])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min30, type = "l", col = pal[4])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min60, type = "l", col = pal[5])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min90, type = "l", col = pal[6])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min120, type = "l", col = pal[7])
lines(mbAn0.14Br0.86Au_norm$Wavelength, mbAn0.14Br0.86Au_norm$min195, type = "l", col = pal[8])
legend("topright", col = pal, legend = c("0 min","5 min","15 min","30 min","60 min","90 min","120 min","195 min"), lwd = 1)
title("Methylene blue, anatase (0.14), brookite (0.86) and Au (normalized)")
dev.off()

png(filename = "Methylene_blue_anatase0.73_brookite0.27_normalized.png", width = 600, height = 450, units = "px")
plot(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min0, type = "n", 
     xlim=c(200,1000), ylim=c(0,4), xlab = "Wavelength (nm)", ylab = "Absorbance (a.u.)")
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min0, type = "l", col = pal[1])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min5, type = "l", col = pal[2])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min15, type = "l", col = pal[3])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min30, type = "l", col = pal[4])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min60, type = "l", col = pal[5])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min90, type = "l", col = pal[6])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min120, type = "l", col = pal[7])
lines(mbAn0.73Br0.27_norm$Wavelength, mbAn0.73Br0.27_norm$min195, type = "l", col = pal[8])
legend("topright", col = pal, legend = c("0 min","5 min","15 min","30 min","60 min","90 min","120 min","195 min"), lwd = 1)
title("Methylene blue, anatase (0.73) and brookite (0.27) (normalized)")
dev.off()

png(filename = "Methylene_blue_anatase0.73_brookite0.27_Au_normalized.png", width = 600, height = 450, units = "px")
plot(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min0, type = "n", 
     xlim=c(200,1000), ylim=c(0,10), xlab = "Wavelength (nm)", ylab = "Absorbance (a.u.)")
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min0, type = "l", col = pal[1])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min5, type = "l", col = pal[2])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min15, type = "l", col = pal[3])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min30, type = "l", col = pal[4])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min60, type = "l", col = pal[5])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min90, type = "l", col = pal[6])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min120, type = "l", col = pal[7])
lines(mbAn0.73Br0.27Au_norm$Wavelength, mbAn0.73Br0.27Au_norm$min195, type = "l", col = pal[8])
legend("topright", col = pal, legend = c("0 min","5 min","15 min","30 min","60 min","90 min","120 min","195 min"), lwd = 1)
title("Methylene blue, anatase (0.73), brookite (0.27) and Au (normalized)")
dev.off()

png(filename = "Degussa_P25_normalized.png", width = 600, height = 450, units = "px")
plot(degussap25_norm$Wavelength, degussap25_norm$min0, type = "n", 
     xlim=c(200,1000), ylim=c(0,8), xlab = "Wavelength (nm)", ylab = "Absorbance (a.u.)")
lines(degussap25_norm$Wavelength, degussap25_norm$min0, type = "l", col = pal[1])
lines(degussap25_norm$Wavelength, degussap25_norm$min5, type = "l", col = pal[2])
lines(degussap25_norm$Wavelength, degussap25_norm$min15, type = "l", col = pal[3])
lines(degussap25_norm$Wavelength, degussap25_norm$min30, type = "l", col = pal[4])
lines(degussap25_norm$Wavelength, degussap25_norm$min60, type = "l", col = pal[5])
lines(degussap25_norm$Wavelength, degussap25_norm$min90, type = "l", col = pal[6])
lines(degussap25_norm$Wavelength, degussap25_norm$min120, type = "l", col = pal[7])
lines(degussap25_norm$Wavelength, degussap25_norm$min195, type = "l", col = pal[8])
legend("topright", col = pal, legend = c("0 min","5 min","15 min","30 min","60 min","90 min","120 min","195 min"), lwd = 1)
title("Methylene blue (normalized)")
dev.off()
