library(ggmap)
library(dplyr)
library(ggplot2)

seattleCrimes <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")
map.seattle_city <- qmap("seattle", zoom = 11, source="stamen", maptype="toner",darken = c(.3,"#BBBBBB"))
#map.seattle_city
map.seattle_city +
  stat_density2d(data=seattleCrimes, aes(x=Longitude
                                            , y=Latitude
                                            ,color=..density..
                                            ,size=ifelse(..density..<=1,0,..density..)
                                            ,alpha=..density..)
                 ,geom="tile",contour=F) +
  scale_color_continuous(low="orange", high="red", guide = "none") +
  scale_size_continuous(range = c(0, 3), guide = "none") +
  scale_alpha(range = c(0,.5), guide="none") +
  ggtitle("Seattle Crime") +
  theme(plot.title = element_text(family="Trebuchet MS", size=36, face="bold", hjust=0, color="#777777"))