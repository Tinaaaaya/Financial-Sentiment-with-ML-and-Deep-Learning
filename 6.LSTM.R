#==================
# Train LSTM Model using H2O
#==================
h2o.init()

# Convert to H2OFrame for training
train_h2o <- as.h2o(cbind(as.data.frame(X_train), as.factor(y_train)))
colnames(train_h2o) <- c(paste0("V", 1:ncol(X_train)), "sentiment")

# Set response and predictor columns
response <- "sentiment"
predictors <- colnames(train_h2o)[1:(ncol(train_h2o) - 1)]

# Train LSTM Model
lstm_model <- h2o.deeplearning(
  x = predictors,  # Predictor columns
  y = response,    # Response column
  training_frame = train_h2o,
  activation = "Tanh",
  hidden = c(128, 64),  # Number of LSTM units in the hidden layers
  epochs = 10,         # Number of epochs
  l1 = 0.01,           # Regularization parameter 
  l2 = 0.01            # Regularization parameter 
)

# View LSTM model summary
summary(lstm_model)

# Convert test data to H2OFrame
test_h2o <- as.h2o(cbind(as.data.frame(X_test), as.factor(y_test)))
colnames(test_h2o) <- c(paste0("V", 1:ncol(X_test)), "sentiment")

# Predict with LSTM model
predictions <- h2o.predict(lstm_model, test_h2o)

# Convert predictions to dataframe
predicted_sentiment <- as.data.frame(predictions)$predict

# Evaluate LSTM model using confusion matrix
confusionMatrix(predicted_sentiment, as.factor(y_test))  # Confusion matrix for LSTM model