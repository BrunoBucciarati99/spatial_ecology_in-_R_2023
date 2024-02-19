# Packages needed
library(tidyterra) #interface between terra and tidyverse 
library(viridis) #colorblind-friendly map
library(ggplot2) #data visualization
library(terra) #geospatial data analysis for raster data

# Data import, setting the work directory

setwd("C:/Users/bruno/OneDrive/Desktop/Spatial.ecology")

# Data saving using the function rast

fcover2000<-rast("FCOVER2000.nc")
fcover2010<-rast("FCOVER2010.nc")
fcover2019<-rast("FCOVER2019.nc")

# Cutting the map define the extent of the research

ext <- c(-26,-12,63,67)
iceland2000<- crop(fcover2000, ext)
iceland2010<- crop(fcover2010, ext)
iceland2019<- crop(fcover2019, ext)

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

#saving the new images in jpeg format

ggsave("ggplot2000.jpg", ggplot2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot2010.jpg", ggplot2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot2019.jpg", ggplot2019, device = "jpeg", 
       width = 9, height = 5, units = "in")

# Difference between years to see the changes 

dif2010_2000 <- iceland2010-iceland2000
dif2019_2010 <- iceland2019-iceland2010
dif2019_2000 <- iceland2019-iceland2000

# Plotting the differences using ggplot2

