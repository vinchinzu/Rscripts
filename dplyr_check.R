library(dplyr)
library(datasets)
data(state)

s <- state

crime.by.state <- read.csv("CrimeStatebyState.csv")

crime.ny.2005 <- crime.by.state[crime.by.state$Year==2005 & 
                                  crime.by.state =="New York",]


crime.ny.2005 <- filter(crime.by.state, State=="New York", Year == 2005)

crime.ny.2005 <- arrange(crime.ny.2005, desc(Count))

crime.ny.2005[,c("Type.of.Crime", "Count")]
crime.new.2005 <- select(crime.ny.2005, Type.of.Crime, Count)


#create new column

crime.ny.2005 <- mutate(crime.ny.2005, Proportion=Count/sum(Count))


summary1 <- aggregate(Count ~ Type.of.Crime, data = crime.new.2005, FUN=length)


summary2 <- aggregate(Count ~ Type.of.Crime, data = crime.ny.2005, FUN=sum)


summary_crime <- merge(summary1, summary2, by ="Type.of.Crime")

#dplyr

by.type <- group_by(crime.ny.2005, Type.of.Crime)
summary.crime.ny.2005 <- summarise(by.type, num.types = n(),
                                   counts = sum(Count))


final <- crime.by.state %>% 
  filter(State=="New York", Year==2005) %>%
  arrange(desc(Count)) %>%
  select(Type.of.Crime,Count) %>%
  mutate(Proportion=Count/sum(Count)) %>%
  group_by(Type.of.Crime) %>%
  summarise(num.types=n(), counts = sum(Count))

final <- crime.by.state %>%
  filter(State=="New York", Year==2005) %>%
  arrange(desc(Count)) %>%
  select(Type.of.Crime, Count) %>%
  mutate(Proportion=Count/sum(Count)) %>%
  group_by(Type.of.Crime) %>%
  summarise(num.types = n(), counts = sum(Count))