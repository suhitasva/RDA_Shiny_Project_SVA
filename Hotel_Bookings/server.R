library(tidyverse)
library(dplyr)
library(ggplot2)
library(datasets)
library(funModeling) 
library(Hmisc)
library(shiny)


function(input, output) {

  output$freq <- renderPlot({
    
    filtered_df <- cancel_df %>% filter(hotel == input$hotel_type)
    
    if (input$hotel_type == "Both"){
      filtered_df <- cancel_df}

    filtered_df %>%
                  ggplot(. ,aes(x = hotel,
                                y = percent_cancellation,
                                label = percent_cancellation,
                                fill = is_canceled)) +
                  geom_col(stat = "identity", width = 0.5) +
                  geom_text(size = 3.5, position = position_stack(vjust = 0.5),
                            colour = "white", fontface = "bold") +
                  labs(title ="Percent Cancellations by Hotel Type", x = "Type of Hotel",
                       y = "Percentage of bookings (%)") +
                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())})

  output$canceldf <- renderTable({cancel_df}, striped = TRUE, hover=TRUE,
                                 bordered=TRUE, spacing = "l", width="670px",
                                 align="c")}
