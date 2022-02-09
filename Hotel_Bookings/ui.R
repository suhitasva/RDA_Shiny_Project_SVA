
library(shinydashboard)
library(shiny)

dashboardPage(
  skin = "purple",
  dashboardHeader(title='Hotel Bookings Analysis',
                  titleWidth = 300),
  dashboardSidebar(color = "teal", width = 300),
  dashboardBody()
)