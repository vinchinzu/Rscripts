
library(devtools)
devtools::install_github('fawda123/rStrava')


library(rStrava)

app_name <- 'test456' # chosen by user
app_client_id  <- '4301' # an integer, assigned by Strava
app_secret <- '9de03d9ce3f3ff2822a890cc5587ccf5773f61d5'
access_token <- '3de46877be3bc470095e7be9c525b59438caede6'

stoken <- httr::config(token = strava_oauth(app_name, app_client_id, app_secret, cache=TRUE))


myinfo <- get_athlete(stoken, id = '1994605')
a <- get_athlete(stoken,id = '14392288')
 
#not work
get_streams(stoken, id = '1994605', types = list('distance', 'latlng'))


#works, gets activity list, 
b <- get_activity_list(stoken, id = '1994605')

#gets a list.. but
c <- get_activity_list(stoken, id = '1994605', friends=TRUE)


#get club

d_club <- get_club(stoken, id = '159833', request = NULL)
