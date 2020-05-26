server <- function(input, output) {
  
  filter_miles <- reactive({
    #Here we generate all the data that don't depend of the time (plots and map)
    process_data_map(analytics, input$miles, input$daterange[1], input$daterange[2]) %>%
      filter(region %in% input$region_group )
  })
  
  filter_line <- reactive({
    #Here we generate the data that depend of the time (line chart)
    data_line_t(analytics, filter_miles(), input$daterange[1], input$daterange[2]) %>%
      filter(region %in% input$region_group )
  })
  
  
  reactive_plot <- reactiveValues(
    line_chart = NULL
  )
  
  observeEvent(input$date, {
    reactive_plot$line_chart <- filter_line() %>%
      ggplot() +
      aes_string(x = "date", y = input$metrics, color = "region") +
      geom_line() +
      scale_color_manual(values = c("#EE736D", "#18A83B", "#1A619F")) 
  })
  
  observeEvent(input$week, {
    reactive_plot$line_chart <- filter_line() %>%
      mutate(year_week = floor_date(date, "1 week", week_start = 1)) %>%
      group_by(year_week, region) %>%
      summarise(metric = sum(!!sym(input$metrics))) %>%
      ggplot() +
      aes(x = year_week, y = metric,
          group = region, color = region) +
      geom_line() +
      scale_x_date(breaks = "1 month", minor_breaks = "1 week") +
      scale_color_manual(values = c("#EE736D", "#18A83B", "#1A619F")) +
      theme(axis.text.x = element_text(angle = 120, hjust = 1)) +
      labs(
        x = "weekly",
        y = input$metrics
      )
  })
  
  observeEvent(input$month, {
    reactive_plot$line_chart <- filter_line() %>%
      mutate(year_week = floor_date(date, "month")) %>%
      group_by(year_week, region) %>%
      summarise(metric = sum(!!sym(input$metrics))) %>%
      ggplot() +
      aes(x = year_week, y = metric,
          group = region, color = region) +
      geom_line() +
      scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +
      scale_color_manual(values = c("#EE736D", "#18A83B", "#1A619F")) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      labs(
        x = "monthly",
        y = input$metrics
      )
    
  })
  
  output$line_chart <- renderPlot({
  #The default value is the line chart by dates also you can generate it by press the buttons 
    if(is.null(reactive_plot$line_chart)) return(
      filter_line() %>%
        ggplot() +
        aes_string(x = "date", y = input$metrics, color = "region") +
        geom_line() +
        scale_color_manual(values = c("#EE736D", "#18A83B", "#1A619F")) 
    )
    reactive_plot$line_chart
  })
  
  output$bar_user <- renderPlot({
    plot_metrics(filter_miles(), "users")
  })
  
  output$bar_new_user <- renderPlot({
    plot_metrics(filter_miles(), "new_users")
  })
  
  output$bar_session <- renderPlot({
    plot_metrics(filter_miles(), "sessions")
  })
  
  output$scotland_map <- renderLeaflet({
    #Here we generate the color and the plot for the map
    pal <- colorFactor(palette = c("#EE736D", "#18A83B", "#1A619F"), c("Edinburgh", "Glasgow", "Inverness"))
    leaflet(filter_miles()) %>% 
      fitBounds(-8.00, 54.50, -1.00, 59.50) %>% 
      addTiles() %>% 
      addCircleMarkers(lng = ~longitude, lat = ~latitude, radius = 1, 
                       weight = 2, color = ~pal(region))
  })
  
}
