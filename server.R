library(shiny)
library(dplyr)
library(leaflet)

shinyServer(function(input, output, session) {
  
  TramStopLatLng <- data.frame(
    "lat" = c(50.30717, 50.30413, 50.29846),
    "lng" = c(18.78618, 18.7299, 18.67763))
  
  StopIcon1 <- makeIcon(
    iconUrl = "http://www.schneider-pirna.de/tokkyuu/4_477%20Zabrze%20PlacWolnosci.JPG",
    iconWidth = 200, iconHeight = 150,
    iconAnchorX = 1, iconAnchorY = 150
  )
  
  StopIcon2 <- makeIcon(
    iconUrl = "http://photos.wikimapia.org/p/00/00/72/71/03_big.jpg",
    iconWidth = 200, iconHeight = 200,
    iconAnchorX = 1, iconAnchorY = 1
  )
  
  StopIcon3 <- makeIcon(
    iconUrl = "https://upload.wikimedia.org/wikipedia/commons/1/10/Gleiwitzer_Nr._4.jpg",
    iconWidth = 150, iconHeight = 200,
    iconAnchorX = 150, iconAnchorY = 1
  )
  
  StopIcons <- iconList(StopIcon1,StopIcon2,StopIcon3)
  
  StopSites <- c(
    "<a href='https://en.wikipedia.org/wiki/Zabrze'>Start In Zabrze</a>",
    "<a href='https://en.wikipedia.org/wiki/Silesian_Interurbans'>Some history as we travel</a>",
    "<a href='https://en.wikipedia.org/wiki/Gliwice'>End In Gliwice</a>"
  )
  
  travelIcon <- makeIcon(
    iconUrl = "https://cdn1.iconfinder.com/data/icons/mixed-vol-5/512/Items-02-512.png",
    iconWidth = 50, iconHeight = 50,
    iconAnchorX = 25, iconAnchorY = 25
  )
  
  points <- reactive({
    travel %>% 
      filter(stop == input$tramStop)
  })
  
  history <- reactive({
    travel %>%
      filter(stop <= input$tramStop)
  })
  
  ##trajectory <- reactive({
    ##if(input$tramGoButton <=2)
      ##spot <- travel[,input$tramGoButton+1]
      ##else input$tramGoButton =0
      ##})
  
  output$mymap <- renderLeaflet({
  TramStopLatLng %>% 
    leaflet() %>%
    addTiles() %>%
    addMarkers(icon = StopIcons, popup = StopSites) %>%
      
   ## addMarkers(icon=travelIcon, lat=50.30717, lng=18.78618) %>%
   ## addPolylines(lng = ~lng, lat = ~lat, data = travel, color="red") 
      
      addMarkers(lng = ~lng,
                 lat = ~lat,
                 data = points()) %>%
      addMarkers(icon=travelIcon,
                 lng = ~lng,
                 lat = ~lat,
                 data = history()) %>%
      addPolylines(lng = ~lng,
                   lat = ~lat,
                   data = history(),color="red")
  })
  
})