
library(shinydashboard)
library(shiny)

dashboardPage(
  skin = "purple",
  dashboardHeader(title='Hotel Booking Analysis',
                  titleWidth = 300),
  dashboardSidebar(width = 300),
  dashboardBody()
)