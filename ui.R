
library(shiny)
library(dplyr)
library(leaflet)

travel <- data.frame("stop" = c(1,2,3),
                     "lat" = c(50.30717, 50.30413, 50.29846),
                     "lng" = c(18.78618, 18.7299, 18.67763))

shinyUI(fluidPage(
  titlePanel(paste("Today is",format(Sys.Date(),"%d %b %Y."),
                   "Did you know? Silesia, where my home town is,
                   has one of the largest tram networks in world.
                   Move the slider/ click on the 'play' button to get on the journey 
                   I used to take to my English class, some 30 years ago:)")
             ),
  sidebarPanel(
    sliderInput(inputId = "tramStop", label = "Tram Stop", 
                min = 1, max = 3, value = 1, step=1, animate=T),
    ),
  mainPanel(
    leafletOutput("mymap"),
    width=15
  )
))