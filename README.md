# Financial Sentiment Analysis with Machine Learning & Deep Learning

A sentiment-analysis task using financial social-media comments.  
The raw data and sentiment coding come from the replication package of:

> Malo, P., Sinha, A., Korhonen, P., Wallenius, J., & Takala, P. (2014).  
> *Good debt or bad debt: Detecting semantic orientations in economic texts.*  
> Journal of the Association for Information Science and Technology, 65(4), 782–796.

For demonstration, only the first 500 observations are used.

The project implements **logistic regression**, **random forest**, and **LSTM (long short-term memory)** models to classify comments into **negative**, **neutral**, and **positive** sentiment categories.  
Model performance is compared using confusion matrices on a held-out testing set.

---

## 1. Package Loading

## 2. Data Loading and Check

The initial data set contains two columns for the message (string) and sentiment (factor) respectively.

## 3. Text Cleaning & Custom Functions

Raw social-media text usually contains:

* URLs

* newline / tab characters

* HTML markup

* inconsistent casing

A custom cleaning function is implemented to standardize the text:

```{r}
cleanText <- function(text){
  plain <- xml2::read_html(text) %>% xml2::xml_text()
  plain <- str_replace_all(plain, "\\n|\\r|\\t", " ")
  plain <- str_replace_all(plain, "http[s]?://\\S+", "")
  plain <- tolower(plain)
  plain <- str_trim(plain)
  return(plain)
}
```
A second custom function produces heatmap-style confusion matrices, providing an interpretable visual comparison between models.

```{r}
plot_confusion_matrix <- function(cm_data, model_name){
  ggplot(cm_data, aes(x = Reference, y = Prediction, fill = Freq)) +
    geom_tile() +
    geom_text(aes(label = Freq), color = "white", size = 5) +
    scale_fill_gradient("Count", low = "lightblue", high = "blue") +
    labs(title = paste("Confusion Matrix -", model_name),
         x = "Actual Class",
         y = "Predicted Class") +
    theme_minimal()
}
```

## 5. Tokenization & TF-IDF

The cleaned text is transformed into numerical form through:

* Tokenization

* Vocabulary building

* Vocabulary pruning (remove rare words)

* Document-term matrix (DTM)

* TF-IDF transformation

```{r}
tokenizer <- text2vec::word_tokenizer
tokens <- tolower(df$message) %>% tokenizer()

vocab <- create_vocabulary(tokens)
vocab <- prune_vocabulary(vocab, term_count_min = 3)

vectorizer <- vocab_vectorizer(vocab)
dtm_train <- create_dtm(tokens, vectorizer)
dtm_train_tfidf <- tfidf_transform(dtm_train)
```

## 6. Managing Mixed Data Types

To demonstrate handling numeric + factor + text variables, an additional feature is created:

* word_count — number of words per comment

```{r}
df <- df %>%
  mutate(word_count = str_count(message, "\\w+"))
head(df)
```

## 7. Data Visualization
![Data Visualization](Data%20Visualization.png)

![Data Visualization](Data%20Visualization.png)
