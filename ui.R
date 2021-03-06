
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggmap)
library(ggplot2)
library(plotly)
source("scripts/paragraph.r")
shinyUI(fluidPage(
  
  #title panel that shows the title of whole project
  titlePanel(h1("Seattle Incident 2016", align = 'center')),
  
  #side panel
  sidebarLayout(
    sidebarPanel(
      # provide the purpose and information about our project
      p("This project aims to investigate the incident response data in Seattle. Our data was collected by Seattle Police "),
      p("department after the incidents are considered safe to close out. The general goal of working with "),
      p("this dataset is to give Seattle residents or anyone who is interested in a better idea about Seattle’s safety "),
      hr(),
      p(strong("NOTE:"), "These side bars are used for density map"),
      
      #widget that allows user to select what type of crime that are interested in 
      selectInput("type", label = h4("Select the type of incident that you are interested in"), choices = list("Arrest" = "ARREST", 
      "Assault" = "ASSAULTS", "Weapon" = "WEAPONS CALLS", "Theft" = "AUTO THEFTS", "Robbery" = "ROBBERY", "Hazards" = "HAZARDS",
      "Liquor Violation" = "LIQUOR VIOLATIONS", "Homicide" = "HOMICIDE", "Disturbances" = "DISTURBANCES", "Accidents" = "ACCIDENT INVESTIGATION"), selected = "ARREST"),
      #widget that allows users to select the zoom level of density of map
      sliderInput("zoom", label = h4("Zoom Level"),
                  min = 1, max = 15, value = 11, step = 1),
      hr(),
      # workframe that provides our group information and source of data and a url that can see our codes
      p("Written by Yuyue Zhu, Siqin Gou, Yulun Nie, Yuhao Shui"),
      p("Source on ", a(href="https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp", "Seattle Government Data")),
      p("View code on ", a(href="https://github.com/gloriagou947/final_project", "GitHub")),
      width = 3
    ),
    
    # main panel
    mainPanel(
      tabsetPanel(
        tabPanel("Bar Chart", wellPanel(p("This is a bar chart that shows the total number of inncidents per hour.")), plotlyOutput("bar_chart")),
        tabPanel("Density Map", wellPanel(p("This is a density map that shows a type of incident that users are interested in within different depth of color")),plotOutput("density_map")),
        tabPanel("Summary", wellPanel(p("As a Seattle resident, what we care the most is safety. This web app best helps you to get an idea about where the safest region is, where the most dangerous region is,
                                        what the most common type of crime is, and when the most dangerous time(with most incidents) is.
                                        Accroding the data, ", highest_rate_sector, " sector has the lowest crime rate and", lowest_rate_sector, "sector has the highest crime rate. 
                                        The most common type of crime is", highest_type, " with", highest_type_number, " crimes."))),
        tabPanel("Table", wellPanel(p("This is a table showing the total number of incidents happened every hour for different day ")), dataTableOutput('table'))
        ),
      width=9
    )
  )
))