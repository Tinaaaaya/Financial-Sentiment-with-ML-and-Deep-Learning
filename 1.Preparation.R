#==================
# Load Required Libraries
#==================
# Libraries for data processing and machine learning
library(readr)        # Reading CSV files
library(dplyr)        # Data manipulation
library(stringr)      # String manipulation
library(ggplot2)      # Visualization
library(tokenizers)   # Tokenization
library(text2vec)     # Text processing and vectorization
library(caret)        # Data partition and model training
library(randomForest) # Random Forest for traditional ML
library(h2o)          # H2O for LSTM
library(gridExtra)    # For plot arrangement

#==================
# Data Import & Preprocessing
#==================
# Import data from CSV file
df <- read_csv("RawData.csv")
head(df)

# Reset row index
df <- df %>% 
  mutate(id = row_number()) %>%   
  select(-id)   

# Count sentiment categories
cnt_pro <- df %>% 
  count(sentiment)

# Visualize sentiment distribution with a bar plot
ggplot(cnt_pro, aes(x = sentiment, y = n, fill = sentiment)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  labs(x = "Sentiment", y = "Number of Occurrences") +
  scale_fill_brewer(palette = "Pastel1") +  # Light pastel color palette
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "none")  # Remove legend for a cleaner look
