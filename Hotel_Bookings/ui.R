
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
                              icon = icon("concierge-bell")),
                     menuItem("Booking Deposit Type",
                              tabName = "deposit",
                              icon = icon("concierge-bell")),
                     menuItem("Hotel Distribution Type",
                              tabName = "distribution",
                              icon = icon("concierge-bell"),
                              menuSubItem("Total Bookings", 
                                          tabName = "tot_book"),
                              menuSubItem("Average ADR",
                                          tabName = "avg_adr")),
                     menuItem("Repeat/Non-Repeat Guests",
                              tabName = "guest",
                              icon = icon("concierge-bell"),
                              menuSubItem("Total Bookings", 
                                          tabName = "tot_book_guest"),
                              menuSubItem("Weekday/Weekend Nights Bookings",
                                          tabName = "week_day_end")),
                     menuItem("Monthly Cancellations and ADR",
                              tabName = "monthly_adr",
                              icon = icon("concierge-bell")))),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "cancel",
              h2("Cancelled and Non Cancelled Bookings ratio by Hotel Types"),
              mainPanel((plotOutput("count")))),
      tabItem(tabName = "deposit",
              h2("Number of bookings for different deposit types"))
)))