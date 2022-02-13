
hotels_df = read.csv('./Data/hotels_df.csv', stringsAsFactors = TRUE)

hotels_df$reservation_status_date = as.Date(hotels_df$reservation_status_date,
                                            format="%Y-%m-%d")

cancel_df = read.csv('./Data/cancel_df.csv', stringsAsFactors = TRUE)

repeat_df = read.csv('./Data/repeat_df.csv', stringsAsFactors = TRUE)