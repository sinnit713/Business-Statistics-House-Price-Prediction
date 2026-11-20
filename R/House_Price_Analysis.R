# Load libraries
library(readr)
library(dplyr)
library(e1071)

# Load dataset
data <- read_csv("House_Prices.csv")

# Some code structures and syntax guidance were adapted with the help
# of ChatGPT for learning and debugging purposes. The code was modified,
# applied, and interpreted independently for this assignment.

# TASK 1: Descriptive Statistics
# View structure
str(data)

# View Dimensions
dim(data)

# summary statistics for all variables
summary(data)

# standard deviation anf Inter Quartile Range
sd(data$price)
IQR(data$price)

# Measure skewness of house prices
skewness(data$price)

# Selected numeric variables
num_vars <- data %>%
  select(price, bedrooms, bathrooms, living_area_sqft,
         lot_area_sqft, grade, condition, year_built)

summary(num_vars)

# standard deviations of num_vars
sapply(num_vars, sd, na.rm = TRUE)

# Categorical summaries
table(data$waterfront)
prop.table(table(data$waterfront)) * 100

table(data$view)
prop.table(table(data$view)) * 100

table(data$zipcode)



# TASK 2: Data Formatting & Quality Checks

# 1. Checking missing values in each variable
colSums(is.na(data))

# 2. Checking duplicate property IDs
sum(duplicated(data$id))

# 3. Converting variables to appropriate formats
data$waterfront <- as.factor(data$waterfront)   # 0 = No, 1 = Yes
data$view <- as.factor(data$view)               # View rating categories
data$condition <- as.factor(data$condition)     # Condition categories
data$zipcode <- as.factor(data$zipcode)         # Postal code categories

# 4. Creating renovation indicator
# year_renovated = 0 means never renovated
data$renovated <- ifelse(data$year_renovated == 0, 0, 1)
data$renovated <- as.factor(data$renovated)

# 5. Verifying updated structure
str(data)

# 6. Reviewing suspicious and extreme values
summary(data$bedrooms)
summary(data$lot_area_sqft)
summary(data$price)

# Reviewing renovation status
table(data$renovated)
prop.table(table(data$renovated)) * 100

# Summary of renovation years only
summary(data$year_renovated[data$year_renovated > 0])


# TASK 4: Visualisations using ggplot2
library(ggplot2)

# 1. Distribution of House Prices
ggplot(data, aes(x = price)) +
  geom_histogram(fill = "skyblue", color = "black", bins = 30) +
  labs(
    title = "Distribution of House Prices",
    x = "Sale Price (INR)",
    y = "Frequency"
  ) +
  theme_minimal()


# 2. Price vs Living Area
ggplot(data, aes(x = living_area_sqft, y = price)) +
  geom_point(color = "blue", alpha = 0.4) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "Price vs Living Area",
    x = "Living Area (sq ft)",
    y = "Sale Price (INR)"
  ) +
  theme_minimal()

# 3. Average House Price by Grade
data %>%
  group_by(grade) %>%
  summarise(avg_price = mean(price)) %>%
  ggplot(aes(x = factor(grade), y = avg_price)) +
  geom_col(fill = "darkgreen") +
  labs(
    title = "Average House Price by Grade",
    x = "Grade",
    y = "Average Price (INR)"
  ) +
  theme_minimal()

# 4. House Price by View Rating
ggplot(data, aes(x = view, y = price)) +
  geom_boxplot(fill = "orange") +
  labs(
    title = "House Prices by View Rating",
    x = "View Rating",
    y = "Sale Price (INR)"
  ) +
  theme_minimal()

# 5. Price vs Distance from Airport
ggplot(data, aes(x = distance_airport, y = price)) +
  geom_point(color = "grey", alpha = 0.4) +
  geom_smooth(method = "lm", color = "purple", se = FALSE) +
  labs(
    title = "Price vs Distance from Airport",
    x = "Distance from Airport",
    y = "Sale Price (INR)"
  ) +
  theme_minimal()


# TASK 5: Measures of Association
# 1. Living area vs Price (Pearson)
cor.test(data$living_area_sqft, data$price, method = "pearson")

# 2. Grade vs Price (Spearman)
cor.test(data$grade, data$price, method = "spearman")

# 3. View vs Price (Spearman)
cor.test(as.numeric(data$view), data$price, method = "spearman")

# 4. Schools Nearby vs Price (Spearman)
cor.test(data$schools_nearby, data$price, method = "spearman")

# 5. Distance Airport vs Price (Pearson)
cor.test(data$distance_airport, data$price, method = "pearson")


# TASK 6: Train-Test Split
# Set seed using student number
set.seed(40524741)

# Create random sample index (70% training data)
train_index <- sample(1:nrow(data), 0.7 * nrow(data))

# Split dataset
train_data <- data[train_index, ]
test_data  <- data[-train_index, ]

# Check dimensions
dim(train_data)
dim(test_data)

# TASK 7: Regression Models

# Model 1
model1 <- lm(price ~ living_area_sqft, data = train_data)
summary(model1)

# Model 2
model2 <- lm(price ~ living_area_sqft + grade + view +
               schools_nearby + distance_airport,
             data = train_data)
summary(model2)

# Model 3
model3 <- lm(price ~ living_area_sqft + grade + view +
               year_built,
             data = train_data)
summary(model3)

# TASK 8: Prediction Accuracy
# Predict using final model (Model 3)
predictions <- predict(model3, newdata = test_data)

# Actual values
actual <- test_data$price

# Root Mean Squared Error
root_mean_squared_error <- sqrt(mean((actual - predictions)^2))

# Mean Absolute Error
mean_absolute_error <- mean(abs(actual - predictions))

# Test R-squared
residual_sum_squares  <- sum((actual - predictions)^2)
total_sum_squares <- sum((actual - mean(actual))^2)
test_r_squared <- 1 - (residual_sum_squares /total_sum_squares)

# Results
root_mean_squared_error
mean_absolute_error
test_r_squared

# TASK 9: Comparison of Regression Models

# Generate predictions from all three models
pred_model1 <- predict(model1, newdata = test_data)
pred_model2 <- predict(model2, newdata = test_data)
pred_model3 <- predict(model3, newdata = test_data)

# Function to calculate prediction metrics
calculate_metrics <- function(actual, predicted) {
  rmse <- sqrt(mean((actual - predicted)^2))
  mae <- mean(abs(actual - predicted))
  r_squared <- 1 - sum((actual - predicted)^2) /
    sum((actual - mean(actual))^2)
  
  return(c(RMSE = rmse, MAE = mae, R_squared = r_squared))
}

# Compare all three models
model_comparison <- data.frame(
  Model = c("Model 1", "Model 2", "Model 3"),
  rbind(
    calculate_metrics(test_data$price, pred_model1),
    calculate_metrics(test_data$price, pred_model2),
    calculate_metrics(test_data$price, pred_model3)
  )
)

# Display comparison results
print(model_comparison)
