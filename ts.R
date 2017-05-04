library(tm)
library(forecast)
library(dplyr)
library(tidyr)
library(readxl)
library(ggplot2)
library(lubridate)
library(plyr)
install.packages("PerformanceAnalytics")


d <- read_excel("C:/Users/lvinze/Desktop/Lucas/ts/ts_liabilities.xlsx")


library(PerformanceAnalytics)
set2 <- filter(b, year(b$TRANS_EFF_DT) < 2017, year(b$TRANS_EF_DT) > 2009)

summary2 <- aggregate(TOTAL_OBLIGATION ~ TRANS_EFF_DT, data = set2, FUN=sum)

# by month
summary3 <- aggregate(TOTAL_OBLIGATION ~ fd, data = b, FUN = sum)

monthplot(summary3)

#plot
library(ggplot2)
ggplot(summary2, aes(x=TRANS_EFF_DT, y =TOTAL_OBLIGATION)) + geom_line()

#Add zoo plot for rollmean()
library(zoo)
temp.zoo<-zoo(summary2$TOTAL_OBLIGATION, summary2$TRANS_EFF_DT)



#Calculate moving average with window 3 and make first and last value as NA (to ensure identical length of vectors)
m.av<-rollmean(temp.zoo, 7,fill = list(NA, NULL, NA))
summary2$amb.av=coredata(m.av)

#filtered
summary2 <- filter(summary2, year(TRANS_EFF_DT) > 2011 & year(TRANS_EFF_DT) < 2016 )
ggplot(summary2, aes(x=TRANS_EFF_DT, y =TOTAL_OBLIGATION)) + 
  geom_line() + geom_line(aes(TRANS_EFF_DT,amb.av),color="red") 




set2$DATE <- as.POSIXct(as.character(b$TRANS_EFF_DT),format="%Y-%m-%d")


set2 <- filter(set2, year(DATE) < 2017, year(DATE) > 2009)
#set to xts


x <- xts(summary3$fd, summary3$TOTAL_OBLIGATION, order.by=as.POSIXct(summary3$fd))

monthplot(x)

set <- select(d, TRANS_EFF_DT,TOTAL_OBLIGATION)
set2 <- filter(set, year(TRANS_EFF_DT) < 2017)

set2 %>% group_by(TRANS_EFF_DT) -> a

summarise(group_by(set2, TRANS_EFF_DT), total = sum(TOTAL_OBLIGATION))

c <- ddply(b, .(fd), summarise, sum=sum(TOTAL_OBLIGATION))


x <- subset(c, sum > 50000)
 x <- mutate(x, year = year(fd), month = month(fd))

 c <- ddply(b, .(fd), summarise, sum=sum(TOTAL_OBLIGATION))
 
 m2 <- ddply(b, .(month),summarise, avg = mean(TOTAL_OBLIGATION))
 
 
 ggplot(m) + geom_bar()
 plot(m2)
 
 ggplot(x, aes(x=fd,y=sum)) + geom_line()


monthplot(c, labels = "month") 
 

ggplot(x, aes(x=fd,y=sum, color=year)) + geom_line(stat="identity")

m <- spread(x, year, sum)
ggplot(m, aes(x=fd,y=sum, color=year)) + geom_line(stat="identity")

plot(set2)

ggplot(x, aes(x=fd,y=sum, color=year)) + geom_line(stat="identity")




b <- mutate(a, run_tot =  cumsum(a$TOTAL_OBLIGATION), 
            month = month(TRANS_EFF_DT),
            wday = wday(TRANS_EFF_DT),
            year = year(TRANS_EFF_DT),
            fd = floor_date(TRANS_EFF_DT, "month"),
            year_month = paste(year, "-",month)
)

b$year_month <- as.factor(b$year_month)
summarise(b, group_by(year_month), X= sum(TOTAL_OBLIGATION))

b %>% group_by(fd, TOTAL_OBLIGATION) %>%   summarise(tot = sum(TOTAL_OBLIGATION))

c
plot(b)

data <- structure(c(12, 20.5, 21, 15.5, 15.3, 23.5, 24.5, 21.3, 23.5,
                    28, 24, 15.5, 17.3, 25.3, 25, 36.5, 36.5, 29.6, 30.5, 28, 26,
                    21.5, 19.7, 19, 16, 20.7, 26.5, 30.6, 32.3, 29.5, 28.3, 31.3,
                    32.2, 26.4, 23.4, 16.4, 15, 16, 18, 27, 21, 49, 21, 22, 28, 36,
                    40, 3, 21, 29, 62, 65, 46, 44, 33, 62, 22, 12, 24, 3, 5, 14,
                    36, 40, 49, 7, 52, 65, 17, 5, 17, 1),
                  .Dim = c(36L, 2L), .Dimnames = list(NULL, c("Advertising", "Sales")),
                  .Tsp = c(2006, 2008.91666666667, 12), class = c("mts", "ts", "matrix"))
head(data); nrow(data)
plot(data)


moving_average = forecast(ma(tdat[1:31], order=2), h=5)
moving_average_accuracy = accuracy(moving_average, tdat[32:36])
moving_average; moving_average_accuracy
plot(moving_average, ylim=c(0,60))
lines(tdat[1:36])

  train = tdat[1:31]
test = tdat[32:36]
arma_fit <- auto.arima(train)
arma_forecast <- forecast(arma_fit, h = 5)
arma_fit_accuracy <- accuracy(arma_forecast, test)
arma_fit; arma_forecast; arma_fit_accuracy
plot(arma_forecast, ylim=c(0,60))
lines(tdat[1:36])




fit <- auto.arima(WWWusage)
plot(forecast(fit,h=20))
