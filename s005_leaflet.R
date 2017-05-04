
library(leaflet)
hom <- d %>% subset(OFFENSE == "HOMICIDE")
m <- leaflet(data = hom) %>% addTiles() %>%
  addMarkers(~XBLOCK, ~YBLOCK, popup = ~as.character(hom$REPORT_DAT))

m  
library(htmlwidgets)
saveWidget(m, file="homoicide_plot.html")

###hard to loadd
###Save and attache




leaflet(geo_s) %>% addTiles() %>% addMarkers(popup = ~paste("Average Houshold income: " ,
                                                            as.character(geo_s$avg_house_inc), "<br>", "Ave House Size: ", as.character(geo_s$avg_house_size)),
                                             clusterOptions = markerClusterOptions() )  %>% 
  addMarkers(data=comm_geo, popup = ~as.character(comm_geo$dod_commissary_gis.us_military_installation)) %>%
  
  addCircles(data =d3, lng = ~lon, lat = ~lat, weight = 1,
             radius = d3$pop * 3, popup = ~paste("Est Mil Child Pop: ",as.character(d3$pop)))


