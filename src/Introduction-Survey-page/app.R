#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("ADS Survey Age"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    setwd("../..")
    surveydata <- read.csv("data/raw/Antwoorden ADS - Formulierreacties 1.csv", sep = "\t")
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        bins <- seq(min(surveydata['Age'], na.rm = TRUE), max(surveydata['Age'], na.rm = TRUE), length.out = input$bins + 1)
        
        hist(surveydata[,2], breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

