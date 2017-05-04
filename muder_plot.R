library(rworldmap)


m <- get_map("Washington, DC")
plot(m)

k <- d

k2 <- filter(k, XBLOCK > 38.8)
qmplot(XBLOCK, YBLOCK, data = k2, colour = I('red'), size = I(3), darken = .3)

x <- ggmap(get_map("the white house"))


ggplot(x) + points(aes(x=k$XBLOCK, y = k$YBLOCK))


map <- get_map(location = '', zoom = 4)


library(ggmap)
map <- get_map(location = "washington, dc", zoom = 12)

map2 <- get_map(location = "anacostia metro, washington, dc", zoom = 13)


ggmap(map) + geom_point(data = k, aes(x = long, y = lat))

k <- d

str(k)
k3 <- filter(k, METHOD=="KNIFE")
k3 <- filter(k, OFFENSE=="HOMICIDE")

ggmap(map) + geom_point(data = k3, aes(x = XBLOCK, y = YBLOCK, colour = METHOD))
  


#LOOP THROUGH DAYS... MONTHS ETC. 
#CREATE ANNIMATION

