library(shiny)
library(rhandsontable)

# The Nottingham group are a set of friends from university
# We'll use them as a pre-populated data set
# nottingham.group 
cost.table <- data.frame(name = c('Ashby', 'Bradley', 'Grogan', 'Judge', 'Laud', 
                                      'Lill', 'Megan', 'Pollard', 'Quinlan'),
                            shares = as.integer(c(3, 3, 2, 3, 3, 3, 3, 3, 1)),
                            payment = 0,
                            stringsAsFactors = FALSE)

shinyServer(
  function(input, output) {
    output$debug <- renderPrint({sum(cost.table$shares)})

    output$table <- renderRHandsontable({
      if (!is.null(input$table)) {
        cost.table <- hot_to_r(input$table)
        names(cost.table) <- c("name", "shares", "payment")
        } 
      share.cost <- as.numeric(input$cost) / sum(cost.table$shares)
      cost.table$payment <- share.cost * cost.table$shares
      rhandsontable(cost.table, rowHeaders = NULL, colHeaders = c("Names", 
                                                                  "Shares", 
                                                                  "Payment")
                    )
      })
  }
)