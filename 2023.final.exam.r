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
library(ncdf4)???



# Data import, setting the work directory
setwd("C:/Users/bruno/OneDrive/Desktop/Spatial.ecology")


# Data saving using the function brick from the package raster
iceland2000<-brick("FCOVER2000.nc")
iceland2010<-brick("FCOVER2010.nc")
iceland2019<-brick("FCOVER2019.nc")
iceland2000

# Plotting the data with the function "plotRGB()" to have a look at the images
plot(iceland2000)
plot
plotRGB(iceland2000, r=3, g=2, b=1, stretch="hist")
plotRGB(iceland2010, r=3, g=2, b=1, stretch="hist")
plotRGB(iceland2019, r=3, g=2, b=1, stretch="hist")

# Cutting the map define the extent of the research
ext <- c(-24,-12,63,67)
cropiceland2000<-crop(iceland2000, ext)
cropiceland2010<-crop(iceland2010, ext)
cropiceland2019<-crop(iceland2019, ext)

plot(cropiceland2000)
plot(cropiceland2010)
plot(cropiceland2019)


#changes in the years of the Fraction of green Vegetation Cover

#difference between the years to see the changes

#difference between 2000 and 2010

#difference between 2010 and 2019
