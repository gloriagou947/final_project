
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggmap)
library(ggplot2)
shinyUI(fluidPage(
  titlePanel(h1("Seattle Crimes 2016", align = 'center')),
  
  sidebarLayout(
    sidebarPanel(
      p("This project aims to investigate the crime data in Seattle. Our data was collected by Seattle Police "),
      p("department after the incidents are considered safe to close out. The general goal of working with "),
      p("this dataset is to give Seattle residents or anyone who is interested in a better idea about Seattle’s safety "),
      hr(),
      p(strong("NOTE:"), "These side bars are used for density map"),
      selectInput("type", label = h4("Select the type of crime that you are interested in"), choices = list("Arrest" = "ARREST", 
      "Assault" = "ASSAULTS", "Weapon" = "WEAPONS CALLS", "Theft" = "AUTO THEFTS", "Robbery" = "ROBBERY", "Hazards" = "HAZARDS",
      "Liquor Violation" = "LIQUOR VIOLATIONS", "Homicide" = "HOMICIDE", "Disturbances" = "DISTURBANCES", "Accidents" = "ACCIDENT INVESTIGATION"), selected = "ARREST"),
      sliderInput("zoom", label = h4("Zoom Level"),
                  min = 1, max = 15, value = 11, step = 1),
      hr(),
      p("Written by Yuyue Zhu, Siqin Gou, Yulun Nie, Yuhao Shui"),
      p("Source on ", a(href="https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp", "Seattle Government Data")),
      p("View code on ", a(href="https://github.com/gloriagou947/final_project", "GitHub")),
      width = 3
    ),
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Bar Chart", wellPanel(p("This is a bar chart that shows the total number of crimes per hour.")), plotlyOutput("bar_chart")),
        tabPanel("Density Map", wellPanel(p("This is a density map that shows a type of crime that users are interested in within different depth of color")),plotOutput("density_map")),
        tabPanel("Summary", wellPanel(p("As a Seattle resident, what we care the most is safety. This web app best helps you to get an idea about where the safest region is, where the most dangerous region is,
                                        what the most common type of crime is, and when the most dangerous time is.
                                        Accroding the data",code ("highest_rate_sector"), " sector has the lowest crime rate, and"), code("lowest_rate_sector"), "sector has the highest crime rate. 
                                        The most common type of crime is", code ("highest_type"), " with",  code ("highest_type_number"), " crimes.")),
        tabPanel("Table", wellPanel(p("This is a table showing ")), dataTableOutput('table'))
        ),
      width=9
    )
  )
))