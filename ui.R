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
    p("Follow these steps or see the presentation for more details."),
    tags$ol(tags$li("Set the cost"),
            tags$li("Enter the names and shares in the table"),
            tags$li("Copy the results into an email")),
    tags$br(),
    # verbatimTextOutput("debug"),
    rHandsontableOutput('table')
    # plotOutput('plot')
    )
))