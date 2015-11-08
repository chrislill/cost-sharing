library(shiny)
library(rhandsontable)
shinyUI(fluidPage(
  headerPanel("Cost sharing calculator"),
  sidebarPanel(
    textInput("cost", "Cost", value = "0")
  ),
  mainPanel(
    p('This page lets you distribute costs between people, based on a number of 
      shares. This enables a fairer way of sharing between families and individuals.'),
    p('Please see the cost sharing introduction for more details.'),
    verbatimTextOutput("debug"),
    rHandsontableOutput('table')
    )
))