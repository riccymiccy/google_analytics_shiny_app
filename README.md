# google_analytics_shiny_app

# Wesbite Regional Performance

## Authors
Sandra Tobon, Amit Pandit, Masood Khan, Ric Clark

We had 6 days to think, brainstorm, plan, code and debug our shiny app. We worked on the project completely remotely, due to COVID-19 peventing us from meeting.

## Project Brief
### Regional Performance

The client wanted the ability to analyse website performance as Google Analytics is too restrictive.
- Limited or no ability to compare site performance between their three locations
- Overview of a single city’s performance is complicated because of Google Analytics’ use of multiple small towns around a given city
- Compare site performance in a defined Edinburgh, Glasgow and Inverness catchment

We have synthesised the data for the purposes of demonstrating what we achieved. The link to that data can be found here.

## Tools

The data was called from the google_analytics API. We were coding in R.

The dashboard was created shinydashboard with the following libraries: 
- `library(leaflet)`
- `library(shiny)`
- `library(shinythemes)`
- `library(tidyverse)`              
- `library(readr)`
- `library(DT)`
- `library(shinyWidgets)`
- `library(geosphere)`
- `library(lubridate)`
- `library(tsibble)`


## Synthesising the data
For public demonstrations of this dashboard the data was synthesised in R using `library(synthpop)`. 
Calls were made to the Google Analytics API to extract the metrics and dimension of interest. The output data was put through the synthpop library in R.

## How we spent our time
Day 1: We spent a lot of time trying to answer what the business question was and thinking about ideas individually as well as coming together to discuss the constraints of Google Analytics, presenting value in a dashboard and discussing ideas. 

Day 2: We did a lot of brainstorming and spent a lot of time focusing on the client's brief. We planned how we could build a framework to show the client and additional questions we could ask to deliver what they were looking for. We also created the GitHub repository to build the app and cretaed a basic skeleton for it in R Studio. We also drew some wireframes of potential dashboard designs. We contacted the client to get some more specific information about other marketing campaigns that taken place, date, medium and geographic focus.

Day 3: We had a client meeting where we outlined our proposed plan. The client liked our proposal and gave us feedback. We also discussed additional data that he could perhaps provide for us. Afterwards, after some more planning discussion, we decided how to split the coding within the team. Sandra decided she wanted to to do all the coding to extract the data from Google Analtyics and the associated data wrangling to make it usable for a reactive dashboard. Amit and Masood decide to work on the graphs and shiny widgets. Ric opted to work on a map to show the geospatial dsitribution of website contacts.

Day 4: We worked on the coding both on our own and together trying to help each other if we got stuck. We got our first graph working but there were plenty of stumbling blocks. We made the decision to split Scotland regionally, by proximity to the nearest client office.

Day 5: We continued to working on coding and completely re-writing some bits of code if need be. As we had spent to much time planning we finished the day feeling that we had definitely hit the MVP for the project.

Day 6: We each took our turn to present to the client.

## Dashboard
### Overview Tab


## Additional functionality that we would have liked to do if we had more time
Customise the dashboard as per the marketing campaigns and have flexibility of adding new campaigns
Plot the marketing campaigns in the line graph
Plot the marketing campaigns in the graphs on a 90 day before and after comparison with a reactive function
Dashboard is only for Scotland at the moment but other regions coverage could be added e.g. North of England

