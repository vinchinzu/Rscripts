### Install geospatial data extraction library
library(rgdal)

### import data
#nad83_cords <-read.csv('C:/Documents/Crime_Data.csv')

### identify coordinates in data
coordinates(nad83_coords) <- c('XBLOCK', 'YBLOCK')
## identify coordinate system in data (NAD8¬3, EPSG: 26985)
proj4string(nad83_coords)=CRS("+init=EPSG:26985")
## transform coordinate system to standard lat/long (WGS82, EPSG:426)
coordinates_deg <- spTransform(nad83_coords,CRS("+init=epsg:4326"))
## export results; be sure to flip long and lat in results
write.csv(coordinates_deg,'C:/R/Export_Crime_Data.csv')



coordinates_deg$XBLOCK
x <- coordinates_deg 
head(x)

