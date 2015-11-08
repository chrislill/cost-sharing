library(shiny)
library(rhandsontable)
# library(ggplot2)

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
    
    # ActionButton for Add Row 
    observeEvent(input$addRow, {
      cost.table <<- rbind(cost.table, list("", 1L, 0))
      retrieve.table <<- FALSE
    },
    priority = 1)

    # output$debug <- renderPrint("Debug")

    # Main function for editable data table
    output$table <- renderRHandsontable({
      
      # Execute the function if either of the buttons are pressed
      if (input$reset > 0) {}
      if (input$addRow > 0) {}
      
      # Retrieve the modified table
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
      
      rhandsontable(cost.table, 
                    rowHeaders = NULL, 
                    colHeaders = c("Names", "Shares", "Payment"),
                    contextMenu = FALSE,
                    fillHandle = FALSE,
                    allowRowEdit = FALSE,
                    allowColEdit = FALSE)
    })
    
# The plot is pretty, but it will take too much effort to hook it up to all the reactive events 
# and to prevent it from constraining the data table
# 
#     output$plot <- renderPlot({
#       # Execute the function if the table changes
#       if (!is.null(input$table)) {}
# 
#       if(input$cost != 0){
#         # Reorder the names so that the plot is in the correct order
#         cost.table$name2 <- reorder(cost.table$name, nrow(cost.table):1)
#         
#         ggplot(cost.table, aes(x = name2, y = payment)) +
#           geom_bar(stat = "identity", fill = "limegreen") +
#           coord_flip() +
#           geom_text(aes(label = payment, hjust = 1.3)) +         
#           theme(legend.position = "none",
#                 panel.grid = element_blank(),
#                 axis.text.x = element_blank(),
#                 axis.ticks.x = element_blank(),
#                 axis.ticks.y = element_blank()
#           ) +
#           labs(x = NULL, y = NULL)        
#       }
#     })
  }
)