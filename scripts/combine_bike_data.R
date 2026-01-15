# Creating two datasets: one of bike trips FROM the Beaches and the other of
# bike trips TO the Beaches.

# Combining monthly datasets into yearly datasets:

# 2021
bikeshare_2021 <- list.files(pattern = "BikeShare_2021")
bikeshare_2021 <- lapply(bikeshare_2021, read.csv)

bikeshare_2021 <- lapply(bikeshare_2021, function(df) {
  df$Start.Station.Id <- suppressWarnings(
    as.integer(as.character(df$Start.Station.Id))
  )
  df$End.Station.Id <- suppressWarnings(
    as.integer(as.character(df$End.Station.Id))
  )
  df$Bike.Id <- suppressWarnings(
    as.integer(as.character(df$Bike.Id))
  )
  df
})

bikeshare_2021 <- dplyr::bind_rows(bikeshare_2021) %>%
  select(
    Trip..Duration,
    Start.Station.Name,
    End.Station.Name,
    User.Type,
    Start.Time
  ) %>%
  na.omit()

trips_to_beach_2021 <- bikeshare_2021 %>%
  filter(End.Station.Name %in% beach_bike_stations)

trips_from_beach_2021 <- bikeshare_2021 %>%
  filter(Start.Station.Name %in% beach_bike_stations)

# 2022
bikeshare_2022 <- list.files(pattern = "BikeShare_2022")
bikeshare_2022 <- lapply(bikeshare_2022, read.csv)

bikeshare_2022 <- lapply(bikeshare_2022, function(df) {
  df$Start.Station.Id <- suppressWarnings(
    as.integer(as.character(df$Start.Station.Id))
  )
  df$End.Station.Id <- suppressWarnings(
    as.integer(as.character(df$End.Station.Id))
  )
  df$Bike.Id <- suppressWarnings(
    as.integer(as.character(df$Bike.Id))
  )
  df
})

bikeshare_2022 <- dplyr::bind_rows(bikeshare_2022) %>%
  select(
    Trip..Duration,
    Start.Station.Name,
    End.Station.Name,
    User.Type,
    Start.Time
  ) %>%
  na.omit()

trips_to_beach_2022 <- bikeshare_2022 %>%
  filter(End.Station.Name %in% beach_bike_stations)

trips_from_beach_2022 <- bikeshare_2022 %>%
  filter(Start.Station.Name %in% beach_bike_stations)

# 2023
bikeshare_2023 <- list.files(pattern = "BikeShare_2023")
bikeshare_2023 <- lapply(bikeshare_2023, read.csv)

bikeshare_2023 <- lapply(bikeshare_2023, function(df) {
  df$Start.Station.Id <- suppressWarnings(
    as.integer(as.character(df$Start.Station.Id))
  )
  df$End.Station.Id <- suppressWarnings(
    as.integer(as.character(df$End.Station.Id))
  )
  df$Bike.Id <- suppressWarnings(
    as.integer(as.character(df$Bike.Id))
  )
  df
})

bikeshare_2023 <- dplyr::bind_rows(bikeshare_2023) %>%
  select(
    Trip..Duration,
    Start.Station.Name,
    End.Station.Name,
    User.Type,
    Start.Time
  ) %>%
  na.omit()

trips_to_beach_2023 <- bikeshare_2023 %>%
  filter(End.Station.Name %in% beach_bike_stations)

trips_from_beach_2023 <- bikeshare_2023 %>%
  filter(Start.Station.Name %in% beach_bike_stations)

# 2024
bikeshare_2024 <- list.files(pattern = "BikeShare_2024")
bikeshare_2024 <- lapply(bikeshare_2024, read.csv)

bikeshare_2024 <- lapply(bikeshare_2024, function(df) {
  df$Start.Station.Id <- suppressWarnings(
    as.integer(as.character(df$Start.Station.Id))
  )
  df$End.Station.Id <- suppressWarnings(
    as.integer(as.character(df$End.Station.Id))
  )
  df$Bike.Id <- suppressWarnings(
    as.integer(as.character(df$Bike.Id))
  )
  df
})

bikeshare_2024 <- dplyr::bind_rows(bikeshare_2024) %>%
  select(
    Trip..Duration,
    Start.Station.Name,
    End.Station.Name,
    User.Type,
    Start.Time
  ) %>%
  na.omit()

trips_to_beach_2024 <- bikeshare_2024 %>%
  filter(End.Station.Name %in% beach_bike_stations)

trips_from_beach_2024 <- bikeshare_2024 %>%
  filter(Start.Station.Name %in% beach_bike_stations)

# Combining yearly datasets into the two separate datasets
all_trips_to_beach <- bind_rows(trips_to_beach_2021,
                                trips_to_beach_2022,
                                trips_to_beach_2023,
                                trips_to_beach_2024)

all_trips_from_beach <- bind_rows(trips_from_beach_2021,
                                  trips_from_beach_2022,
                                  trips_from_beach_2023,
                                  trips_from_beach_2024)
