
#we use distHaversine function from geosphere library for calculate the distance between 2 points in 
#meters and we convert it to miles by mutiply by 0.000621371
dist_point <- function(analytics, longitude, latitude){
  distHaversine(analytics, c(longitude,latitude))* 0.000621371
}

#Here we proccess the data and group by the data so we could work with it easy. 
process_data_map <- function(analytics, n, day_start, day_end){ 
  #Here are the business location in Edinburgh, Glasgow and Inverness
  edin <- c(-3.201975, 55.947055)
  glas <- c(-4.257983, 55.865674)
  inver <- c(-4.219582, 57.478485)
  
  data_map <- analytics %>%
    mutate_at("latitude", as.numeric) %>%
    mutate_at("longitude", as.numeric) %>%
    filter(date >= as.Date(day_start),
           date <= as.Date(day_end)) %>%
    filter(city != "(not set)") %>%
    group_by(city, latitude, longitude) %>%
    summarise(users = sum(users),
              sessions = sum(sessions), 
              new_users = sum(newUsers)) %>%
    rowwise() %>% 
    mutate(distance_to_edin = dist_point(edin, longitude, latitude)) %>%
    mutate(distance_to_glas = dist_point(glas, longitude, latitude)) %>%
    mutate(distance_to_inver = dist_point(inver, longitude, latitude)) %>%
    #Here we clasificate the data by the region that is closer 
    mutate(region = 
               case_when(
                 distance_to_edin < distance_to_glas & distance_to_edin < distance_to_inver ~ "Edinburgh", 
                 distance_to_glas < distance_to_edin & distance_to_glas < distance_to_inver ~ "Glasgow", 
                 distance_to_inver < distance_to_edin & distance_to_inver < distance_to_glas ~ "Inverness")) %>%
      mutate(final_dist =
               case_when (
                 region == "Edinburgh" ~ distance_to_edin,
                 region == "Glasgow" ~ distance_to_glas,
                 region == "Inverness" ~ distance_to_inver)) %>% 
      #Here we choose only the points that are in the radius of each region according to the radius that 
      #the user choose
      mutate(within_radius = ifelse(final_dist <= n, region, NA)) %>%
      drop_na() %>%
      select(city, region, latitude, longitude, users, sessions, new_users)
    
    return(data_map)
}


plot_metrics <- function(data_map, metric) {
  #Here we generate the plots for the different metrics 
  plot_metric <-  data_map %>%
    group_by(region) %>%
    summarise(total_metric = sum(!!sym(metric))) %>%
    ggplot() +
    aes(x = region, y = total_metric, fill = region) +
    geom_col() +
    scale_fill_manual(values = c("#EE736D", "#18A83B", "#1A619F")) +
    labs(
      x = "",
      y = metric
    )
  return(plot_metric)
}

data_line_t <- function(analytics, data_map, day_start, day_end) {
  data_map <- data_map %>%
    select(city, latitude, longitude, region)
#With a join to data_map we put the region input in the analytics data so we don't have to proccess  
#all the data again.
  data_line <- analytics %>%
    filter(date >= as.Date(day_start),
           date <= as.Date(day_end)) %>%
    rename(new_users = newUsers) %>%
    inner_join(data_map, by = c("city", "latitude", "longitude"))
  return(data_line)
}


