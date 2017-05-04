
c <- read.csv("C:/docs/lease.csv", stringsAsFactors=F)

d <- read.csv("C:/docs/values.csv", stringsAsFactors=F)

str(c)

install.packages("choroplethr")
install.packages("choroplethrMaps")


library(choroplethr)
library(choroplethrMaps)

library(datasets)

#summarize by date and 
library(dplyr)


d$s <- state.abb[grep(d$state, state.name)]

c %>% group_by(STATE) %>% summarize(sum = sum(ANNUAL.RENT))

state.abb[match(d$state,state.name)]



?df_pop_state
data(df_pop_state)

state_choropleth(d)


m <- d


#match state name with 
m$region <- state.abb[match(d$state, state.name)]


install.packages("openintro")

library(openintro)
m$region <- abbr2state(m$state)

f <- select(m, region, value)
f <- subset(region, na.rm=T)

n1 <- f[!is.na(f$region),]
n1$region <- tolower(n1$region)

state_choropleth(n1, title = "Lease Value by State", num_colors=4) 



library(ggplot2)
library(lubridate)
set <- c[!is.na(c$LEASE.EXPIRATION.DATE),]

set$LEASE.EXPIRATION.DATE <- as.Date(set$LEASE.EXPIRATION.DATE, "%m/%d/%Y")
set <- subset(set, Price_SF <= 30 )
set2 <- subset(set, year(LEASE.EXPIRATION.DATE) <=2019)

p1 <- ggplot(set2, aes(x=as.Date(LEASE.EXPIRATION.DATE), y=Price_SF ) ) + geom_point()
p1 + geom_smooth() + ggtitle("Price per square foot of lease over time")

