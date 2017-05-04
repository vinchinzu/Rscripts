
#install.packages("RSQLite")
#install.packages("choroplethrMaps")

library("RSQLite")

#install.packages(c("readr", "dplyr", "ggvis"))
library(ggplot2)
library(readr)
library(dplyr) 
library(ggvis)

library(DBI)

setwd("kaggle/output")
con = dbConnect(RSQLite::SQLite(), dbname="database.sqlite")

p1 = dbGetQuery( con,'select * from NationalNames' )

s1 = dbGetQuery(con, 'select * from StateNames WHERE Name =="Coleman"')


p2 <- subset(p1, Name =="Kris")

ggplot(p2, aes(x=Year, y=Count, colour=Gender)) +geom_line()

s2 <- subset(s1, Year > 1980)
ggplot(s2, aes(x=Year, y=Count, colour = State)) + geom_line()


library(dplyr)
a <- s2 %>% group_by(State, Name) %>% summarize(value = sum(Count))


a$region <- state.name[match(a$State, state.abb)]

b$region <- tolower(b$region)
a <- data.frame(a)


 b <- select(b, region, value)
 
 library(choroplethr)
 library(choroplethrMaps)
 
 state_choropleth(b) 
 
 
 
 
 
 
 
