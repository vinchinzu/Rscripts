setwd("C:/R")
getwd()
library(ggplot2)
library(plyr)
library(lubridate)
library(tidyr)
library(RColorBrewer)

d <- read.csv("C:/docs/Book1.csv", stringsAsFactors = F)


x <- d[,c( "Process.Area..Read.Only.","Short.Title","Date.of.V.V","Forecasted.Date.Complete", "Status", "Baseline", "Process.Owner")]
colnames(x) <- c("Process.Area", "Short.Title", "Date.of.V.V", "Forecasted.Date.Complete", "Status", "Baseline","Process.Owner")
x$Date.of.V.V <- as.Date(x$Date.of.V.V, "%m/%d/%Y")
x$Forecasted.Date.Complete <- as.Date(x$Forecasted.Date.Complete, "%m/%d/%Y")
x$Baseline <- as.Date(x$Baseline, "%m/%d/%Y")


x <- x[x$Baseline <= "2016-9-30",]

x <- arrange(x, Short.Title)
x <- transform(x, Short.Title = reorder(Short.Title, desc(Date.of.V.V)))

x2 <- subset(x, Process.Area =="Property Management")
x3 <- subset(x, Process.Area =="Financial Reporting")
x4 <- subset(x, !(Process.Area %in% c("Financial Reporting", "Property Management" )))
x5 <- subset(x4, (Process.Area %in% c("Payment Management", "Human Resources and Payroll Management" )))
x6 <- subset(x4, !(Process.Area %in% c("Payment Management", "Human Resources and Payroll Management" )))



cols <- c("25%" = "firebrick","Closed" = "#00b050","25% - R" = "#f79646", 
          "75%" = "#0070c0",
          "50%" = "#00b0f0")

timeline_plot = function(df) {
  ggplot(data=df) + 
    geom_segment(aes(x=Date.of.V.V, xend=Forecasted.Date.Complete,
                     y=Short.Title, 
                     yend=Short.Title, 
                     Group=Short.Title, 
                     colour = Status), 
                 size=12) +
    geom_vline(aes(xintercept = as.numeric(today())),  linetype=4, colour="blue") +
    geom_segment(aes(x=Baseline, xend =(Baseline + 1) , y=Short.Title , yend=Short.Title, Group=Short.Title), color="red", size=10, linetype=2)+
    geom_segment(aes(x= Baseline, xend = Date.of.V.V, y =Short.Title, yend = Short.Title, Group = Short.Title),
                 size = .7, linetype = 2, colour = "red") +
    scale_colour_manual(values = cols)
}

timeline_plot(x2)
timeline_plot(x3)

timeline_plot(x4)

x5 <- subset(x4, Status != "Closed")
timeline_plot(x5)

unique(x$Process.Area)


x %>%
  group_by(Process.Area) %>% summarise(tot = n()) %>% arrange(desc(tot))




timeline_plot(s5)


#Facet warpping for

ggplot(df.long,aes(variable,value,fill=as.factor(Annee)))+
geom_bar(position="dodge",stat="identity")+
  facet_wrap(~Type,nrow=3)



timeline_plot2 = function(df) {
  ggplot(data=df) + 
    geom_segment(aes(x=Date.of.V.V, xend=Forecasted.Date.Complete,
                     y=Short.Title, 
                     yend=Short.Title, 
                     Group=Short.Title, 
                     colour = Status), 
                 size=12) +
    geom_vline(aes(xintercept = as.numeric(today())),  linetype=4, colour="blue") +
    geom_segment(aes(x=Baseline, xend =(Baseline + 1) , y=Short.Title , yend=Short.Title, Group=Short.Title), color="red", size=10, linetype=2)+
    geom_segment(aes(x= Baseline, xend = Date.of.V.V, y =Short.Title, yend = Short.Title, Group = Short.Title),
                 size = .7, linetype = 2, colour = "red") +
    scale_colour_manual(values = cols) + 
    facet_wrap(Process.Owner~)
}

timeline_plot2(x2)
