library(shiny)

# Chi-square distribution
shinyUI(fluidPage(
  fluidRow(
    column(8,align="center",
           sliderInput("df",
                       "degree of freedom:",
                       min = 1,
                       max = 15,
                       value = 1)),
    column(8,align="left",
           plotOutput("distPlot"))
  ))
)