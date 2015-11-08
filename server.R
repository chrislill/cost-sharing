library(shiny)
library(rhandsontable)

# The Nottingham group are a set of friends from university
# We'll use them as a pre-populated data set
# nottingham.group 
cost.table <- data.frame(name = c('Ashby', 'Bradley', 'Grogan', 'Judge', 'Laud', 
                                      'Lill', 'Megan', 'Pollard', 'Quinlan'),
                            share = as.integer(c(3, 3, 2, 3, 3, 3, 3, 3, 1)),
                            payment = 0,
                            stringsAsFactors = FALSE)

shinyServer(
  function(input, output) {
    
    output$oshares <- renderPrint({sum(cost.table$share)})

    output$table <- renderRHandsontable({
      share.cost <- as.numeric(input$cost) / sum(cost.table$share)
      cost.table$payment <- share.cost * cost.table$share
      rhandsontable(cost.table, rowHeaders = NULL, colHeaders = c("Names", 
                                                                  "Shares", 
                                                                  "Payment")
                    )
      })
  }
)