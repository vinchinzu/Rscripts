library(animation)
library("ggplot2")
library("scales")
library('ggthemes')
library("plyr")
library("dplyr")
library("data.table")
library("animation")
library("tweenr")
library(devtools)
library("gganimate")
library(shinydashboard)




## make sure ImageMagick has been installed in your system
saveGIF({
  for (i in 1:10) plot(runif(10), ylim = 0:1)
})



year <- hom %>% group_by(year) %>% summarize(total = n())
y <- year$year




ggplot(hom, aes(x=XBLOCK, y = YBLOCK, colour = METHOD)) + geom_point()

for(i in y){
  print(i)
}


saveHTML({
for(i in 1:10) {
  ggplot(hom[year == y[i],], aes(x=XBLOCK, y = YBLOCK, colour = METHOD)) + geom_point()
}
})

for (i in 1:10){
x <- ggplot(hom[year == y[i],], aes(x=XBLOCK, y = YBLOCK, colour = METHOD)) + geom_point()
plot(x)
}

savePlot(filename="test", device = dev.cur(),
         restoreConsole = TRUE)
#cannot save out from windows device




  
saveHTML({for (i in 1:10) ggplot(hom[year == y[i],], aes(x=XBLOCK, y = YBLOCK, colour = METHOD)) + geom_point()},htmlfile = "test1.html")
saveHTML({for (i in 1:5) qplot(runif(10))},htmlfile = "test2.html")


system("C:/Program Files/ImageMagick-6.9.8-Q16/convert -delay 80 *.jpg example_1.gif")
  

ani.options(convert = shQuote('C:/Program Files/ImageMagick-6.9.8-Q16/convert.exe'))
ani.options("convert") [1] "\"C:/Program Files/ImageMagick-6.9.8-Q16/convert.exe\""

ani.options(convert = 'C:/Program Files/ImageMagick-6.9.8-Q16/convert.exe')
ani.options("convert") [1] "C:/Program Files/ImageMagick-6.9.8-Q16/convert.exe"
