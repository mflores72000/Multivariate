library(qcr)
data(dowel1)
data(archery1)

library ( shiny ) 

shinyServer ( function ( input , output ) { 

  datasetInput <- reactive ({ switch ( input$dataset , 
                                       "dowel" = dowel1 , 
                                       "archery" = archery1)}) 

  output$summary <- renderPrint ({ dataset <- datasetInput () 
                                       summary ( dataset ) }) 
  
  output$view <- renderTable ({ head ( datasetInput (), n = input$obs ) })
  
  output$downloadData <- downloadHandler ( filename = function () 
  { paste ( input$dataset , '.csv' , sep = '' ) }, 
                                           content = function ( file ) 
                                           { write.csv ( datasetInput (), file ) } )
  
  mqcs <- reactive ({ type <- switch ( input$type , mqcs.t2 = mqcs.t2 , 
                                      mqcs.mcusum = mqcs.mcusum , 
                                      mqcs.mewma = mqcs.mewma)
                     
                     type( x = datasetInput (),
                           data.name = input$title)} )
  
  output$plot <- renderPlot ({ type <- input$type 
                               plot( mqcs(),main=input$title) 
                            }) 

   output$summaryqcs <- renderPrint ({ summary ( mqcs ()) }) 
#   output$table <- renderTable ({ data.frame ( x = data ()) }) 

                        }) 

