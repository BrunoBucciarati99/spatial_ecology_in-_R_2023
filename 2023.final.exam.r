#Exam project
#Analysis of variations in the Fraction of green Vegetation Cover in Iceland, from may/august 2000 to may/august 2019
#The datas are taken from Copernicus Global Land Service and include the period from the beginning of May to end of August of 2000, 2010, and 2019.
#The systematic deforestation started by the Vikings led Iceland to have only 2% of its territory covered by trees. 
#Therefore, the Icelandic Forest Service has decided to reach 12% by 2100.
#The aim of the work is to analyze the change in the Fraction of green Vegetation Cover in Iceland from 2000 to 2019 to verify whether reforestation projects are working or not

# Packages needed

# define the extent
ext <- c(-180, 180, -90, 90)
newimage <- crop(image, ext)

library(ncdf4)
