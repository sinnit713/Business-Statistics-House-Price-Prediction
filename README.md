# Business-Statistics-House-Price-Prediction
Statistical analysis and house price prediction using R, exploratory data analysis, correlation analysis and multiple linear regression.

# House Price Analysis and Prediction Using R

## Project Overview

This project examines the relationship between residential property characteristics and house sale prices using statistical analysis and multiple linear regression in R.

The analysis uses the `House_Prices.csv` dataset, containing **14,619 observations and 20 variables**. It explores how property characteristics, such as living area, grade, view rating, nearby schools and distance from the airport, relate to house prices.

## Project Objectives

- Explore the dataset using descriptive statistics.
- Check data structure, formatting and quality.
- Examine relationships between selected property characteristics and sale prices.
- Create visualisations using `ggplot2`.
- Measure associations using Pearson and Spearman correlation.
- Develop and compare multiple linear regression models.
- Evaluate predictive performance using a test dataset.

## Dataset

The dataset contains residential property information, including:

- Property characteristics: bedrooms, bathrooms, living area and lot area.
- Property quality: grade and condition.
- Location-related information: waterfront, view, zipcode, nearby schools and distance from the airport.
- Property history: year built and year renovated.
- Target variable: `price` (sale price in INR).

## Tools and Technologies

- **R** – Statistical analysis and modelling
- **RStudio** – Development environment
- **readr** – Dataset import
- **dplyr** – Data manipulation
- **e1071** – Skewness calculation
- **ggplot2** – Data visualisation

## Analysis Workflow

## Model Performance

The third multiple linear regression model was used to generate predictions on the test dataset.

| Evaluation Metric | Result |
|---|---:|
| Root Mean Squared Error (RMSE) | 211,618.40 |
| Mean Absolute Error (MAE) | 137,936.30 |
| Test R-squared | 0.6675 (66.75%) |

### Interpretation

The model explains approximately 66.75% of the variation in house prices in the test dataset. The MAE indicates an average absolute prediction error of approximately INR 137,936, while the RMSE is approximately INR 211,618.

1. **Descriptive Statistics:** Examining dataset structure, summary statistics, standard deviation, interquartile range and skewness.
2. **Data Quality Checks:** Checking missing values and duplicate property IDs, formatting categorical variables and creating a renovation indicator.
3. **Data Visualisation:** Producing five visualisations to explore house price distributions and relationships.
4. **Correlation Analysis:** Applying Pearson and Spearman correlation tests to selected variables.
5. **Train-Test Split:** Dividing the dataset into 70% training data and 30% test data, using the student number as the random seed.
6. **Regression Modelling:** Developing three multiple linear regression models with different combinations of explanatory variables.
7. **Model Evaluation:** Assessing predictions using RMSE, MAE and test R-squared.

## Visualisations

The analysis includes five visualisations:

### 1. Distribution of House Prices
![Distribution of House Prices](visualisations/Distribution%20of%20House%20Prices.png)

### 2. Price vs Living Area
![Price vs Living Area](visualisations/Price%20vs%20Living%20Ares.png)

### 3. Average House Price by Grade
![Average House Price by Grade](visualisations/Avg%20House%20Price%20By%20Grade.png)

### 4. House Prices by View Rating
![House Prices by View Rating](visualisations/House%20Price%20By%20view%20Rating.png)

### 5. Price vs Distance from Airport
![Price vs Distance from Airport](visualisations/Price%20Vs%20Distance%20from%20Airport.png)

## Repository Structure

```text
business-statistics-house-price-prediction/
│
├── R/
│   └── House_Price_Analysis.R
│
├── House_Prices.csv
├── README.md
└── .gitignore
```

## How to Run the Project

1. Clone or download this repository.
2. Open the project directory in RStudio.
3. Install the required R packages if they are not already installed.
4. Open `R/House_Price_Analysis.R`.
5. Run the script with the repository root directory as the working directory.

The dataset should remain in the repository's root directory so that the script can locate it.

## Project Context

This project was completed as part of the Statistics of Business module within the MSc Business Analytics programme at Queen's University Belfast.

The analysis follows the statistical workflow outlined in the individual house price analysis assignment.

## Acknowledgement

The R script includes a disclosure of the use of ChatGPT for limited coding guidance and debugging support, as required by the assignment's academic guidance.
