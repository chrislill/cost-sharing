library(shiny)
library(rhandsontable)
shinyUI(fluidPage(
  headerPanel("Cost sharing calculator"),
  sidebarPanel(
    textInput("cost", "Cost", value = "0"),
    actionButton("reset", "Reset Names"),
    p(),
    actionButton("addRow", "Add Row"),
    checkboxInput("rounding", "Round payments?")
  ),
  mainPanel(
    p('This page lets you distribute costs between people, based on a number of 
      shares. This enables a fairer way of sharing between families and individuals.'),
    p("The default values give an example for sharing costs between my friends' families."),
    p('Please see the cost sharing presentation for more details.'),
    verbatimTextOutput("debug"),
    rHandsontableOutput('table')
    )
))