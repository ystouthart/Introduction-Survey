#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    setwd("../..")
    surveydata <- read.csv("data/raw/Antwoorden ADS - Formulierreacties 1.csv", sep = "\t")
    
    output$agePlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        bins <- seq(min(surveydata['Age'], na.rm = TRUE), max(surveydata['Age'], na.rm = TRUE), length.out = input$bins + 1)
        
        hist(surveydata[,2], breaks = bins, col = 'darkgray', border = 'white')
    })
        
    output$genderPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        
        df <- data.frame(
            group = c("Male", "Female"),
            value = c(
                length(surveydata[,"Gender"][surveydata[,"Gender"] == 'Male']), 
                length(surveydata[,"Gender"][surveydata[,"Gender"] == 'Female']))
            )

        pie(df$value, labels = df$group, main="Pie Chart of Gender Distribution", col = c('blue', 'pink'))
        
        
        
    })

})
