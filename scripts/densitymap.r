install.packages('ggmap')
install.packages('ggplot2')
install.packages('dplyr')
install.packages('plyr')
library(ggmap)
library(dplyr)
library(ggplot2)

seattleCrimes <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")
newData <- seattleCrimes %>%
             filter(Event.Clearance.Group == "ASSAULTS")
map.seattle_city <- get_map(location = "seattle", 
                            zoom = 11,
                            maptype = 'roadmap',
                            source = 'google',
                            color = 'color',
                            filename = "ggmapTemp")
#map.seattle_city
ggmap(map.seattle_city) +
  stat_density2d(data=newData, aes(x=Longitude
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

ggplot() + geom_map(data = districtpassavg63, aes(map_id = District, fill = PassMean63), 
                    map = np_dist) + expand_limits(x = np_dist$long, y = np_dist$lat) + scale_fill_gradient2(low = muted("red"), 
                   mid = "white", midpoint = 50, high = muted("blue"), limits = c(0, 100))

maine <- readOGR("data/spd-beats.geojson", "OGRGeoJSON")

map1 <- ggplot2::fortify(maine, region="name")