# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggvis)
library(rgdal)
library(magrittr)
library(dplyr)
library(RColorBrewer)
library(data.table)
library(maptools)
library(ggplot2)
library(ggmap)
library(plyr)
shinyServer(function(input, output, session) {
  
  # Show progress bar while loading everything ------------------------------
  
  progress <- shiny::Progress$new()
  progress$set(message="Loading maps/data", value=0)
  
  # Read in data file
  seattleCrimes <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")
  
  # First plot --------------------------------------------------------------
  
  
  
  
  output$choropleth_map <- renderPlot({
  maine <- readOGR("data/spd-beats.geojson", "OGRGeoJSON")
  
  map1 <- fortify(maine, region="name")
  
  ggplot() + geom_map(data = seattleCrimes, aes(map_id = seattleCrimes$Zone.Beat, fill = numeric ), 
                     map = map1) + expand_limits(x = map1$long, y = map1$lat) + scale_fill_gradient2(low = muted("red"), 
   mid = "white", midpoint = 50, high = muted("blue"), limits = c(0, 100))
  })
  # Second plot -------------------------------------------------------------
  # filter out a new data that is based on user's interest of crime type
  output$density_map <- renderPlot({
    new_data <- seattleCrimes %>% 
      filter(Event.Clearance.Group == input$type)
  # get Seattle map from Google using ggplot2   
  map.seattle_city <- get_map(location = "seattle", 
                                zoom = input$zoom,
                                maptype = 'roadmap',
                                source = 'google',
                                color = 'color',
                                filename = "ggmapTemp")
  # render the map and shows the density of selected type of crime 
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
  })
  # Third plot --------------------------------------------------------------
  sector <- seattleCrimes %>% 
    group_by(District.Sector) %>% 
    summarise(count = n())
  output$table <- renderDataTable({sector})
  
  
  
  # Fourth plot -------------------------------------------------------------
  
  # Turn off progress bar ---------------------------------------------------
  
  progress$close()
  
})