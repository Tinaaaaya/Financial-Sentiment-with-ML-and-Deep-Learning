#==================
# Performance Comparison for the Three Models
#==================
# Compare confusion matrices and metrics for Logistic Regression, Random Forest, and LSTM

# For logistic regression (model_lr)
lr_pred <- predict(model_lr, as.matrix(dtm_test_tfidf))
lr_cm <- confusionMatrix(lr_pred, test$sentiment)

# For Random Forest (rf_model)
rf_cm <- confusionMatrix(pred_rf, y_test)

# For LSTM (lstm_model)
lstm_cm <- confusionMatrix(predicted_sentiment, as.factor(y_test))

# Print confusion matrices
print("Logistic Regression Confusion Matrix:")
print(lr_cm)

print("Random Forest Confusion Matrix:")
print(rf_cm)

print("LSTM Confusion Matrix:")
print(lstm_cm)

#==================
# Visualize Confusion Matrices
#==================

lr_cm_matrix <- as.data.frame(lr_cm$table)
rf_cm_matrix <- as.data.frame(rf_cm$table)
lstm_cm_matrix <- as.data.frame(lstm_cm$table)

# Create a function for plotting heatmaps
plot_confusion_matrix <- function(cm_data, model_name) {
  ggplot(cm_data, aes(x = Reference, y = Prediction, fill = Freq)) +
    geom_tile() +
    geom_text(aes(label = Freq), color = "black", size = 5) +
    scale_fill_gradient(low = "white", high = "blue") +
    labs(title = paste("Confusion Matrix -", model_name),
         x = "Actual Class", y = "Predicted Class") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

lr_cm_plot <- plot_confusion_matrix(lr_cm_matrix, "Logistic Regression")
rf_cm_plot <- plot_confusion_matrix(rf_cm_matrix, "Random Forest")
lstm_cm_plot <- plot_confusion_matrix(lstm_cm_matrix, "LSTM")

# Display all heatmaps together (side by side)

grid.arrange(lr_cm_plot, rf_cm_plot, lstm_cm_plot, ncol = 3)
