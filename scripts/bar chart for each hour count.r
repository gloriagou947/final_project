library(dplyr)
library(plotly)

#read dataframe
data_crime <- read.csv('../data/Seattle_Police_Department_911_Incident_Response.csv')

#create a column that record the day of the crime based on event clearance date
data_crime$day <- substr(data_crime$Event.Clearance.Date, 4, 5)
data_crime$day <- as.integer(data_crime$day)
#create a column that record the hour of the crime based on event clearance date
data_crime$hour <- substr(data_crime$Event.Clearance.Date, 12, 13)
data_crime$hour <- as.integer(data_crime$hour)
#create a column that record the AM or PM of the crime based on event clearance date
data_crime$am_pm <- substr(data_crime$Event.Clearance.Date, 21, 22)

#create 3 dataframe that filtered by 3 different days
day1 <- filter(data_crime, day == 1)
day2 <- filter(data_crime, day == 2)
day3 <- filter(data_crime, day == 3)

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
p1 <- plot_ly(
  x = hours,
  y = each_day(day1),
  name = "Day 1",
  type = "bar"
)

#add graph for day 2 to day 1
p2 <- add_trace(
  p1,
  x = hours,
  y = each_day(day2),
  name = "Day 2"
)

#add graph for day 3 to day 1 and day 2
p3 <- add_trace(
  p2,
  x = hours,
  y = each_day(day3),
  name = "Day 3"
)

#plot the final bar chart
layout(p3, barmode = "stack", xaxis = list(title = "Each hour crime counts"),
yaxis = list(title = "Total crime"))
