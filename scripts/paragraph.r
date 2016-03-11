## use the packages to run the app
library(dplyr)
require(dplyr)

## read the dataset
data <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")

## create a data frame and variables for the most dangerous/safest regions
sector <- data %>% 
            group_by(District.Sector) %>%
                dplyr::summarise(count = n())
highest_rate_sector <- arrange(sector, desc(count))[1,1]
lowest_rate_sector <- arrange(sector, count)[1,1]

## create a data frame and variables for the most common type of crime and the number of crimes
type <- group_by(data, Event.Clearance.Group) %>% dplyr::summarise(count = n()) %>% arrange(desc(count))
highest_type <- type[1,1]
highest_type_number <- type[1,2]