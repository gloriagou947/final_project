library(dplyr)
library(plotly)

data_crime <- read.csv('../data/Seattle_Police_Department_911_Incident_Response.csv')
data_crime$day <- substr(data_crime$Event.Clearance.Date, 4, 5)
data_crime$day <- as.integer(data_crime$day)
data_crime$hour <- substr(data_crime$Event.Clearance.Date, 12, 13)
data_crime$hour <- as.integer(data_crime$hour)
data_crime$am_pm <- substr(data_crime$Event.Clearance.Date, 21, 22)

day1 <- filter(data_crime, day == 1)
day2 <- filter(data_crime, day == 2)
day3 <- filter(data_crime, day == 3)

hours <- c(paste(c(1:12), "AM"), paste(c(1:12), "PM"))

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

p1 <- plot_ly(
  x = hours,
  y = each_day(day1),
  name = "Day 1",
  type = "bar"
)
p2 <- add_trace(
  p1,
  x = hours,
  y = each_day(day2),
  name = "Day 2"
)
p3 <- add_trace(
  p2,
  x = hours,
  y = each_day(day3),
  name = "Day 3"
)
layout(p3, barmode = "stack", xaxis = list(title = "Each hour crime counts"),
yaxis = list(title = "Total crime"))
