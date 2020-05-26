ui <- fluidPage(
  theme = shinytheme("cerulean"), 
  # this doesn't have any theme
  titlePanel("Regional Performance"),
  
  sidebarLayout( 
    sidebarPanel(
      
      checkboxGroupInput("region_group", label = "Region group", 
                         choices = list("Edinburgh", 
                                        "Glasgow", 
                                        "Inverness"),
                         selected = "Edinburgh"),
      
      dateRangeInput("daterange", "Date range:",
                     start =  "2016-09-01",
                     end   =  "2020-04-29"),
      
      #Action buttons
      
      sliderInput("miles", 
                  "Distance in miles",
                  value = 50, max = 100, min = 0),
      
      selectInput("metrics",
                  "Metrics",
                  choices = c("Users" = "users",
                              "Sessions" = "sessions", 
                              "New Users" = "new_users"),
                  selected = "users"),
      
      actionGroupButtons(
        inputIds = c("date", "week", "month"),
        labels = list("Date", "Week","Month"),
        fullwidth = T
      )
      
      
    ),
    
    
    
    # Show a plot of the generated distribution
    mainPanel( 
      
      fluidRow(
        
        plotOutput("line_chart")
        
      ),
      
      fluidRow(
        
        column(4,
               
               plotOutput("bar_user")),
        
        column(4,
               
               plotOutput("bar_new_user")),
        
        column(4,
               
               plotOutput("bar_session"))
        
      ),
      
      fluidRow( 
        
        leafletOutput("scotland_map")
        
      )
      
    )
  )
)
