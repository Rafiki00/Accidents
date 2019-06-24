#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
acc <- read_csv("acc.csv", col_types = "-cii")


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    
    # Application title
    titlePanel("Vehicle Accidents in Valencia 2007 - 2017"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h2("Compare accidents by district"),
            p("With this interactive graph you can compare the data on vehicle accidents in Valencia for different 
              districts. The data was gathered from the Annual Statistics of Valencia (https://bit.ly/2RG7OaR). 
              Chosing the checkbox Valencia will display the sum total."),
            checkboxGroupInput("districts", "Choose districts:",
                               choices = unique(acc$district),
                               selected = NULL)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput(outputId = "accPlot")
        )
    )
))

