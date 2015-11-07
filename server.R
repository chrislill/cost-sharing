library(shiny)
library(rhandsontable)

# The Nottingham group are a set of friends from university
# We'll use them as a pre-populated data set
nottingham.group <- data.frame(name = c('Ashby', 'Bradley', 'Grogan', 'Judge', 'Laud', 
                                      'Lill', 'Megan', 'Pollard', 'Quinlan'),
                            share = as.integer(c(3, 3, 2, 3, 3, 3, 3, 3, 1)),
                            payment = numeric(9),
                            stringsAsFactors = FALSE)

shinyServer(
  function(input, output) {
    sharing.table <- nottingham.group
    

    output$table <- renderRHandsontable({rhandsontable(sharing.table, 
                                                       rowHeaders = NULL,
                                                       colHeaders = c("Names", 
                                                                      "Shares", 
                                                                      "Payment")
                                                       )})
  }
)