# MSDS 410 — Assignment 1: Exploratory Data Analysis (Ames Housing)

## What it does
Exploratory data analysis on the Ames, Iowa housing dataset in preparation for linear
regression modeling. Assesses data suitability, cleans/trims the dataset (dropping
low-fidelity columns, filtering to "Normal" sale condition / single-family homes), evaluates
skewness of the SalePrice target and applies a log transform, runs correlation and R-squared
analysis to rank predictive variables, and performs data quality checks (logical value
checks, missing data analysis, outlier detection) before final EDA visualization.

## Techniques/libraries used
- R: `tidyverse`, `ggplot2`, `corrplot`, `moments`
- Skewness measurement and log transformation
- Correlation matrix + per-variable simple linear regression R-squared ranking
- IQR-based outlier detection, waterfall sample-size tracking

## Data note
Ran against the Ames Housing dataset (`ames_housing_data.csv`) — not included (large
dataset file, course-provided). Path is set via `setwd()` — update to your own working
directory before running.
