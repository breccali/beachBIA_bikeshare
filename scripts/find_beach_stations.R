# Extracting which bike stops are located in the Beach BIA using a sample from
# January 2023 and February 2023 data.

neighbourhoods <- st_read("Neighbourhoods - 4326.geojson")

bike_data_2023_01 <- read.csv("BikeShare_2023_01.csv")
bike_data_2023_02 <- read.csv("BikeShare_2023_02.csv")

stations_2023_01 <- data.frame(
  start_station = bike_data_2023_01$Start.Station.Name
)
stations_2023_02 <- data.frame(
  start_station = bike_data_2023_02$Start.Station.Name
)

bike_stations <- bind_rows(stations_2023_01,
                           stations_2023_02) %>%
  distinct(start_station)

bike_stations_geo <- bike_stations %>%
  geocode(address = start_station,
          method = "osm",
          long = longitude,
          lat = latitude)
bike_stations_geo <- na.omit(bike_stations_geo)

bike_stations_coordinates <- st_as_sf(
  bike_stations_geo,
  coords = c("longitude", "latitude"),
  crs = 4326
)

beach_bike_stations <- neighbourhoods %>%
  filter(AREA_SHORT_CODE == "063")


beach_bike_stations <- st_join(
  bike_stations_coordinates, beach_bike_stations, join = st_within
)
beach_bike_stations <- beach_bike_stations %>% filter(!is.na(AREA_NAME))
beach_bike_stations <- beach_bike_stations$start_station
