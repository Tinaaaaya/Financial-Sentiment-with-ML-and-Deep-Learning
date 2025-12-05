#==================
# Data Cleaning Function
#==================
# Define text cleaning function to preprocess messages
cleanText <- function(text) {
  # Parse HTML and extract plain text
  plain <- tryCatch({
    xml2::read_html(text) %>% xml2::xml_text()
  }, error = function(e) {
    text  # Return original text if error in parsing
  })
  
  # Replace specific characters and URLs
  plain <- str_replace_all(plain, "\\|\\|\\|", " ")  # Replace '|||' with space
  plain <- str_replace_all(plain, "http\\S+", "<URL>")  # Replace URLs
  plain <- str_to_lower(plain)  # Convert text to lowercase
  str_trim(plain)  # Trim leading/trailing whitespace
}

# Apply the cleaning function to the 'Message' column
df <- df %>%
  mutate(Message = sapply(Message, cleanText))

df$sentiment <- as.factor(df$sentiment)  # Convert sentiment to factor
