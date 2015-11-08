library(shiny)
library(rhandsontable)

shinyServer(
  function(input, output) {
    # Set initial values
    retrieve.table <- TRUE    
    
    # The Nottingham group are a set of friends from university
    # We'll use them as a pre-populated data set for each new user
    cost.table <- data.frame(name = c('Ashby', 'Bradley', 'Grogan', 'Judge', 'Laud', 
                                      'Lill', 'Megan', 'Pollard', 'Quinlan'),
                             shares = as.integer(c(3, 3, 2, 3, 3, 3, 3, 3, 1)),
                             payment = 0,
                             stringsAsFactors = FALSE)

    
    # ActionButton for Reset Names 
    observeEvent(input$reset, {
        cost.table <<- data.frame(name = "",
                                 shares = as.integer(c(1, 1)),
                                 payment = 0, 
                                 stringsAsFactors = FALSE)
        retrieve.table <<- FALSE
    },
    priority = 1)

    output$debug <- renderPrint(retrieve.table)

    output$table <- renderRHandsontable({
      if (input$reset > 0) {}
      
      if (!is.null(input$table) && retrieve.table == TRUE) {
        cost.table <- hot_to_r(input$table)
        names(cost.table) <- c("name", "shares", "payment")
      } 
      retrieve.table <<- TRUE
      
      if(input$rounding == TRUE) {
        payment.digits = 0
      } else {
        payment.digits = 2
      }
      
      share.cost <- as.numeric(input$cost) / sum(cost.table$shares)
      cost.table$payment <- round(share.cost * cost.table$shares, payment.digits)
      
      rhandsontable(cost.table, rowHeaders = NULL, colHeaders = c("Names", 
                                                                  "Shares", 
                                                                  "Payment")
                    )
      })
  }
)