# Finding spatial trends.

subway_beach_bike_stations <- c("Coxwell Ave /  Lake Shore Blvd E",
                                "Woodbine Ave / Lake Shore Blvd E")

# Spatial plot of where trips to the Beach STARTED:
all_trips_to_beach$Start.Station.Name <- iconv(
  all_trips_to_beach$Start.Station.Name,
  from = "",
  to   = "UTF-8",
  sub  = "?"
)

start_stations_to_beach <- all_trips_to_beach %>%
  filter(!is.na(Start.Station.Name),
         Start.Station.Name != "",
         Start.Station.Name != "NULL") %>%
  distinct(Start.Station.Name) %>%
  rename(start_station = Start.Station.Name)

start_stations_to_beach_geo <- start_stations_to_beach %>%
  geocode(address = start_station,
          method = "osm",
          long = longitude,
          lat = latitude) %>%
  filter(!is.na(longitude) & !is.na(latitude))

start_stations_to_beach_coord <- st_as_sf(start_stations_to_beach_geo,
  coords = c("longitude", "latitude"),
  crs = 4326
)

start_station_counts <- all_trips_to_beach %>%
  filter(!is.na(Start.Station.Name),
         Start.Station.Name != "",
         Start.Station.Name != "NULL") %>%
  group_by(Start.Station.Name) %>%
  summarise(trip_count = n())

start_stations_to_beach_coord <- start_stations_to_beach_coord %>%
  distinct(start_station, .keep_all = TRUE) %>%
  left_join(start_station_counts, by = c("start_station" = "Start.Station.Name")
  )

start_stations_to_beach_coord <- start_stations_to_beach_coord %>%
  filter(
    st_coordinates(.)[, 1] > -80,
    st_coordinates(.)[, 1] < -78,
    st_coordinates(.)[, 2] > 43,
    st_coordinates(.)[, 2] < 44
  )

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = start_stations_to_beach_coord$trip_count,
  na.color = "gray"
)

leaflet(start_stations_to_beach_coord) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(
    popup = ~paste0("<b>", start_station, "</b><br>Trips: ", trip_count),
    color = ~pal(trip_count),
    radius = ~pmax(3, log(trip_count + 1) * 2),
    fillOpacity = 0.9,
    stroke = FALSE
  ) %>%
  addCircleMarkers(
    data = subset(start_stations_to_beach_coord,
                  start_station %in% subway_beach_bike_stations),
    radius = ~pmax(3, log(trip_count + 1) * 2) + 3,
    fillOpacity = 0,
    color = "blue",
    weight = 3
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~trip_count,
    title = "Number of Trips"
  ) %>%
  addLegend(
    position = "bottomright",
    colors = "blue",
    labels = "Subway Adjacent Stations",
    opacity = 1,
    title = NULL
  )

# Spatial plot of where trips from the Beach ENDED:
all_trips_from_beach$End.Station.Name <- iconv(
  all_trips_from_beach$End.Station.Name,
  from = "",
  to   = "UTF-8",
  sub  = "?"
)

end_stations_from_beach <- all_trips_from_beach %>%
  filter(!is.na(End.Station.Name),
         End.Station.Name != "",
         End.Station.Name != "NULL") %>%
  distinct(End.Station.Name) %>%
  rename(end_station = End.Station.Name)

end_stations_from_beach_geo <- end_stations_from_beach %>%
  geocode(address = end_station,
          method = "osm",
          long = longitude,
          lat = latitude) %>%
  filter(!is.na(longitude) & !is.na(latitude))

end_stations_from_beach_coord <- st_as_sf(end_stations_from_beach_geo,
  coords = c("longitude", "latitude"),
  crs = 4326
)

end_station_counts <- all_trips_from_beach %>%
  filter(!is.na(End.Station.Name),
         End.Station.Name != "",
         End.Station.Name != "NULL") %>%
  group_by(End.Station.Name) %>%
  summarise(trip_count = n())

end_stations_from_beach_coord <- end_stations_from_beach_coord %>%
  distinct(end_station, .keep_all = TRUE) %>%
  left_join(end_station_counts, by = c("end_station" = "End.Station.Name"))

end_stations_from_beach_coord <- end_stations_from_beach_coord %>%
  filter(
    st_coordinates(.)[, 1] > -80,
    st_coordinates(.)[, 1] < -78,
    st_coordinates(.)[, 2] > 43,
    st_coordinates(.)[, 2] < 44
  )
end_stations_from_beach_coord <- na.omit(end_stations_from_beach_coord)

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = end_stations_from_beach_coord$trip_count,
  na.color = "gray"
)

leaflet(end_stations_from_beach_coord) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(
    popup = ~paste0("<b>", end_station, "</b><br>Trips: ", trip_count),
    color = ~pal(trip_count),
    radius = ~pmax(3, log(trip_count + 1) * 2),
    fillOpacity = 0.9,
    stroke = FALSE
  ) %>%
  addCircleMarkers(
    data = subset(end_stations_from_beach_coord,
                  end_station %in% subway_beach_bike_stations),
    radius = ~pmax(3, log(trip_count + 1) * 2) + 3,
    fillOpacity = 0,
    color = "blue",
    weight = 3
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~trip_count,
    title = "Number of Trips"
  )  %>%
  addLegend(
    position = "bottomright",
    colors = "blue",
    labels = "Subway Adjacent Stations",
    opacity = 1,
    title = NULL
  )
