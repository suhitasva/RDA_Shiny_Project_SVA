
library(shinydashboard)
library(shiny)

dashboardPage(
  skin = "purple",
  dashboardHeader(title='Hotel Bookings Analysis',
                  titleWidth = 350),
  dashboardSidebar(width = 350,
                   sidebarMenu(
                     menuItem("Introduction",
                              tabName = "intro",
                              icon = icon("h-square")),
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
                              icon = icon("concierge-bell")),
                     menuItem("Takeaways/Conclusion",
                              tabName = "conclu",
                              icon = icon("h-square")))),
  
  dashboardBody(
    tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 24px;
      }
    '))),
    tags$style(HTML(".sidebar-menu li a {
                    font-family: Georgia, Times, Times New Roman, serif;
                    font-size: 15px;
                    font-weight: bold;
                    }")),
    tabItems(
      tabItem(tabName = "intro",
              hr(),
              fluidPage(mainPanel(imageOutput(outputId="intro")))),
      
      #===============================================================================================#
      #                             Cancelled and Non Cancelled Bookings
      #===============================================================================================#
      
      
      tabItem(tabName = "cancel",
              h2("Cancelled and Non Cancelled booking ratios by hotel type: "), hr(),
              fluidRow(box(title = "Cancelled vs Non-Cancelled plots", 
                           plotOutput('freq', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info"),
                       box(title = "Bookings Table", 
                           p(strong("Percentage of Cancelled and Non-Cancelled bookings per hotel type: ")),
                           br(), "**percent_cancellations (%): percentage of total bookings", hr(),
                           tableOutput(outputId ="canceldf"),
                           solidHeader = TRUE, status = "info")),
              fluidRow(box(title = "Type of Hotel:",
                           status = "success", solidHeader = TRUE, width = 3,
                           radioButtons("hotel_type","Select Hotel Type:",
                                        inline = TRUE, selected = "City Hotel",
                                        c("City Hotel","Resort Hotel","Both"))))),
      
      #===============================================================================================#
      #                               Booking deposit type
      #===============================================================================================#
      
      
      tabItem(tabName = "deposit",
              h2("Total Number of bookings for different types of deposits: "), hr(),
              fluidRow(box(title = "Bookings by deposit type plots", 
                           plotOutput('dep', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info"),
                       tabBox(title = "Bookings Table", 
                              id = "tabset1", height = "450px",
                              tabPanel("City Hotel",
                                       p(strong("Total Number of Cancelled and
                                                Non-Cancelled bookings per deposit type: ")),
                                       hr(), tableOutput(outputId ="depositdf1"),
                                       "Cancellation codes: 0 = Not-Cancelled; 1 = Cancelled", hr(),
                                       "Partial Deposit codes:", hr(),
                                       "Non-refund = Deposit amount equal to total stay cost", hr(), 
                                       "Refundable = Deposit amount less than total stay cost"),
                              tabPanel("Resort Hotel",
                                       p(strong("Total Number of Cancelled and
                                                Non-Cancelled bookings per deposit type: ")),
                                       hr(), tableOutput(outputId ="depositdf2"),
                                       "Cancellation codes: 0 = Not-Cancelled; 1 = Cancelled", hr(),
                                       "Partial Deposit codes:", hr(),
                                       "Non-refund = Deposit amount equal to total stay cost", hr(),
                                       "Refundable = Deposit amount less than total stay cost"))),
              fluidRow(box(title = "Type of Hotel:",
                           status = "success", solidHeader = TRUE, width = 3,
                           radioButtons("hotel_type2","Select Hotel Type:",
                                        selected = "City Hotel", inline = TRUE,
                                        c("City Hotel","Resort Hotel"))),
                       box(title = "Booking Status:",
                           status = "success", solidHeader = TRUE, width = 3,
                           radioButtons("cancel_type","Select Booking Status:",
                                        selected = 1, inline = TRUE,
                                        c("Cancelled" = 1 ,
                                          "Not-Cancelled" = 0))))),
      
      #===============================================================================================#
      #                       Hotel Distribution Type - Total Bookings
      #===============================================================================================#
      
      
      tabItem(tabName = "tot_book",
              h2("Total Number of cancelled bookings for different hotel distribution types: "), hr(),
              fluidRow(box(title = "Bookings by distribution type plots", 
                           plotOutput('dist', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info"),
                       tabBox(title = "Bookings Table", 
                              id = "tabset2", height = "450px",
                              tabPanel("City Hotel",
                                       p(strong("Total Number of cancelled bookings per distribution type: ")),
                                       hr(), tableOutput(outputId ="distdf1"),
                                       "Cancellation code: 1 = Cancelled", hr(),
                                       "Hotel Distribution code:", hr(),
                                       "TA/TO = Travel Agent/Tour Operator"),
                              tabPanel("Resort Hotel",
                                       p(strong("Total Number of cancelled bookings per distribution type: ")),
                                       hr(), tableOutput(outputId ="distdf2"),
                                       "Cancellation code: 1 = Cancelled", hr(),
                                       "Hotel Distribution code:", hr(),
                                       "TA/TO = Travel Agent/Tour Operator"))),
              fluidRow(box(title = "Type of Hotel:",
                           status = "success", solidHeader = TRUE, width = 3,
                           radioButtons("hotel_type3","Select Hotel Type:",
                                        selected = "City Hotel", inline = TRUE,
                                        c("City Hotel","Resort Hotel", "Both"))))),
      
      #===============================================================================================#
                                # Hotel Distribution Type - Average ADR
      #===============================================================================================#
      
      
      tabItem(tabName = "avg_adr",
              h2("Average Daily Rate Evaluation for different hotel distribution types"), hr(),
              fluidRow(box(title = "Average Daily Rates for each distribution type - cancelled bookings", 
                           plotOutput('avg_adr', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info"),
                       box(title = "Distribution of Rates for all bookings - City Hotel", 
                           plotOutput('adr_dist', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info")),
              fluidRow(box(title = "Type of Hotel Distribution:",
                           status = "success", solidHeader = TRUE, width = 4,
                           selectInput("hotel_dist1","Select Distribution Type:",
                                       selected = "TA/TO",
                                       c("TA/TO","GDS","Direct", "Corporate"))),
                       box(title = "Booking Status:",
                           status = "success", solidHeader = TRUE, width = 4,
                           radioButtons("cancel_type1","Select Booking Status:",
                                        selected = 1, inline = TRUE,
                                        c("Cancelled" = 1 ,
                                          "Not-Cancelled" = 0))))),
      
      #===============================================================================================#
                                # Repeat/Non-Repeat Guests - Total Bookings
      #===============================================================================================#
      
      tabItem(tabName = "tot_book_guest",
              h2("Total Cancelled and Non Cancelled bookings by guest types:"), hr(),
              fluidRow(box(title = "Repeat vs Non-Repeat guest distribution Treemap", 
                           plotOutput('guesttree', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info"),
                       tabBox(title = "Bookings Table", 
                              id = "tabset3", height = "450px",
                              tabPanel("Cancelled Bookings",
                                       p(strong("Total Number of cancelled bookings per guest type: ")),
                                       hr(), tableOutput(outputId ="guestbookdf1"),
                                       "is_repeated_guest code:", hr(),
                                       "0 = Non-Repeat guest", hr(),
                                       "1 = Repeat guest"),
                              tabPanel("Non-Cancelled Bookings",
                                       p(strong("Total Number of cancelled bookings per guest type: ")),
                                       hr(), tableOutput(outputId ="guestbookdf2"),
                                       "is_repeated_guest code:", hr(),
                                       "0 = Non-Repeat guest", hr(),
                                       "1 = Repeat guest"))),
              fluidRow(box(title = "Booking Status:",
                           status = "success", solidHeader = TRUE, width = 3,
                           radioButtons("cancel_type2","Select Booking Status:",
                                        selected = 1, inline = TRUE,
                                        c("Cancelled" = 1 ,
                                          "Not-Cancelled" = 0))))),
      
      #===============================================================================================#
                                # Repeat/Non-Repeat Guests - Weekday/Weekend Bookings
      #===============================================================================================#
      
      tabItem(tabName = "week_day_end",
              h2("Weekday/Weekend cancelled bookings per guest type"), hr(),
              fluidRow(box(title = "Bookings by Weekday/Weekends - Barplots", 
                           plotOutput('week', height = "450px", width = "730px"),
                           solidHeader = TRUE, status = "info"),
                       tabBox(title = "Bookings Table", 
                              id = "tabset4", height = "450px",
                              tabPanel("City Hotel",
                                       p(strong("Total Number of cancelled bookings per stay type: ")),
                                       hr(), tableOutput(outputId ="wkdayendf1"),
                                       "Cancellation code: 1 = Cancelled"),
                              tabPanel("Resort Hotel",
                                       p(strong("Total Number of cancelled bookings per stay type: ")),
                                       hr(), tableOutput(outputId ="wkdayendf2"),
                                       "Cancellation code: 1 = Cancelled"))),
              fluidRow(box(title = "Type of Booking:",
                           status = "success", solidHeader = TRUE, width = 3,
                           radioButtons("hotel_type4","Select Stay Type:",
                                        selected = "City Hotel", inline = TRUE,
                                        c("City Hotel","Resort Hotel"))))),
      
      #===============================================================================================#
                                      # Monthly Cancellations and ADR
      #===============================================================================================#
      
      tabItem(tabName = "monthly_adr",
              h2("Monthly Average Daily Rate evaluation per hotel and distribution type (2016)"), hr(),
              fluidRow(box(title = "Number of cancellations and average ADR plots", 
                           plotOutput('monthly_adr', height = "600px"),
                           solidHeader = TRUE, status = "info", width = 8)),
              fluidRow(box(title = "Type of Hotel Distribution:",
                           status = "success", solidHeader = TRUE, width = 4,
                           radioButtons("hotel_dist2","Select Distribution Type:",
                                       selected = "Direct", inline = TRUE,
                                       c("Direct", "All Others"))),
                       box(title = "Type of Booking:",
                           status = "success", solidHeader = TRUE, width = 4,
                           radioButtons("hotel_type5","Select Stay Type:",
                                        selected = "City Hotel", inline = TRUE,
                                        c("City Hotel","Resort Hotel"))))),
      
      #===============================================================================================#
                                      # Conclusion
      #===============================================================================================#
      
      
      tabItem(tabName = "conclu",
              hr(),
              fluidPage(mainPanel(imageOutput(outputId="conclu"))))
      )
    
    )
  
  )