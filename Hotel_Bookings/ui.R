
library(shinydashboard)
library(shiny)

dashboardPage(
  skin = "purple",
  dashboardHeader(title='Hotel Bookings Analysis',
                  titleWidth = 300),
  dashboardSidebar(width = 300,
                   sidebarMenu(
                     menuItem("Cancelled/Non-Cancelled Bookings", 
                              tabName = "cancel",
                              icon = icon("building")),
                     menuItem("Cancellations by Deposit Type",
                              tabName = "widgets",
                              icon = icon("building")),
                     menuItem("Cancellations by Distribution Type",
                              tabName = "widgets",
                              icon = icon("building")),
                     menuItem("Cancellations by Guest Type",
                              tabName = "widgets",
                              icon = icon("building")),
                     menuItem("Monthly Cancellations and ADR",
                              tabName = "widgets",
                              icon = icon("building")))),
  
  dashboardBody()
)