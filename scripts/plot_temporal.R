# Finding temporal trends.

# Time series plot:
dates_trips_to_beach <- all_trips_to_beach %>%
  select(Start.Time)

dates_trips_to_beach <- dates_trips_to_beach %>%
  mutate(Start.Time = mdy_hm(Start.Time))
num_daily_trips <- dates_trips_to_beach %>%
  mutate(Date = as_date(Start.Time)) %>%
  group_by(Date) %>%
  summarise(trip_count = n())

ggplot(num_daily_trips, aes(x = Date, y = trip_count)) +
  geom_line(color = "steelblue", linewidth = 0.8) +
  coord_cartesian(ylim = c(0, max(num_daily_trips$trip_count) * 1.1)) +
  labs(
    title = "Daily Trips to the Beach (1/21-9/24)",
    x = "Time (Day)",
    y = "Number of Trips per Day"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )

# Hourly Plot:
all_trips_to_beach <- all_trips_to_beach %>%
  mutate(
    Start_Time_trim = trimws(Start.Time),
    Start_Time = case_when(
      as.numeric(sub("^\\d{2}/(\\d{2})/\\d{4}.*", "\\1", Start_Time_trim)) >
        12 ~ mdy_hm(Start_Time_trim),
      TRUE ~ dmy_hm(Start_Time_trim)
    )
  )

hourly_counts <- all_trips_to_beach %>%
  mutate(hour = hour(Start_Time)) %>%
  count(hour)

ggplot(hourly_counts, aes(x = hour, y = n)) +
  geom_col(aes(fill = n)) +
  coord_polar(start = 0 - pi / 24) +
  scale_fill_gradient(
    low = "#B0E0E6",
    high = "#1A237E",
    name = "Number of Trips per Hour"
  ) +
  scale_x_continuous(
    breaks = 0:23,
    labels = c("12 AM", "1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM",
               "8 AM", "9 AM", "10 AM", "11 AM",
               "12 PM", "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM",
               "8 PM", "9 PM", "10 PM", "11 PM")
  ) +
  labs(
    title = "Hourly Distribution of Trips",
    x = "Time of Day",
    y = "Number of Trips per Hour"
  ) +
  theme_minimal(base_size = 14) +
  theme(axis.text.y = element_blank()) +
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )
