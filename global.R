#Here we are calling all the libraries that we will use durng the project
library(shiny)            
library(shinythemes) 
library(tidyverse)               
library(readr)
library(DT)
library(shinyWidgets)
library(leaflet)
library(geosphere)
library(lubridate)
library(tsibble)

source("functions.R")
#read the synthetic data 
analytics <- read_csv("syn_analytics_data.csv")