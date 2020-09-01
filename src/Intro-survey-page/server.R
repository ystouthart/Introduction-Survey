#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    setwd("../..")
    surveydata <-
        read.csv("data/raw/Antwoorden ADS - Formulierreacties 1.csv", sep = "\t")
    
    output$agePlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        bins <-
            seq(
                min(surveydata['Age'], na.rm = TRUE),
                max(surveydata['Age'], na.rm = TRUE),
                length.out = input$bins + 1
            )
        
        ggplot(surveydata, aes(x=Age))+
            geom_histogram(breaks = bins, fill="steelblue") +
            labs(
                x = "Age",
                title = "Histogram of ADS Age Distribution",
                caption = "Source: Survey Data"
            )+
            theme_minimal()

    })
    
    output$genderPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        
        df <- data.frame(group = c("Male", "Female"),
                         value = c(length(surveydata[, "Gender"][surveydata[, "Gender"] == 'Male']),
                                   length(surveydata[, "Gender"][surveydata[, "Gender"] == 'Female'])))

        
        ggplot(df, aes(x="", y=value, fill=group))+
            geom_bar(width = 1, stat = "identity") +
            theme(axis.line = element_blank(),
                  plot.title = element_text(hjust = 0.5)) +
            labs(
                fill = "Country",
                x = NULL,
                y = NULL,
                title = "Pie Chart of ADS Gender Distribution",
                caption = "Source: Survey Data"
            ) +
            coord_polar(theta = "y", start = 0)
        
        
    })
    
    output$CountryPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        
        ggplot(surveydata, aes(x = "", fill = factor(Country.of.Origin))) +
            geom_bar(width = 1) +
            theme(axis.line = element_blank(),
                  plot.title = element_text(hjust = 0.5)) +
            labs(
                fill = "Country",
                x = NULL,
                y = NULL,
                title = "Pie Chart of origin Country",
                caption = "Source: Survey Data"
            ) +
            coord_polar(theta = "y", start = 0)
    })

})
