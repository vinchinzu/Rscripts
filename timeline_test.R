install.packages("FField", type = "source")
install.packages("ggplot2")
install.packages("gridExtra")
library(FField)
FFieldPtRepDemo()

library(ggrepel)

library(timeline)

data(ww2)
timeline(ww2, ww2.events)
timeline(ww2, ww2.events, event.spots=2, event.label='', event.above=FALSE)




library(ggplot2)
library(ggrepel)
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(color = 'red') +
  geom_text_repel(aes(label = rownames(mtcars))) +
  theme_classic(base_size = 16)


df <- data.frame(gp = factor(rep(letters[1:3], each = 10)),
                 y = rnorm(30))
# Compute sample mean and standard deviation in each group
ds <- plyr::ddply(df, "gp", plyr::summarise, mean = mean(y), sd = sd(y))

# Declare the data frame and common aesthetics.
# The summary data frame ds is used to plot
# larger red points in a second geom_point() layer.
# If the data = argument is not specified, it uses the
# declared data frame from ggplot(); ditto for the aesthetics.
ggplot(df, aes(x = gp, y = y)) +
  geom_point() +
  geom_point(data = ds, aes(y = mean),
             colour = 'red', size = 3)


