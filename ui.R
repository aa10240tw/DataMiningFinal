rm(list=ls(all=TRUE));
library(shinyapps);
library(rsconnect);
library(shiny);
shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "chart.css")
  ),
  titlePanel("Classification"),
    tabsetPanel(
      type = "tabs", 
      tabPanel("Personal predict",
               sidebarPanel(
                 radioButtons("buying",label = "Buying Price",
                              choices = c("low","med","high","vhigh"),
                              selected = "vhigh"),
                 
                 radioButtons("maint",label = "Mantainance",
                              choices = c("low","med","high","vhigh"),
                              selected = "vhigh"),
                 
                 radioButtons("doors",label = "Doors",
                              choices = c("2","3","4","5more"),
                              selected = "5more"),
                 radioButtons("persons",label = "Persons",
                              choices = c("2","4","5more"),
                              selected = "5more"),
                 
                 radioButtons("lug_boot",label = "Luggage Boot",
                              choices = c("small","med","big"),
                              selected = "big"),
                 
                 radioButtons("safety",label = "Safety",
                              choices = c("low","med","high"),
                              selected = "high")
                 ),
               mainPanel(textOutput("persontext"))
               ),
      tabPanel(("Public predict"),
               mainPanel(textOutput("publictext1"),
                         textOutput("publictext2"),
                         tableOutput("publictable")))
    )
  )
)

