install.packages("babynames")
library(babynames) # data package
library(dplyr)     # provides data manipulating functions.
library(magrittr)  # ceci n'est pas un pipe
library(ggplot2)   # for graphics

babynames %>%
  filter(name %>% substr(1, 3) %>% equals("Luc")) %>%
  group_by(year, sex) %>%
  summarize(total = sum(n)) %>%
  qplot(year, total, color = sex, data = ., geom = "line") %>%
  add(ggtitle('Names starting with "Luc"')) %>%
  print




car_data <- 
  mtcars %>%
  subset(hp > 100) %>%
  aggregate(. ~ cyl, data = ., FUN = . %>% mean %>% round(2)) %>%
  transform(kpl = mpg %>% multiply_by(0.4251)) %>%
  print

str(car_data)
