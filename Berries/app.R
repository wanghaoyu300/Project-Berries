#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(readr)
library(knitr)
library(magrittr)
library(kableExtra)
library(gridExtra)




data_berries <- read_csv("ag_data.csv")
data_strawberry <- read_csv("strawberry.csv")


ui <- fluidPage(
  titlePanel("Berries"),
    sidebarLayout(
      tabsetPanel(
          conditionalPanel(
            'input.dataset === "data_berries"'),
          conditionalPanel(
            'input.dataset === "data_strawberry"',
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Original Data",
            fluidRow(
                   column(2,
                          selectInput("Year",
                                      "Year:",
                                      c("All",
                                        unique(as.character(data_berries$Year))))
                   ),
                   column(2,
                          selectInput("State",
                                      "State:",
                                      c("All",
                                        unique(as.character(data_berries$State))))
                   ),        
                   column(2,
                          selectInput("Commodity",
                                      "Commodity:",
                                      c("All",                                       
                                        unique(as.character(data_berries$Commodity))))
                   ),
                   column(2,
                          selectInput("Domain",
                                      "Domain:",
                                      c("All",
                                        unique(as.character(data_berries$Domain))))
                   )                  
            ),
                 DT::dataTableOutput("table1")),
            
        tabPanel("Strawberry",
                  fluidRow(
                    column(2,
                           selectInput("Year",
                                       "Year:",
                                       c("All",
                                         unique(as.character(data_strawberry$Year))))
                    ),
                    column(2,
                           selectInput("Production",
                                       "Production:",
                                       c("All",
                                         unique(as.character(data_strawberry$Production))))
                    ),                    
                    column(2,
                           selectInput("Measurement",
                                       "Measurement:",
                                       c("All",
                                         unique(as.character(data_strawberry$Measurement))))
                    ),
                    column(2,
                           selectInput("Chemical",
                                       "Chemical:",
                                       c("All",
                                         unique(as.character(data_strawberry$Chemical))))
                    )                 
                  ),    
                  DT::dataTableOutput("table2")))
            )
         )
      )

server <- function(input, output) {
  
  
  output$table1 <- DT::renderDataTable(DT::datatable({
    data <- data_berries
    if (input$Year != "All") {
      data <- data[data_berries$Year == input$Year,]
    }
    if (input$State != "All") {
      data <- data[data_berries$State == input$State,]
    }
    if (input$Commodity != "All") {
      data <- data[data_berries$Commodity == input$Commodity,]
    }
    if (input$Domain != "All") {
      data <- data[data_berries$Domain == input$Domain,]
    }    
    data
  }))


  output$table2 <- DT::renderDataTable(DT::datatable({
    data2 <- data_strawberry
    if (input$Year != "All") {
      data2 <- data2[data_strawberry$Year == input$Year,]
    }
    if (input$Production != "All") {
      data2 <- data2[data_strawberry$Production == input$Production,]
    }
    if (input$Measurement != "All") {
      data2 <- data2[data_strawberry$Measurement == input$Measurement,]
    }
    if (input$Chemical != "All") {
      data2 <- data2[data_strawberry$Chemical == input$Chemical,]
    }
    data2
  }))


}


shinyApp(ui = ui, server = server)