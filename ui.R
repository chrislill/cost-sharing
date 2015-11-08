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
    p("This page lets you distribute costs between people, based on a number of 
      shares. This enables a fairer way of sharing between families and individuals. 
      The default values give an example for sharing costs between my friends' families."),
    p("Set the cost, specify how many shares per person, and then copy the results into an email."),
    p('Please see the cost sharing presentation for more details.'),
    # verbatimTextOutput("debug"),
    rHandsontableOutput('table')
    )
))