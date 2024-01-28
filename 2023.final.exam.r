#Exam project
#Analysis of variations in the Fraction of green Vegetation Cover in Iceland, from may/august 2000 to may/august 2019
#The datas are taken from Copernicus Global Land Service and include the period from the beginning of May to end of August of 2000, 2010, and 2019.
#The systematic deforestation started by the Vikings led Iceland to have only 2% of its territory covered by trees. 
#Therefore, the Icelandic Forest Service has decided to reach 12% by 2100.
#The aim of the work is to analyze the change in the Fraction of green Vegetation Cover in Iceland from 2000 to 2019 to verify whether reforestation projects are working or not

# Packages needed

library(viridis) #colorblind-friendly map
library(raster) #data analysis and modelling
library(ggplot2) #data visualization
library(patchwork) #composer of plots

# Data import, setting the work directory

setwd("C:/Users/bruno/OneDrive/Desktop/Spatial.ecology")


# Data saving using the function raster

fcover2000<-raster("FCOVER2000.nc")
fcover2010<-raster("FCOVER2010.nc")
fcover2019<-raster("FCOVER2019.nc")


# Cutting the map define the extent of the research

ext <- c(-26,-12,63,67)
iceland2000<- crop(fcover2000, ext)
iceland2010<- crop(fcover2010, ext)
iceland2019<- crop(fcover2019, ext)


plot(iceland2000)
plot(iceland2010)
plot(iceland2019)


# Convert raster to data frame
iceland2000_df <- as.data.frame(iceland2000, xy = TRUE)
iceland2010_df <- as.data.frame(iceland2010, xy = TRUE)
iceland2019_df <- as.data.frame(iceland2019, xy = TRUE)

# Plot using ggplot2
ggplot2000<-ggplot(iceland2000_df, aes(x = x, y = y, 
                                       fill = Fraction.of.green.Vegetation.Cover.1km)) +geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("FCOVER 2000")


ggplot2010<-ggplot(iceland2010_df, aes(x = x, y = y, 
                                       fill = Fraction.of.green.Vegetation.Cover.1km)) +geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("FCOVER 2010")


