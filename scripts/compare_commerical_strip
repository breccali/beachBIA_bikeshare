# Finding the proportion of Bike Trips within the Commercial Strip.

commercial_beach_bike_stations <- c("Hubbard Blvd / Balsam Av",
                                    "Hubbard Blvd. / Glen Manor Dr",
                                    "Queen St. E / Eastern Ave",
                                    "Queen St. E / Spruce Hill Rd",
                                    "Queen St E / Hammersmith Ave",
                                    "Queen St. E / Spruce Hill Rd.")

all_beach_trips <- bind_rows(all_trips_from_beach, all_trips_to_beach)

commercial_beach_trips <- all_beach_trips %>%
  filter(
    Start.Station.Name %in% commercial_beach_bike_stations &
      End.Station.Name %in% commercial_beach_bike_stations
  )
prop_commercial_trips <- nrow(commercial_beach_trips) / nrow(all_beach_trips)
prop_commercial_trips
