library(tidyverse)
library(dplyr)
library(ggplot2)
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
                  geom_text(size = 4, position = position_stack(vjust = 0.5),
                            colour = "white", fontface = "bold") +
                  labs(title ="Percent Cancellations by Hotel Type", x = "Type of Hotel",
                       y = "Percentage of bookings (%)") +
                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())
    
    })

  output$canceldf <- renderTable({cancel_df}, striped = TRUE, hover=TRUE,
                                  bordered=TRUE, spacing = "l", width="670px",
                                  align="c")
  
  #===============================================================================================#
  #===============================================================================================#
  
  output$dep <- renderPlot({
    
                  cancel_type <- as.integer(input$cancel_type)
                  
                  is_canceled_labs = c("Not cancelled", "Cancelled")
                  names(is_canceled_labs) <- c("0", "1")
    
                  hotels_df %>% select(hotel, is_canceled, deposit_type) %>%
                  filter(hotel == input$hotel_type2 & is_canceled == input$cancel_type) %>% 
                  group_by(hotel, is_canceled, deposit_type) %>%
                  summarise(bookings_by_deposit_type = n()) %>%
                  ggplot(. ,aes(x = deposit_type, y = log(bookings_by_deposit_type),
                                label = bookings_by_deposit_type)) +
                  geom_col(aes(fill = hotel), position = "dodge2") +
                  facet_grid(is_canceled ~ hotel, labeller = labeller(is_canceled = is_canceled_labs)) + 
                  scale_fill_manual(values=c("deeppink4","darkorchid4")) +
                  labs(title = "Number of bookings for each deposit type",
                       x = "Type of Deposit",
                       y = "Number of bookings - log scale") +
                  geom_text(size = 4, position = position_dodge2(0.9), vjust = 1.8, 
                            colour = "white", fontface = "bold") +
                  theme(plot.title = element_text(hjust = 0.5),
                  panel.grid.major.x = element_blank(),
                  legend.title = element_blank())})
  
  
  output$depositdf1 <- renderTable({hotels_df %>% select(hotel, is_canceled, deposit_type) %>%
                                    group_by(hotel, is_canceled, deposit_type) %>%
                                    filter(hotel == "City Hotel") %>%
                                    summarise(bookings_by_deposit_type = n())},
                                    striped = TRUE, hover=TRUE,
                                    bordered=TRUE, spacing = "l", width="750px",
                                    align="c")
  
  output$depositdf2 <- renderTable({hotels_df %>% select(hotel, is_canceled, deposit_type) %>%
                                    group_by(hotel, is_canceled, deposit_type) %>%
                                    filter(hotel == "Resort Hotel") %>%
                                    summarise(bookings_by_deposit_type = n())},
                                    striped = TRUE, hover=TRUE,
                                    bordered=TRUE, spacing = "l", width="750px",
                                    align="c")
  
  #===============================================================================================#
  #===============================================================================================#
  
  output$dist <- renderPlot({
    
    filtered_df1 <- hotels_df %>% select(hotel, is_canceled, distribution_channel) %>%
                                  filter(is_canceled == 1 & hotel == input$hotel_type3)
    
    if (input$hotel_type3 == "Both"){
      filtered_df1 <- hotels_df %>% select(hotel, is_canceled, distribution_channel) %>%
                                    filter(is_canceled == 1)}
    
    filtered_df1 %>%
                  group_by(hotel, is_canceled, distribution_channel) %>%
                  summarise(bookings_by_distribution = n()) %>%
                  mutate(total_cancelled_bookings = sum(bookings_by_distribution)) %>%
                  ggplot(. ,aes(x = log(bookings_by_distribution), y = hotel,
                                label = bookings_by_distribution, fill = distribution_channel)) +
                  geom_col(stat = "identity", width = 0.5) +
                  geom_text(size = 3.5, position = position_stack(vjust = 0.5), 
                            colour = "white", fontface = "bold") +
                  labs(title ="Number of cancelled bookings per distribution type", y = "Type of Hotel",
                       x = "Number of bookings - (log-scale)") +
                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())
    
  })
  
  
  output$distdf1 <- renderTable({hotels_df %>% select(hotel, is_canceled, distribution_channel) %>%
                                    filter(is_canceled == 1 & hotel == "City Hotel") %>%
                                    group_by(hotel,is_canceled, distribution_channel) %>%
                                    summarise(bookings_by_distribution = n()) %>%
                                    arrange(bookings_by_distribution)},
                                    striped = TRUE, hover=TRUE,
                                    bordered=TRUE, spacing = "l", width="750px",
                                    align="c")
  
  output$distdf2 <- renderTable({hotels_df %>% select(hotel, is_canceled, distribution_channel) %>%
                                    filter(is_canceled == 1 & hotel == "Resort Hotel") %>%
                                    group_by(hotel,is_canceled, distribution_channel) %>%
                                    summarise(bookings_by_distribution = n()) %>%
                                    arrange(bookings_by_distribution)},
                                    striped = TRUE, hover=TRUE,
                                    bordered=TRUE, spacing = "l", width="750px",
                                    align="c")
  
  
}
