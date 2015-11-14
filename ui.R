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
    p("Going on holiday in a large group is great fun, but splitting costs is difficult."),
    p("One approach is to allocate a number of shares per person or family. This app will
      do the maths for you. The default values give an example for sharing costs between
      my friends' families."),
    p("Just follow these steps to get started."),
    tags$ol(tags$li("Set the cost"),
            tags$li("Enter the names and shares in the table - double tap to edit"),
            tags$li("Copy the results into an email")),
    p("There's more detail in the presentation at ", 
      a("http://rpubs.com/chrislill/cost-sharing", href="http://rpubs.com/chrislill/cost-sharing")),
    tags$br(),
    # verbatimTextOutput("debug"),
    rHandsontableOutput('table')
    # plotOutput('plot')
    )
))