ggplot2019<-ggplot(iceland2019_df, aes(x = x, y = y, 
                                       fill = Fraction.of.green.Vegetation.Cover.1km)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("FCOVER 2019")

ggplot2000
ggplot2010
ggplot2019

?scale_fill_viridis

#saving the new images in jpeg format

ggsave("ggplot2000.jpg", ggplot2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot2010.jpg", ggplot2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot2019.jpg", ggplot2019, device = "jpeg", 
       width = 9, height = 5, units = "in")

#changes in the years of the Fraction of green Vegetation Cover (3-plots comparison)
# arrange the plots toghether and save in JPEG

#vertical way
combined_plots <- ggplot2000 / ggplot2010 / ggplot2019 +
  plot_layout(nrow = 3, heights = c(1, 1, 1))

combined_plots

ggsave("combined_plots.jpg", combined_plots, 
       device = "jpeg", width = 9, height = 10, units = "in")

##horizontal way
combined_plots <- ggplot2000 / ggplot2010 / ggplot2019 +
  plot_layout(nrow = 2, ncol = 2, heights = c(1, 1, 1))

combined_plots

ggsave("combined_plots.jpg", combined_plots, 
       device = "jpeg", width = 16, height = 9, units = "in")

# Difference between years to see the changes 

dif2010_2000<-iceland2010-iceland2000

dif2019_2010 <- iceland2019-iceland2010

dif2019_2000 <- iceland2019-iceland2000

plot(dif2010_2000)
plot(dif2019_2010)
plot(dif2019_2000)

# Convert raster to data frame

dif2010_2000_df <- as.data.frame(dif2010_2000, xy = TRUE)
dif2019_2010_df <- as.data.frame(dif2019_2010, xy = TRUE)
dif2019_2000_df <- as.data.frame(dif2019_2000, xy = TRUE)

# Plotting the differences using ggplot2

ggplot_dif2010_2000 <- ggplot(dif2010_2000_df, aes(x = x, y = y, 
                                                   fill = layer)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("FCOVER Change: 2010 - 2000")

ggplot_dif2019_2010 <- ggplot(dif2019_2010_df, aes(x = x, y = y, 
                                                   fill = layer)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("FCOVER Change: 2019 - 2010")

ggplot_dif2019_2000 <- ggplot(dif2019_2000_df, aes(x = x, y = y, 
                                                   fill = layer)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
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

#fcover estimation 
#exclusion of NA values before checking if the pixel values are greater than 0.
#values higher than 0 consider all the different qualities of Fcover.
vegetation_pixels_2000 <- sum(!is.na(iceland2000[]) & iceland2000[] > 0)
vegetation_pixels_2010 <- sum(!is.na(iceland2010[]) & iceland2010[] > 0)
vegetation_pixels_2019 <- sum(!is.na(iceland2019[]) & iceland2019[] > 0)

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
#################################################################################

#What kind of vegetation is lost? Leaf Area Index (LAI) assessment

# Data saving using the function raster
LAI2000<-raster("LAI2000.nc")
LAI2010<-raster("LAI2010.nc")
LAI2019<-raster("LAI2019.nc")

LAI2000
LAI2010
LAI2019


# Cutting the map define the extent of the research
ext <- c(-26,-12,63,67)

LAIiceland2000<- crop(LAI2000, ext)
LAIiceland2010<- crop(LAI2010, ext)
LAIiceland2019<- crop(LAI2019, ext)

plot(LAIiceland2000)
plot(LAIiceland2010)
plot(LAIiceland2019)


# Convert raster to data frame
LAIiceland2000_df <- as.data.frame(LAIiceland2000, xy = TRUE)
LAIiceland2010_df <- as.data.frame(LAIiceland2010, xy = TRUE)
LAIiceland2019_df <- as.data.frame(LAIiceland2019, xy = TRUE)

# Plot using ggplot2
ggplot_LAI_2000<-ggplot(LAIiceland2000_df, aes(x = x, y = y, 
          fill = Leaf.Area.Index.1km)) +geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("LEAF AREA INDEX 2000")


ggplot_LAI_2010<-ggplot(LAIiceland2010_df, aes(x = x, y = y, 
         fill = Leaf.Area.Index.1km)) +geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("LEAF AREA INDEX 2010")


ggplot_LAI_2019<-ggplot(LAIiceland2019_df, aes(x = x, y = y, 
           fill = Leaf.Area.Index.1km)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
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

LAI_dif2019_2010 <- LAIiceland2019-LAIiceland2010

LAI_dif2019_2000 <- LAIiceland2019-LAIiceland2000

plot(LAI_dif2010_2000)
plot(LAI_dif2019_2010)
plot(LAI_dif2019_2000)

# Convert raster to data frame

LAI_dif2010_2000_df <- as.data.frame(LAI_dif2010_2000, xy = TRUE)
LAI_dif2019_2010_df <- as.data.frame(LAI_dif2019_2010, xy = TRUE)
LAI_dif2019_2000_df <- as.data.frame(LAI_dif2019_2000, xy = TRUE)

# Plotting the differences using ggplot2

ggplot_LAI_dif2010_2000 <- ggplot(LAI_dif2010_2000_df, aes(x = x, y = y, 
                                                   fill = layer)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("LAI Change: 2010 - 2000")

ggplot_LAI_dif2019_2010 <- ggplot(LAI_dif2019_2010_df, aes(x = x, y = y, 
                                                   fill = layer)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("LAI Change: 2019 - 2010")

ggplot_LAI_dif2019_2000 <- ggplot(LAI_dif2019_2000_df, aes(x = x, y = y, 
                                                   fill = layer)) +
  geom_tile() +
  scale_fill_viridis(option = "turbo") +
  ggtitle("LAI Change: 2019 - 2000")

ggplot_LAI_dif2010_2000
ggplot_LAI_dif2019_2010
ggplot_LAI_dif2019_2000

#saving the new images in jpeg format

ggsave("ggplot_LAI_dif2010_2000.jpg", ggplot_LAI_dif2010_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_dif2019_2010", ggplot_LAI_dif2019_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_dif2019_2000", ggplot_LAI_dif2019_2000, device = "jpeg", 
       width = 9, height = 5, units = "in")


#pixel estimation

#total pixel estimation
tot_pixel_2000<-ncell(LAIiceland2000)
tot_pixel_2010<-ncell(LAIiceland2010)
tot_pixel_2019<-ncell(LAIiceland2019)

tot_pixel_2000
tot_pixel_2010
tot_pixel_2019

#LAI estimation 
#exclusion of NA values before checking if the pixel 
#LAI values greater than 3 --> value associated with moderate vegetation density.
LAI_pixels_2000 <- sum(!is.na(LAIiceland2000[]) & LAIiceland2000[] > 3)
LAI_pixels_2010 <- sum(!is.na(LAIiceland2010[]) & LAIiceland2010[] > 3)
LAI_pixels_2019 <- sum(!is.na(LAIiceland2019[]) & LAIiceland2019[] > 3)

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

# Filter LAI values greater than 3
LAIiceland2000[LAIiceland2000 < 3] <- NA
LAIiceland2010[LAIiceland2010 < 3] <- NA
LAIiceland2019[LAIiceland2019 < 3] <- NA

# Load Iceland map
Iceland_map <- getData("GADM", country = "IS", level=0)

# Convert Iceland map to data frame
Iceland_map_df <- fortify(Iceland_map)

# Convert raster to data frame for ggplot2
LAI2000_df <- as.data.frame(LAIiceland2000, xy = TRUE)
LAI2010_df <- as.data.frame(LAIiceland2010, xy = TRUE)
LAI2019_df <- as.data.frame(LAIiceland2019, xy = TRUE)

# Plot using ggplot2
ggplot_LAI_3_2000<-ggplot() +
  geom_polygon(data = Iceland_map_df, aes(x = long, y = lat, group = group), fill = "white", color = "black") +
  geom_raster(data = LAI2000_df, aes(x = x, y = y, fill = Leaf.Area.Index.1km), alpha = 0.8) +
  scale_fill_viridis(option = "turbo", name = "LAI", guide = "legend") +
  labs(title = "Leaf Area Index > 3 - 2000") + coord_fixed(ratio = 2)

ggplot_LAI_3_2010<-ggplot() +
  geom_polygon(data = Iceland_map_df, aes(x = long, y = lat, group = group), fill = "white", color = "black") +
  geom_raster(data = LAI2010_df, aes(x = x, y = y, fill = Leaf.Area.Index.1km), alpha = 0.8) +
  scale_fill_viridis(option = "turbo", name = "LAI", guide = "legend") +
  labs(title = "Leaf Area Index > 3 - 2010") + coord_fixed(ratio = 2)

ggplot_LAI_3_2019<-ggplot() +
  geom_polygon(data = Iceland_map_df, aes(x = long, y = lat, group = group), fill = "white", color = "black") +
  geom_raster(data = LAI2019_df, aes(x = x, y = y, fill = Leaf.Area.Index.1km), alpha = 0.8) +
  scale_fill_viridis(option = "turbo", name = "LAI", guide = "legend") +
  labs(title = "Leaf Area Index > 3 - 2019") + coord_fixed(ratio = 2)

ggplot_LAI_3_2000
ggplot_LAI_3_2010
ggplot_LAI_3_2019

##saving the new images in jpeg format
ggsave("ggplot_LAI_3_2000.jpg", ggplot_LAI_3_2000, device = "jpeg",
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_3_2010.jpg", ggplot_LAI_3_2010, device = "jpeg", 
       width = 9, height = 5, units = "in")

ggsave("ggplot_LAI_3_2019.jpg", ggplot_LAI_3_2019, device = "jpeg", 
       width = 9, height = 5, units = "in")

#process repeated for LAI > 2 and LAI > 1
