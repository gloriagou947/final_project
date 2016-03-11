# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(RColorBrewer)
library(ggplot2)
library(ggmap)
library(plotly)
shinyServer(function(input, output) {
  
  # Read in data file
  seattleCrimes <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")
  
  # Bar Chart Tab --------------------------------------------------------------
  
  output$bar_chart <- renderPlotly({
    #create a column that record the day of the crime based on event clearance date
    seattleCrimes$day <- substr(seattleCrimes$Event.Clearance.Date, 4, 5)
    seattleCrimes$day <- as.integer(seattleCrimes$day)
    #create a column that record the hour of the crime based on event clearance date
    seattleCrimes$hour <- substr(seattleCrimes$Event.Clearance.Date, 12, 13)
    seattleCrimes$hour <- as.integer(seattleCrimes$hour)
    #create a column that record the AM or PM of the crime based on event clearance date
    seattleCrimes$am_pm <- substr(seattleCrimes$Event.Clearance.Date, 21, 22)
    
    #create 3 dataframe that filtered by 3 different days
    day1 <- filter(seattleCrimes, day == 1)
    day2 <- filter(seattleCrimes, day == 2)
    day3 <- filter(seattleCrimes, day == 3)
    
    #create a vector that represents 24 hours in a day
    hours <- c(paste(c(1:12), "AM"), paste(c(1:12), "PM"))
    
    #a function that passed a dataframe of one day and returns a vector of
    #the total crime counts for each hour for that day
    each_day <- function(df) {
      countX <- c()
      for (i in 1:12) {
        num_am <- nrow(filter(df, hour == i, am_pm == "AM"))
        num_pm <- nrow(filter(df, hour == i, am_pm == "PM"))
        countX[i] <- num_am
        countX[i + 12] <- num_am
      }
      return(countX)
    }
    
    #graph for day 1
    p <- plot_ly(
      x = hours,
      y = each_day(day1),
      name = "Day 1",
      type = "bar"
    ) %>%
    #add graph for day 2 to day 1
    add_trace(
      x = hours,
      y = each_day(day2),
      name = "Day 2"
    ) %>%
    #add graph for day 3 to day 1 and day 2  
    add_trace(
      x = hours,
      y = each_day(day3),
      name = "Day 3"
    ) 
    #plot the final bar chart
    layout(p, barmode = "stack", xaxis = list(title = "Each hour crime counts"),
           yaxis = list(title = "Total crime"))
  })
  
  # Density Map Tab -------------------------------------------------------------
  
  output$density_map <- renderPlot({
    # filter out a new data that is based on user's interest of crime type
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
      stat_density2d(data=new_data, aes(x=Longitude
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
    
    # turn off the progress bar

  })
  
  # Summary Tab--------------------------------------------------------------
    # Code in this code is from r file "paragraph.r"
  
  # Table Tab -------------------------------------------------------------
  type <- group_by(seattleCrimes, Event.Clearance.Group) %>% 
            dplyr::summarise(count = n()) %>% 
              arrange(desc(count))
  output$table <- renderDataTable(
    type, options = list(orderClasses = TRUE)
  )
})