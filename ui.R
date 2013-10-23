library ( shiny ) 

doc <- tags$html(
  
  tags$head(
    tags$title('Quality Control Reability (qcr)')
  ),
  tags$body(
    h1(aling='center','MASTER OF STATISTICAL TECHNIQUES - QUALITY CONTROL CHART (MULTIVARIATE)')
#    ,
#    p(aling='center' ,'DEVELOPMENT OF A GRAPHICS APPLICATION PROCESS CONTROL'),
#      div(id='myDiv', class='simpleDiv',
#        'Maintainer: Miguel Flores <mflores@outlook.com>')
  )
)



shinyUI ( pageWithSidebar ( 
    headerPanel ( doc ), 
    sidebarPanel (
        selectInput ( "dataset" , "Choose a dataset:" , 
                      choices = c ( "dowel" , "archery"))
                                       
        ,br(),
        numericInput ( "obs" , "Number of observations to view:" , 10 ) 
        ,br(),                       
        downloadButton ( 'downloadData' , 'Download' )          
        ,br(),                       
        radioButtons ( "type" , "Quality Control Charts type:" , 
                        list ( "t2" = "mqcs.t2" , "mcusum" = "mqcs.mcusum",
                               "mewma" = "mqcs.mewma")) 
        ,br(),
        
        checkboxInput(inputId = "checktitle",
                      label = strong("Title of Chart Control:"),
                      value = FALSE)
        
        ,
        # Display this only if the density is shown
        conditionalPanel(condition = "input.checktitle == true",
                         textInput ( "title" , "" , "Chart of Control Data")  )
        
        
    ),
    mainPanel( 
          tabsetPanel ( tabPanel ( "View" , verbatimTextOutput ( "summary" ), 
                                   tableOutput( "view" ) 
                                  )
                 ,tabPanel ( "Plot" , plotOutput ( "plot" )) 
                 ,tabPanel ( "Summary" , 
                 verbatimTextOutput ( "summaryqcs" ))
#                 ,tabPanel ( "Table" , tableOutput ( "table" ))
                      )
                  )
              )
    )
