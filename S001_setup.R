library(installr)


install.packages("nycflights13")

library(Lahman)
library(revealjs)

library(reshape2)
library(dplyr)
library(xtable)
library(rmarkdown)
library(revealjs)

devtools::install_github("dgrtwo/gganimate")

install.packages( 
  lib  = lib <- .libPaths()[1],
  pkgs = as.data.frame(installed.packages(lib), stringsAsFactors=FALSE)$Package,
  type = 'source'
)

if(!require(installr)) {
  install.packages("installr"); require(installr)} #load / install+load installr

# using the package:
updateR()


# simple invocation
render("dc_slid?re.Rmd", revealjs_presentation())

# specify an option for incremental rendering
render("pres.Rmd", revealjs_presentation(incremental = TRUE))

## End(Not run)

revealjs_presentation()


install.packages("xtable")
t <- d %>% group_by(year, OFFENSE) %>% summarize(Total = n()) %>% dcast(OFFENSE ~ year)

xtabs(t)
xtable(t)
