library(dplyr)    # for working with data frames
library(ggplot2)
library(ggmap)
library(ggthemes) 
library(lubridate)

#install.packages("ggthemes")
#install.packages("lubridate")

setwd("C:/R/dc_crime/")
  data <- read.csv("dc_crime_lon_lat.csv", stringsAsFactors =F)
  
  d <- data %>% select(REPORT_DAT,OFFENSE,METHOD,WARD,XBLOCK,YBLOCK)
  
  #mean(d$XBLOCK)
  # -77.00819
  # mean(d$YBLOCK)
  # 38.90592  
   
d <- data
d$date <- ymd_hms(d$REPORT_DAT)

d <- d %>% mutate(year = year(date), month = month(date), 
                  day = day(date), hour = hour(date),
                  minute = minute(date),
                  second = second(date))
  
#38.889762, -77.036216
#38.8895° N, 77.0353° W
d <- d %>% mutate(EW = ifelse(XBLOCK > -77.0362, "East", "West"), 
                  NS = ifelse(YBLOCK > 38.8895, "North", "South"))


#add Quadrant

d <- d %>% mutate(quad = ifelse(EW == "West" & NS == "North", "Northwest", 
                                ifelse(EW == "East" & NS == "North", "Northeast", 
                                       ifelse(EW == "West" & NS == "South", "Southwest",
                                              "Southeast"))))
d$quad <- as.factor(d$quad)


d <- mutate(d, crimetype = ifelse(OFFENSE =="HOMICIDE", "Violent",
                           ifelse(OFFENSE =="SEX ABUSE", "Violent",
                           ifelse(OFFENSE =="ROBBERY", "Violent",
                           ifelse(OFFENSE =="ASSAULT W/DANGEROUS WEAPON", "Violent",           
                            "Non-Violent" )))))
d$crimetype <- as.factor(d$crimetype)

save(d, file="crime_flat.rda")
write.csv(d, "dc_crime_add_vars.csv")

load("crime_flat.rda")
 

#crimes per year
d %>% subset(year < 2017) %>% group_by(year) %>% summarize(total = n()) %>%
  ggplot(aes(x=year, y = total)) + geom_line(size=2) + scale_x_continuous()
  
#Stacked Plot
d %>%  subset(year < 2017) %>%  group_by(year,OFFENSE) %>% summarize(total = n()) %>% 
 ggplot(aes(x = year, y = total, fill = OFFENSE)) + geom_area(position = 'stack') + 
  scale_x_continuous()

#HOMICIDE plot
d %>% filter(year < 2017, OFFENSE =="HOMICIDE") %>% group_by(year) %>% summarize(total = n()) %>%
  ggplot(aes(x=year, y = total)) + geom_line() + scale_x_continuous()

d %>% filter(year < 2017, OFFENSE =="SEX ABUSE") %>% group_by(year) %>% summarize(total = n()) %>%
  ggplot(aes(x=year, y = total)) + geom_line() + scale_x_continuous()

d %>% filter(year < 2017, OFFENSE =="THEFT/OTHER") %>% group_by(year) %>% summarize(total = n()) %>%
  ggplot(aes(x=year, y = total)) + geom_line() + scale_x_continuous()




#Split by Horizontal lines -> 

quadrant <- d %>% filter(year < 2017) %>% group_by(year,OFFENSE,quad) %>% summarize(total = n())
  
save(quad, file="quad.rda") 

load("quad.rda")
ggplot(quad,aes(x=year, y = total, colour = quad)) + geom_line(size=1.1) + facet_wrap(~OFFENSE, scales="free_y")

quad <- as.data.frame(quadrant)




#Facet Grid by Crime
d %>% filter(year < 2017) %>% group_by(year, OFFENSE) %>% summarize(total = n()) %>%
  ggplot(aes(x=year, y = total)) + geom_line(size=1.1) + facet_wrap(~OFFENSE, scales="free_y")


#Facet Grid with Quadrant
d  %>% group_by(hour, OFFENSE, quad) %>% summarize(total = n()) %>%
  ggplot(aes(x=hour, y = total, colour = quad)) + geom_line() + facet_wrap(~OFFENSE,  scales="free_y")




#Time of Day Plots


#Map Plots  
map <- get_map(location = "washington, dc", zoom = 12)
hom <- filter(d, OFFENSE=="HOMICIDE")

ggmap(map) + geom_point(data = k, aes(x = long, y = lat))



year <- hom %>% group_by(year) %>% summarize(total = n())
y <- year$year

map2 <- get_map(location = "anacostia metro, washington, dc", zoom = 13)



for(i in y) {
  print(i)
}


ggplot(hom, aes(x=XBLOCK, y = YBLOCK, colour = METHOD)) + geom_point()

for(i in y) {
  ggplot(hom[year == i,], aes(x=XBLOCK, y = YBLOCK, colour = METHOD)) + geom_point()
}

hom[year==2008,]

#ward totals..
d$WARD <- as.factor(d$WARD)
d$OFFENSE <- as.factor(d$OFFENSE)


ward <- d %>% 
  group_by(WARD, OFFENSE) %>%
  summarize(total = n()) %>% dcast(WARD ~ OFFENSE)

            