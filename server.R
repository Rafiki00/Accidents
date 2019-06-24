#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(dplyr)
library(shiny)
library(ggplot2)
library(readr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    output$accPlot <- renderPlot({

        # read in data
        acc <- read_csv("acc.csv", col_types = "-cii")
        

        # plot graph based on user input
        acc_d <- acc %>%
            filter(district %in% input$districts)
        ggplot(acc_d, aes(x = year, y = accidents, color = district)) +
            geom_line() +
            scale_x_continuous(breaks = unique(acc$year))

    })

})
