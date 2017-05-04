



time <- d  %>% group_by(hour, OFFENSE) %>% summarize(total = n())

ggplot(time, aes(x=hour, y = total,  fill = OFFENSE)) + geom_bar(stat="identity")


theft <- d %>% filter(OFFENSE == "THEFT F/AUTO" | OFFENSE == "THEFT/OTHER") %>%
  group_by(hour, OFFENSE) %>% summarize(total = n())


theft_day <- filter(theft ,hour > 8)
ggplot(theft_day, aes(x=hour, y = total, fill = OFFENSE)) + geom_bar(stat="identity")

ggplot(theft_day, aes(x=hour, y = total, colour = OFFENSE)) + geom_line()


 