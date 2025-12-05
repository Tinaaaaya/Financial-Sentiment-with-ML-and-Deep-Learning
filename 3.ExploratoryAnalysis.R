#==================
# Data Exploration and Visualization
#==================
# Count the number of words in each message
df <- df %>%
  mutate(word_count = str_count(Message, "\\w+"))

# Plot the density curve of word counts by sentiment
ggplot(df, aes(x = word_count, fill = sentiment)) +
  geom_density(alpha = 0.6) +
  labs(title = "Density of Word Counts by Sentiment", x = "Word Count", y = "Density") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")
