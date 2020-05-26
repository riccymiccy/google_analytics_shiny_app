# google_analytics_shiny_app

# Wesbite Regional Performance

## Authors
Sandra Tobon, Amit Pandi, Masood Khan, Ric Clark

## Project Brief
### Regional Performance

The client wanted the ability to analyse website performance as Google Analystics is too restrictive.
- Limited or no ability to compare site performance between their three locations
- Overview of a single city’s performance is complicated because of Google Analytics’ use of multiple small towns around a given city
- Compare site performance in a defined Edinburgh, Glasgow and Inverness catchment

We have synthesised the data for the purposes of demonstrating what we achieved. The link to that data can be found here.

## Tools

The data was called from the google_analytics API. We were coding in R.

The dashboard was created shinydashboard with the following libraries: 
- `library(leaflet)`
- 'library(shiny)'           
- 'library(shinythemes)'
- 'library(tidyverse)'               
- 'library(readr)'
- 'library(DT)'
- 'library(shinyWidgets)'
- 'library(geosphere)'
- 'library(lubridate)'
- 'library(tsibble)'


## Synthesising the data
For public demonstrations of this dashboard the data was synthesised in R using `library(synthpop)`. 
Calls were made to the GoogleAnalytics API to extract the metrics and dimension of interest. The output data was put through the synthpop library in R.

## Dashboard
### Overview Tab


#### Defining the catchments


![](/www/screenshot_overview.png)

### Raw Data Tab
This tab shows the raw data which changes in reaction to the user inputs. Kept in incase the user wants to understand the changes behind the scene or to debug.

![](/www/screenshot_rawdata_menu.png)
