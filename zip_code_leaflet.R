library(rgdal)    # for readOGR and others
library(sp)       # for spatial objects
library(leaflet)  # for interactive maps (NOT leafletR here)
library(dplyr)    # for working with data frames
library(ggplot2)
library(leafletR)
#install.packages(c("leaflet", "sp", "rgdal"))
#install.packages("leafletR")
library(tigris)
library(acs)
library(stringr)
library(rgeos)

library(devtools)

#install.packages("Rcpp")
#install.packages("stringi")

#install_github('arilamstein/choroplethrZip@v1.5.0')
library(choroplethrZip)


##############################
#Finish Setup
##############################

x <- subset(zip.regions, cbsa.title =="Washington-Arlington-Alexandria, DC-VA-MD-WV")

data(df_pop_zip)

?zip_choropleth
zip_choropleth(df_pop_zip, 
               state_zoom="district of columbia", 
               title="2012 State ZCTA Population Estimates",
               legend="Population")


zip_choropleth(df_pop_zip, 
               state_zoom="new york", 
               title="2012 New York State ZCTA Population Estimates",
               legend="Population")

setwd("C:/R/crime/dc")
tract1 <- readOGR(dsn=".", layer = "cb_2015_us_zcta510_500k")
tract <- readOGR(dsn=".", layer = "cb_2015_11_tract_500k")


# ----- Create a subset of New York counties
subdat<-tract[substring(tract$GEOID10, 1, 2) == "11",]

# ----- Transform to EPSG 4326 - WGS84 (required)
subdat<-spTransform(subdat, CRS("+init=epsg:4326"))

# ----- change name of field we will map
names(subdat)[names(subdat) == "DP0010001"]<-"Population"



# ----- save the data slot
subdat_data<-subdat@data[,c("GEOID10", "Population")]

# ----- simplification yields a SpatialPolygons class
subdat<-gSimplify(subdat,tol=0.01, topologyPreserve=TRUE)

# ----- to write to geojson we need a SpatialPolygonsDataFrame
subdat<-SpatialPolygonsDataFrame(subdat, data=subdat_data)


# ----- Write data to GeoJSON
leafdat<-paste(downloaddir, "/", filename, ".geojson", sep="") 


writeOGR(subdat, leafdat, layer="", driver="GeoJSON")


# ----- Create the cuts
cuts<-round(quantile(subdat$Population, probs = seq(0, 1, 0.20), na.rm = FALSE), 0)
cuts[1]<-0 # ----- for this example make first cut zero


# ----- Fields to include in the popup
popup<-c("GEOID10", "Population")


# ----- Gradulated style based on an attribute
sty<-styleGrad(prop="Population", breaks=cuts, right=FALSE, style.par="col",
               style.val=rev(heat.colors(6)), leg="Population (2010)", lwd=1)


# ----- Create the map and load into browser
map<-leaflet(data=leafdat, dest=downloaddir, style=sty,
             title="index", base.map="osm",
             incl.data=TRUE,  popup=popup)

# ----- to look at the map you can use this code
browseURL(map)

