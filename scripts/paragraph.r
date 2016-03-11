library(dplyr)
data <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv")

sector <- data %>% 
            group_by(District.Sector) %>%
                summarise(count = n())
highest_rate_sector <- arrange(sector, desc(count))[1,1]
lowest_rate_sector <- arrange(sector, count)[1,1]

type <- group_by(data, Event.Clearance.Group) %>% summarise(count = n()) %>% arrange(desc(count))
highest_type <- type[1,1]
highest_type_number <- type[1,2]