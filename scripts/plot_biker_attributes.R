# Finding biker attribute trends.

# Bike membership pie chart:
user_breakdown <- all_trips_to_beach %>%
  count(User.Type) %>%
  mutate(prop = n / sum(n) * 100)

ggplot(user_breakdown, aes(x = "", y = prop, fill = User.Type)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "Distribution of User Types") +
  geom_text(aes(label = paste0(round(prop, 1), "%")),
            position = position_stack(vjust = 0.5),
            size = 4) +
  scale_fill_manual(values = c("#a6cee3", "#fbb4ae")
  ) +
  theme(text = element_text(family = "Georgia"))

# Trip duration histogram:
ggplot(all_trips_to_beach, aes(x = Trip..Duration)) +
  geom_histogram(binwidth = 100, fill = "#a6cee3", color = "white") +
  coord_cartesian(xlim = c(0, 8000)) +
  labs(
    title = "Distribution of Trip Durations",
    x = "Trip Duration (Seconds)",
    y = "Number of Trips"
  ) +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(
    text = element_text(family = "Georgia"),
    plot.title = element_text(size = 18),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )
