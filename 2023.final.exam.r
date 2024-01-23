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
library(ncdf4)
library(terra)
library(RStoolbox) 


# Data import, setting the work directory

setwd("C:/Users/bruno/OneDrive/Desktop/Spatial.ecology")


# Data saving using the function brick from the package raster

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




#changes in the years of the Fraction of green Vegetation Cover (3-plots comparison)

#difference between the years to see the changes (pixel difference)

#1-->difference between 2000 and 2010 (pixel difference)

#2-->difference between 2010 and 2019 (pixel difference)

#3-->overall pixel difference between 2000 and 2019

#data interpretation
