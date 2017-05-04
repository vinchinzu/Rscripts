library(twitteR)
install.packages("ROAuth")
library(ROAuth)
require(RCurl)
library(stringr)
library(tm)
library(ggmap)
library(plyr)
library(dplyr)

library(tm)
library(wordcloud)
library(RCurl)

setwd("sent")

options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

apiKey <- "YdvSnDWyo4iFusRhpWfnww"
apiSecret <- "m1j4kfuZcFYEE947R2BMx2OOLZsaBPiWBVANxmszE"
actoken <- "225949533-J0UFIyOnbHcy6gQko5qyKCYYF0y611VR9Sue5G29"
acsecret <- "1PL6x05BiQmj4jbUsxcnO51x8k3yEdecAjL3Hj3cspKiQ"



setup_twitter_oauth(
  apiKey , 
  apiSecret,
  actoken,
  acsecret
)



twitCred <- OAuthFactory$new(
  consumerKey = apiKey, 
  consumerSecret = apiSecret,
  requestURL = reqURL,
  accessURL = accessURL, 
  authURL = authURL
)

twitCred$handshake(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")
)

registerTwitterOAuth(twitCred)


4162092

authenticate <- OAuthFactory$new(consumerKey=key,
                                 consumerSecret=secret,
                                 requestURL="https://api.twitter.com/oauth/request_token",
                                 accessURL="https://api.twitter.com/oauth/access_token",
                                 authURL="https://api.twitter.com/oauth/authorize")

setup_twitter_oauth(key, secret)

save(authenticate, file="twitter authentication.Rdata")


N=100  # tweets to request from each query
S=200  # radius in miles
lats=c(38.9,40.7,37.8,39,37.4,28,30,42.4,48,36,32.3,33.5,34.7,33.8,37.2,41.2,46.8,
       46.6,37.2,43,42.7,40.8,36.2,38.6,35.8,40.3,43.6,40.8,44.9,44.9)

lons=c(-77,-74,-122,-105.5,-122,-82.5,-98,-71,-122,-115,-86.3,-112,-92.3,-84.4,-93.3,
       -104.8,-100.8,-112, -93.3,-89,-84.5,-111.8,-86.8,-92.2,-78.6,-76.8,-116.2,-98.7,-123,-93)


donald=do.call(rbind,lapply(1:length(lats),
  function(i) searchTwitter('Donald+Trump',     
    lang="en",n=N,resultType="recent",                                                            
    geocode=paste(lats[i],lons[i],paste0(S,"mi"),sep=","))))


donaldlat=sapply(donald, function(x) as.numeric(x$getLatitude()))
donaldlat=sapply(donaldlat, function(z) ifelse(length(z)==0,NA,z))  

donaldlon=sapply(donald, function(x) as.numeric(x$getLongitude()))
donaldlon=sapply(donaldlon, function(z) ifelse(length(z)==0,NA,z))  

donalddate=lapply(donald, function(x) x$getCreated())
donalddate=sapply(donalddate,function(x) strftime(x, format="%Y-%m-%d %H:%M:%S",tz = "UTC"))

donaldtext=sapply(donald, function(x) x$getText())
donaldtext=unlist(donaldtext)

isretweet=sapply(donald, function(x) x$getIsRetweet())
retweeted=sapply(donald, function(x) x$getRetweeted())
retweetcount=sapply(donald, function(x) x$getRetweetCount())

favoritecount=sapply(donald, function(x) x$getFavoriteCount())
favorited=sapply(donald, function(x) x$getFavorited())

data=as.data.frame(cbind(tweet=donaldtext,date=donalddate,lat=donaldlat,lon=donaldlon,
                         isretweet=isretweet,retweeted=retweeted, retweetcount=retweetcount,favoritecount=favoritecount,favorited=favorited))



# Create corpus
corpus=Corpus(VectorSource(data$tweet))

# Convert to lower-case
corpus=tm_map(corpus,tolower)

# Remove stopwords
corpus=tm_map(corpus,function(x) removeWords(x,stopwords()))

# convert corpus to a Plain Text Document
corpus=tm_map(corpus,PlainTextDocument)

col=brewer.pal(6,"Dark2")
wordcloud(corpus, min.freq=25, scale=c(5,2),rot.per = 0.25,
          random.color=T, max.word=45, random.order=F,colors=col)
