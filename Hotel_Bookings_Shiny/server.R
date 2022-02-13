library(tidyverse)
library(dplyr)
library(ggplot2)
library(treemap)
library(RColorBrewer)

library(shiny)


function(input, output) {
  
  
  #===============================================================================================#
                                          # Introduction
  #===============================================================================================#
  
  output$intro <- renderImage({
    
    filename <- normalizePath(file.path('./www',
                                        paste('image1', '.png', sep='')))
    
    list(src = filename)
  }, deleteFile = FALSE)
  
  
  #===============================================================================================#
                              # Cancelled and Non Cancelled Bookings
  #===============================================================================================#
  

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
                  geom_text(size = 6, position = position_stack(vjust = 0.5),
                            colour = "white", fontface = "bold") +
                  labs(title ="Percent Cancellations by Hotel Type", x = "Type of Hotel",
                       y = "Percentage of bookings (%)") +
                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())})

  output$canceldf <- renderTable({cancel_df}, striped = TRUE, hover=TRUE,
                                  bordered=TRUE, spacing = "l", width="670px",
                                  align="c")
  
  #===============================================================================================#
                      # Booking deposit type
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
                  scale_fill_manual(values=c("darkorchid4")) +
                  labs(title = "Number of bookings for each deposit type",
                       x = "Type of Deposit",
                       y = "Number of bookings - log scale") +
                  geom_text(size = 6, position = position_dodge2(0.9), vjust = 1.8, 
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
                            # Hotel Distribution Type - Total Bookings
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
                  geom_text(size = 6, position = position_stack(vjust = 0.5), 
                            colour = "white", fontface = "bold") +
                  labs(title ="Number of cancelled bookings per distribution type", y = "Type of Hotel",
                       x = "Number of bookings - (log-scale)") +
                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())})
  
  
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
  
  #===============================================================================================#
                                # Hotel Distribution Type - Average ADR
  #===============================================================================================#
  
  output$avg_adr <- renderPlot({
    
    hotels_df %>% select(hotel, is_canceled, distribution_channel, adr) %>%
                  filter(distribution_channel == input$hotel_dist1 & is_canceled == 1) %>%
                  group_by(hotel, is_canceled, distribution_channel) %>%
                  summarise(avg_adr = mean(adr)) %>%
                  ggplot(., aes(x=distribution_channel, label = round(avg_adr, 0), y=avg_adr, fill=hotel)) +
                  geom_segment(aes(x=distribution_channel, xend=distribution_channel, y=0, yend=avg_adr)) +
                  geom_point(size=4, alpha=1, shape=21, stroke=0.5) +
                  geom_text(size = 4.5, nudge_y = 1.5, vjust = 2, colour = "blue") +
                  theme_light() + coord_flip() +
                  labs(title ="Average ADR per distribution type", x = "Average ADR",
                       y = "Type of Distribution") +
                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())})
  
  
  output$adr_dist <- renderPlot({
    
                    cancel_type1 <- as.integer(input$cancel_type1)
                  
                    hotels_df %>% select(hotel, is_canceled, distribution_channel, adr) %>%
                                  filter(hotel == "City Hotel" & is_canceled == input$cancel_type1 & adr<400) %>%
                                  ggplot(aes(x=fct_reorder(distribution_channel, adr), y=adr, fill=distribution_channel)) +
                                  geom_boxplot(alpha=0.7) +
                                  stat_summary(fun=mean, geom="point", shape=20, size=3, color="red", fill="red") +
                                  scale_fill_brewer(palette="Set2") +
                                  labs(title ="Average ADR distribution (non-cancelled) per Hotel Distribution type",
                                       x = "Hotel Distribution chanel",
                                       y = "Average ADR - log scale") +
                                  theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())})
  
  
  #===============================================================================================#
                              # Repeat/Non-Repeat Guests - Total Bookings
  #===============================================================================================#
  
  output$guestbookdf1 <- renderTable({hotels_df %>% select(hotel, is_canceled, is_repeated_guest) %>%
                                      filter(is_canceled == 1) %>%
                                      group_by(hotel, is_canceled, is_repeated_guest) %>%
                                      summarise(bookings_by_guest_type = n()) %>%
                                      mutate(total_bookings = sum(bookings_by_guest_type))},
                                      striped = TRUE, hover=TRUE,
                                      bordered=TRUE, spacing = "l", width="750px",
                                      align="c")
  
  output$guestbookdf2 <- renderTable({hotels_df %>% select(hotel, is_canceled, is_repeated_guest) %>%
                                      filter(is_canceled == 0) %>%
                                      group_by(hotel, is_canceled, is_repeated_guest) %>%
                                      summarise(bookings_by_guest_type = n()) %>%
                                      mutate(total_bookings = sum(bookings_by_guest_type))},
                                      striped = TRUE, hover=TRUE,
                                      bordered=TRUE, spacing = "l", width="750px",
                                      align="c")
  
  output$guesttree <- renderPlot({
    
                    cancel_type2 <- as.integer(input$cancel_type2)
                    
                    hotels_df %>% select(hotel, is_canceled, is_repeated_guest) %>%
                                  filter(is_canceled == input$cancel_type2) %>%
                                  group_by(hotel, is_canceled, is_repeated_guest) %>%
                                  summarise(bookings_by_guest_type = n()) %>%
                                  mutate(total_bookings = sum(bookings_by_guest_type)) %>%
                                  treemap(., 
                                          index=c("hotel","is_repeated_guest"),  
                                          vSize = "bookings_by_guest_type", 
                                          type="index", 
                                          palette = "Pastel1",
                                          title="Cancelled bookings - repeat vs non-repeat guest distribution", 
                                          fontsize.title = 14,
                                          fontsize.labels=c(15,12),                
                                          fontcolor.labels=c("black","blue"),    
                                          fontface.labels=c(2,1),                  
                                          bg.labels=c("transparent"),              
                                          align.labels=list(
                                            c("center", "top"), 
                                            c("center", "center")),
                                          overlap.labels=0.5, inflate.labels=F)})
  
  
  #===============================================================================================#
                  # Repeat/Non-Repeat Guests - Weekday/Weekend Bookings
  #===============================================================================================#
  
  output$wkdayendf1 <- renderTable({repeat_df %>% pivot_longer(c(weekend_bookings:weekday_bookings),
                                     names_to = "Week/Weekend_Booking", values_to="Nights booked") %>%
                                     filter(hotel == "City Hotel")},
                                     striped = TRUE, hover=TRUE,
                                     bordered=TRUE, spacing = "m", width="680px",
                                     align="c")
    
  output$wkdayendf2 <- renderTable({repeat_df %>% pivot_longer(c(weekend_bookings:weekday_bookings),
                                      names_to = "Week/Weekend_Booking", values_to="Nights booked") %>%
                                      filter(hotel == "Resort Hotel")},
                                      striped = TRUE, hover=TRUE,
                                      bordered=TRUE, spacing = "m", width="680px",
                                      align="c")
  
  
  output$week <- renderPlot({
    
    repeat_df %>% pivot_longer(c(weekend_bookings:weekday_bookings),
                               names_to = "Week_Weekend", values_to="Nights_booked") %>%
                  filter(hotel == input$hotel_type4) %>%
                  ggplot(., aes(fill=Week_Weekend, y=log(Nights_booked),
                                x=is_repeated_guest, label = Nights_booked)) +
                  geom_bar(position="dodge2", stat="identity") + facet_grid(. ~ hotel) +
                  geom_text(size = 6, position = position_dodge2(0.9), vjust = 1.8, 
                            colour = "blue", fontface = "bold") +
                  scale_fill_brewer(palette="Set3")+
                  labs(title ="Booking Counts by Repeat/Non-Repeat guests",
                       x = "Repeat/Non-Repeat Guest",
                       y = "Nights Booked (log scale)") +
                  theme(plot.title = element_text(hjust = 0.5),
                        panel.grid.major.x = element_blank(),
                        legend.title = element_blank())})
  
  
  #===============================================================================================#
                              # Monthly Cancellations and ADR
  #===============================================================================================#
  
  output$monthly_adr <- renderPlot({
    
    # filtered_df2 <- cancel_df
    
    if (input$hotel_dist2 == "Direct"){
      filtered_df2 <- hotels_df %>%
                      filter(distribution_channel == "Direct")
    }
    else{
      filtered_df2 <- hotels_df %>%
                      filter(distribution_channel != "Direct")      
    }
    
    filtered_df2 %>%
                    select(hotel, is_canceled, 
                           arrival_date_year, 
                           arrival_date_month, adr) %>%
                    filter(hotel == input$hotel_type5
                           & arrival_date_year == 2016
                           & is_canceled == 1) %>%
                    group_by(arrival_date_year, arrival_date_month) %>%
                    summarise(cancellations_by_month = n(), avg_adr_by_month = round(mean(adr), 2)) %>%
                    arrange(desc(cancellations_by_month)) %>%
                    pivot_longer(c(cancellations_by_month:avg_adr_by_month),
                                 names_to = "Monthly_Values", values_to="Total_Booking_Average_ADR") %>%
                    ggplot(., aes(y=fct_reorder(arrival_date_month,
                                                log(Total_Booking_Average_ADR)), 
                                  x=log(Total_Booking_Average_ADR),
                                  fill= Monthly_Values,
                                  label=Total_Booking_Average_ADR)) +
                    geom_bar(position="dodge2", stat="identity") +
                    scale_fill_manual(values=c("turquoise4","olivedrab4")) +
                    geom_text(size = 4.5, position = position_dodge2(0.9), vjust = 0.5, 
                              hjust = 1.3, colour = "white", fontface = "bold") +
                    labs(title ="City Hotel (direct) - Number of cancellations & Average ADR by Month",
                         x = "Number of Cancellations and Average ADR", y = "Months") +
                    theme(plot.title = element_text(hjust = 0.5), legend.title = element_blank())})
  
  
  #===============================================================================================#
                                          # Conclusion
  #===============================================================================================#
  
  output$conclu <- renderImage({
    
    filename <- normalizePath(file.path('./www',
                                        paste('image2', '.png', sep='')))
    
    list(src = filename)
  }, deleteFile = FALSE)
  
  
}
