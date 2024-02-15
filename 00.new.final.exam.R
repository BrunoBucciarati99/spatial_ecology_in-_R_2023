# Packages needed
library(tidyterra) #interface between terra package and tidyverse package (including ggplot2)
library(viridis) #colorblind-friendly map
library(ggplot2) #data visualization
library(terra) #geospatial data analysis for raster data

# Data import, setting the work directory

setwd("C:/Users/bruno/OneDrive/Desktop/Spatial.ecology")

# Data saving using the function raster

fcover2000<-rast("FCOVER2000.nc")
fcover2010<-rast("FCOVER2010.nc")
fcover2019<-rast("FCOVER2019.nc")

# Cutting the map define the extent of the research

ext <- c(-26,-12,63,67)
iceland2000<- crop(fcover2000, ext)
iceland2010<- crop(fcover2010, ext)
iceland2019<- crop(fcover2019, ext)

plot(iceland2000)
plot(iceland2010)
plot(iceland2019)

dev.off()

# Plot using ggplot2
ggplot2000<-ggplot() + 
  geom_raster(iceland2000, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FRACTION OF GREEN VEGETATION COVER 2000")

ggplot2010<-ggplot() + 
  geom_raster(iceland2010, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FRACTION OF GREEN VEGETATION COVER 2010")

ggplot2019<-ggplot() + 
  geom_raster(iceland2019, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FRACTION OF GREEN VEGETATION COVER 2019")

ggplot2000
ggplot2010
ggplot2019

dev.off()

#saving the new images in jpeg format

ggsave("ggplot2000.jpg", ggplot2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot2010.jpg", ggplot2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot2019.jpg", ggplot2019, device = "jpeg", 
       width = 9, height = 5, units = "in")

# Difference between years to see the changes 

dif2010_2000<-iceland2010-iceland2000

dif2019_2010 <- iceland2019-iceland2010

dif2019_2000 <- iceland2019-iceland2000

plot(dif2010_2000)
plot(dif2019_2010)
plot(dif2019_2000)

# Plotting the differences using ggplot2

ggplot_dif2010_2000 <- ggplot() + 
  geom_raster(dif2010_2000, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FCOVER Change: 2010 - 2000")

ggplot_dif2019_2010 <- ggplot() + 
  geom_raster(dif2019_2010, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FCOVER Change: 2019 - 2010")

ggplot_dif2019_2000 <- ggplot() + 
  geom_raster(dif2019_2000, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FCOVER Change: 2019 - 2000")

ggplot_dif2010_2000
ggplot_dif2019_2010
ggplot_dif2019_2000

#saving the new images in jpeg format

ggsave("ggplot_dif2010_2000.jpg", ggplot_dif2010_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_dif2019_2010", ggplot_dif2019_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_dif2019_2000", ggplot_dif2019_2000, device = "jpeg", 
       width = 9, height = 5, units = "in")

#pixel estimation

#total pixel estimation
total_pixels_2000 <- ncell(iceland2000)
total_pixels_2010 <- ncell(iceland2010)
total_pixels_2019 <- ncell(iceland2019)

total_pixels_2000
total_pixels_2010
total_pixels_2019

# Calculation of n. of pixels for values in FCOVER higher than 0 
#data extraction and exclusion of missing values
vegetation_pixels_2000 <- sum(iceland2000[["FCOVER"]][] > 0, na.rm = TRUE)
vegetation_pixels_2010 <- sum(iceland2010[["FCOVER"]][] > 0, na.rm = TRUE)
vegetation_pixels_2019 <- sum(iceland2019[["FCOVER"]][] > 0, na.rm = TRUE)

vegetation_pixels_2000 
vegetation_pixels_2010 
vegetation_pixels_2019

# Calculation of the percentage of vegetation cover over the total pixels
percentage_cover_2000 <- (vegetation_pixels_2000 / total_pixels_2000) * 100
percentage_cover_2010 <- (vegetation_pixels_2010 / total_pixels_2010) * 100
percentage_cover_2019 <- (vegetation_pixels_2019 / total_pixels_2019) * 100

percentage_cover_2000
percentage_cover_2010
percentage_cover_2019

#calculation of the pixel difference related to Fcover in 2000,2010,2019
percentage_cover_change2010_2000<-percentage_cover_2010-percentage_cover_2000
percentage_cover_change2019_2010<-percentage_cover_2019-percentage_cover_2010
percentage_cover_change2019_2000<-percentage_cover_2019-percentage_cover_2000

percentage_cover_change2010_2000
percentage_cover_change2019_2010
percentage_cover_change2019_2000


#data interpretation

#################################################################################
#################################################################################

#What kind of vegetation is lost? Leaf Area Index (LAI) assessment

# Data saving using the function raster
LAI2000<-rast("LAI2000.nc")
LAI2010<-rast("LAI2010.nc")
LAI2019<-rast("LAI2019.nc")

# Cutting the map define the extent of the research
ext <- c(-26,-12,63,67)

LAIiceland2000<- crop(LAI2000, ext)
LAIiceland2010<- crop(LAI2010, ext)
LAIiceland2019<- crop(LAI2019, ext)

plot(LAIiceland2000)
plot(LAIiceland2010)
plot(LAIiceland2019)

# Plot using ggplot2
ggplot_LAI_2000<-ggplot() + 
  geom_raster(LAIiceland2000, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LEAF AREA INDEX 2000")

ggplot_LAI_2010<-ggplot() + 
  geom_raster(LAIiceland2010, mapping = aes(x=x,  y = y, fill = LAI)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LEAF AREA INDEX 2010")

ggplot_LAI_2019<-ggplot() + 
  geom_raster(LAIiceland2019, mapping = aes(x=x,  y = y, fill = LAI)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LEAF AREA INDEX 2019")

ggplot_LAI_2000
ggplot_LAI_2010
ggplot_LAI_2019

#saving the new images in jpeg format

ggsave("ggplot_LAI_2000.jpg", ggplot_LAI_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_2010.jpg", ggplot_LAI_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_2019.jpg", ggplot_LAI_2019, device = "jpeg", 
       width = 9, height = 5, units = "in")

# Difference between years to see the changes 

LAI_dif2010_2000<-LAIiceland2010-LAIiceland2000

LAI_dif2019_2010<-LAIiceland2019-LAIiceland2010

LAI_dif2019_2000<-LAIiceland2019-LAIiceland2000


# Plotting the differences using ggplot2

ggplot_LAI_dif2010_2000 <- ggplot() + 
  geom_raster(LAI_dif2010_2000, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LAI Change: 2010 - 2000")


ggplot_LAI_dif2019_2010 <- ggplot() + 
  geom_raster(LAI_dif2019_2010, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LAI Change: 2019 - 2010")

ggplot_LAI_dif2019_2000 <- ggplot() + 
  geom_raster(LAI_dif2019_2000, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LAI Change: 2019 - 2000")

ggplot_LAI_dif2010_2000
ggplot_LAI_dif2019_2010
ggplot_LAI_dif2019_2000

#saving the new images in jpeg format

ggsave("ggplot_LAI_dif2010_2000.jpg", ggplot_LAI_dif2010_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_dif2019_2010.jpg", ggplot_LAI_dif2019_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_dif2019_2000.jpg", ggplot_LAI_dif2019_2000, device = "jpeg", 
       width = 9, height = 5, units = "in")

#pixel estimation
#total pixel estimation
tot_pixel_2000<-ncell(LAIiceland2000)
tot_pixel_2010<-ncell(LAIiceland2010)
tot_pixel_2019<-ncell(LAIiceland2019)

tot_pixel_2000
tot_pixel_2010
tot_pixel_2019

#Pixel estimation for different values of LAI
#Exclusion of NA values before considering the pixels based on their value 
#LAI values greater than 3 --> value associated with moderate vegetation density.
LAI_pixels_2000 <- sum(!is.na(LAIiceland2000[["LAI"]][]) & LAIiceland2000[["LAI"]][] > 3)
LAI_pixels_2010 <- sum(!is.na(LAIiceland2010[["LAI"]][]) & LAIiceland2010[["LAI"]][] > 3)
LAI_pixels_2019 <- sum(!is.na(LAIiceland2019[["LAI"]][]) & LAIiceland2019[["LAI"]][] > 3)

LAI_pixels_2000 
LAI_pixels_2010 
LAI_pixels_2019

# Calculation of the percentage of LAI cover > 3 over the total pixels
LAI_percentage_cover_2000 <- (LAI_pixels_2000 / tot_pixel_2000) * 100
LAI_percentage_cover_2010 <- (LAI_pixels_2010 / tot_pixel_2010) * 100
LAI_percentage_cover_2019 <- (LAI_pixels_2019 / tot_pixel_2019) * 100

LAI_percentage_cover_2000 
LAI_percentage_cover_2010 
LAI_percentage_cover_2019 