ggplot_dif2010_2000 <- ggplot() + 
  geom_raster(dif2010_2000, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FCOVER Change: 2000 - 2010")

ggplot_dif2019_2010 <- ggplot() + 
  geom_raster(dif2019_2010, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FCOVER Change: 2010 - 2019")

ggplot_dif2019_2000 <- ggplot() + 
  geom_raster(dif2019_2000, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("FCOVER Change: 2000 - 2019")

#saving the new images in jpeg format

ggsave("ggplot_dif2010_2000.jpg", ggplot_dif2010_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_dif2019_2010.jpg", ggplot_dif2019_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_dif2019_2000.jpg", ggplot_dif2019_2000, device = "jpeg", 
       width = 9, height = 5, units = "in")

#pixel estimation
#total pixel estimation
total_pixels_2000 <- ncell(iceland2000)
total_pixels_2010 <- ncell(iceland2010)
total_pixels_2019 <- ncell(iceland2019)

# Calculation of n. of pixels for values in FCOVER higher than 0 
# Data extraction and exclusion of missing values
vegetation_pixels_2000 <- sum(iceland2000[["FCOVER"]][] > 0, na.rm = TRUE)
vegetation_pixels_2010 <- sum(iceland2010[["FCOVER"]][] > 0, na.rm = TRUE)
vegetation_pixels_2019 <- sum(iceland2019[["FCOVER"]][] > 0, na.rm = TRUE)

# Calculation of the percentage of vegetation cover over the total pixels
percentage_cover_2000 <- (vegetation_pixels_2000 / total_pixels_2000) * 100
percentage_cover_2010 <- (vegetation_pixels_2010 / total_pixels_2010) * 100
percentage_cover_2019 <- (vegetation_pixels_2019 / total_pixels_2019) * 100

#calculation of the pixel difference related to Fcover in 2000,2010,2019
percentage_cover_change2010_2000<-percentage_cover_2010-percentage_cover_2000
percentage_cover_change2019_2010<-percentage_cover_2019-percentage_cover_2010
percentage_cover_change2019_2000<-percentage_cover_2019-percentage_cover_2000

#data interpretation

#################################################################################
#################################################################################

#What kind of vegetation is lost? Leaf Area Index (LAI) assessment

# Data saving using the function rast
LAI2000<-rast("LAI2000.nc")
LAI2010<-rast("LAI2010.nc")
LAI2019<-rast("LAI2019.nc")

# Cutting the map define the extent of the research
ext <- c(-26,-12,63,67)

LAIiceland2000<- crop(LAI2000, ext)
LAIiceland2010<- crop(LAI2010, ext)
LAIiceland2019<- crop(LAI2019, ext)

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
  ggtitle("LAI Change: 2000 - 2010")

ggplot_LAI_dif2019_2010 <- ggplot() + 
  geom_raster(LAI_dif2019_2010, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LAI Change: 2010 - 2019")

ggplot_LAI_dif2019_2000 <- ggplot() + 
  geom_raster(LAI_dif2019_2000, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("LAI Change: 2000 - 2019")

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

# Calculation of n. of pixels for values in LAI higher than 0 
# Data extraction and exclusion of missing values
LAI_pixels_2000 <- sum(LAIiceland2000[["LAI"]][] > 0, na.rm = TRUE)
LAI_pixels_2010 <- sum(LAIiceland2010[["LAI"]][] > 0, na.rm = TRUE)
LAI_pixels_2019 <- sum(LAIiceland2019[["LAI"]][] > 0, na.rm = TRUE)

# Calculation of the percentage of LAI cover over the total pixels
LAI_perc_cover_2000 <- (LAI_pixels_2000 / tot_pixel_2000) * 100
LAI_perc_cover_2010 <- (LAI_pixels_2010 / tot_pixel_2010) * 100
LAI_perc_cover_2019 <- (LAI_pixels_2019 / tot_pixel_2019) * 100

#calculation of the pixel difference related to LAI in 2000,2010,2019
LAI_cover_change2010_2000<-LAI_perc_cover_2010-LAI_perc_cover_2000
LAI_cover_change2019_2010<-LAI_perc_cover_2019-LAI_perc_cover_2010
LAI_cover_change2019_2000<-LAI_perc_cover_2019-LAI_perc_cover_2000

#Pixel estimation for different values of LAI
#Exclusion of NA values before considering the pixels based on their value 
#LAI values greater than 3 --> value associated with moderate vegetation density.
LAI_pix_2000 <- sum(!is.na(LAIiceland2000[["LAI"]][]) & LAIiceland2000[["LAI"]][] > 3)
LAI_pix_2010 <- sum(!is.na(LAIiceland2010[["LAI"]][]) & LAIiceland2010[["LAI"]][] > 3)
LAI_pix_2019 <- sum(!is.na(LAIiceland2019[["LAI"]][]) & LAIiceland2019[["LAI"]][] > 3)

# Calculation of the percentage of LAI cover > 3 over the total pixels
LAI_percentage_cover_2000 <- (LAI_pix_2000 / tot_pixel_2000) * 100
LAI_percentage_cover_2010 <- (LAI_pix_2010 / tot_pixel_2010) * 100
LAI_percentage_cover_2019 <- (LAI_pix_2019 / tot_pixel_2019) * 100

#To visualize the results:
# Extract the LAI layer from the raster
lai_layer2000 <- LAIiceland2000[["LAI"]]
lai_layer2010 <- LAIiceland2010[["LAI"]]
lai_layer2019 <- LAIiceland2019[["LAI"]]

# Replace LAI values lower than 3 with NA
lai_layer2000[lai_layer2000 < 3] <- NA
lai_layer2010[lai_layer2010 < 3] <- NA
lai_layer2019[lai_layer2019 < 3] <- NA

# Load Iceland map with the "getData" function from raster package
Iceland_map <- raster::getData("GADM", country = "IS", level=0)

# Overlap the pixels obtained and the icelandic map with ggplot 

ggplot_LAI_3_2000 <- ggplot() +
  geom_polygon(data = Iceland_map, aes(x = long, y = lat, group = group), 
  fill = "white", color = "black") +
  geom_raster(data = lai_layer2000, aes(x = x, y = y, fill = LAI), alpha = 0.8) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Leaf Area Index > 3  (2000)") +
  coord_fixed(ratio = 2)

ggplot_LAI_3_2010 <- ggplot() +
  geom_polygon(data = Iceland_map, aes(x = long, y = lat, group = group), 
  fill = "white", color = "black") +
  geom_raster(data = lai_layer2010, aes(x = x, y = y, fill = LAI), alpha = 0.8) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Leaf Area Index > 3  (2010)") +
  coord_fixed(ratio = 2)

ggplot_LAI_3_2019 <- ggplot() +
  geom_polygon(data = Iceland_map, aes(x = long, y = lat, group = group), 
  fill = "white", color = "black") +
  geom_raster(data = lai_layer2019, aes(x = x, y = y, fill = LAI), alpha = 0.8) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Leaf Area Index > 3  (2019)") +
  coord_fixed(ratio = 2)

##saving the new images in jpeg format
ggsave("ggplot_LAI_3_2000.jpg", ggplot_LAI_3_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_3_2010.jpg", ggplot_LAI_3_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_3_2019.jpg", ggplot_LAI_3_2019, device = "jpeg", 
       width = 9, height = 5, units = "in")

#process repeated by excluding pixels with LAI < 2 and LAI < 1
