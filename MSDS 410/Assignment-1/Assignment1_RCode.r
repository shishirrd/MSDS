# Importing libraries for exploratory data analysis (EDA)
library(tidyverse)
library(ggplot2) # Advanced data visualization
library(corrplot) # Correlation visualization
library(moments) # Statistical measure functions

# Reading the Ames housing dataset
# NOTE: update this path to your own working directory before running
setwd("<YOUR_WORKING_DIRECTORY>")
ames_data <- read.csv("ames_housing_data.csv", stringsAsFactors = TRUE)

### Data Survey

## Initial overview
head(ames_data) # what do the first 5 rows look like?
names(ames_data) # what columns exist in the data?
cat("Number of rows:", nrow(ames_data), "Number of columns:", ncol(ames_data)) # What is overall structure like?
sapply(ames_data, class) # What are the data types in the dataset?

# Basic statistical evaluation
summary(ames_data) # What is the mean, median, 1st quartile, 3rd quartile, min, max for each column?
colSums(is.na(ames_data)) # is there any missing data?

cat_vars <- names(ames_data)[sapply(ames_data, is.factor)] # Setting variable for all categorical factors in the data
num_vars <- names(ames_data)[sapply(ames_data, is.numeric)] # Setting variable for all numerical factors in the data

cat("Categorical variables:", length(cat_vars), "\n") # Printing the data
cat("Numerical variables:", length(num_vars), "\n")

## Now that we have a basic understanding of the dataset, let's examine the target "SalePrice"
summary(ames_data$SalePrice) # Same as above but limited to SalePrice
hist(ames_data$SalePrice, main = "Distribution of Sale Prices", xlab = "Sale Price") #Visualizing SalePrice

# "SalePrice" is highly right-skewed (i.e., more homes at lower prices than vice versa). I have elected to log transform the variable to stabilize this variance. This will likely help us meet linear regression assumptions and improve model performance.
ames_data$SalePrice_log <- log(ames_data$SalePrice)
# Calculate and compare skewness for original and log-transformed sale price

# Calculate skewness
original_skewness <- skewness(ames_data$SalePrice)
log_skewness <- skewness(ames_data$SalePrice_log)

# Print skewness comparison
cat("Original SalePrice Skewness:", round(original_skewness, 4), "\n")
cat("Log-transformed SalePrice Skewness:", round(log_skewness, 4), "\n")
cat("Reduction in Skewness (%):", round((100 * abs(original_skewness) - abs(log_skewness))/abs(original_skewness), 2))

# Examining some related variables based on common knowledge
table(ames_data$Neighborhood) # Where were these houses sold?
table(ames_data$SaleCondition) # What was the condition at the time of sale?
table(ames_data$BldgType) # What kind of house was sold?
hist(ames_data$GrLivArea) # How is the living area distributed?

## Assessing suitability for linear regression
# Drop SID and PID as they will not have any impact on sale prices and are part of data recording. Also, we will drop columns "PoolQC", "MiscFeature", and "Fence" as they have 2.4K to 3K missing values each.
ames_data_clean <- ames_data[, !(names(ames_data) %in% c("SID", "PID", "PoolQC", "MiscFeature", "Fence"))]

# Price Distribution
boxplot(ames_data_clean$SalePrice, main = "Sales Price Outlier Analysis") # Checking if the overall home prices are stable enough to predict

# Inter Quartile Range analysis to examine outliers
Q1 <- quantile(ames_data_clean$SalePrice, 0.25)
Q3 <- quantile(ames_data_clean$SalePrice, 0.75)
IQR <- Q3 - Q1
outlier_threshold_low <- Q1 - 3 * IQR
outlier_threshold_high <- Q3 + 3 * IQR
extreme_outliers <- which(ames_data_clean$SalePrice < outlier_threshold_low | 
                         ames_data_clean$SalePrice > outlier_threshold_high)
cat("Extreme price outliers:", length(extreme_outliers), "\n") 
# We have 26 extreme outliers in a ~3K observation dataset. We can proceed with our assessment considering <1% of data points are outliers

## Correlation and R-Squared analysis
# Redefine numeric variables after cleaning
num_vars <- names(ames_data_clean)[sapply(ames_data_clean, is.numeric)]
num_vars <- num_vars[num_vars != "SalePrice"]

# Calculate correlation matrix for numeric variables
correlation_matrix <- cor(ames_data_clean[,num_vars], use="complete.obs")

# Get correlations with SalePrice_log specifically
price_correlations <- correlation_matrix[,"SalePrice_log"]
price_correlations <- sort(price_correlations, decreasing = TRUE)

# Create correlation plot for top 10 correlations with SalePrice_log
top_10_vars <- names(head(price_correlations, 10))
correlation_matrix_top10 <- correlation_matrix[top_10_vars, top_10_vars]
corrplot(correlation_matrix_top10,
         method="color", 
         type="upper",
         tl.col="black",
         tl.srt=45,
         main = "Top 10 Correlations to log(Sale Prices) (Complete Dataset)",
         mar=c(0,0,2,0))

# Calculate R-squared for key numeric variables
r_squared <- sapply(num_vars, function(x) {
  if(x != "SalePrice_log") {
    model <- lm(SalePrice_log ~ get(x), data=ames_data)
    return(summary(model)$r.squared)
  }
})

# Convert r_squared from list to numeric vector before plotting
r_squared <- unlist(r_squared)

# Create barplot of top 10 R-squared values
par(mar=c(10,8,4,2)) # Increased left margin from 4 to 8
r_squared_plot <- head(sort(r_squared, decreasing=TRUE), 10)
bp <- barplot(r_squared_plot, # Take top 10 sorted values
        main="Top 10 R-Squared Values by Variable (Complete Dataset)", 
        las=2, # Rotate labels
        cex.names=0.7, # Reduce label text size
        names.arg=names(r_squared_plot), # Take top 10 names
        col="lightblue",
        border="darkblue", 
        horiz=TRUE,
        xlim=c(0, max(r_squared_plot) + 0.1)) # Extend x-axis limit to fit text

# Add R-squared values as text
text(r_squared_plot, bp,
     labels=sprintf("%.3f", r_squared_plot),
     pos=4, 
     cex=0.7)

# A more detailed examination reveals a significant overlap between the top 10 correlating factors and the top 10 factors by R-squared values. This demonstrates that the "SalePrice" has enough predictability for a linear regression model to be fit across the top 10 factors. However, the top 10 factors may contain outliers that skew the results further. Let's evaluate them further and trim data with abnormal results.
# Creating histogram plots for top 10 variables by R-squared value
top_10_vars_rsq <- names(head(sort(r_squared, decreasing=TRUE), 10))

par(mfrow=c(4,3), mar=c(4,4,2,1))
for(var in top_10_vars_rsq) {
  hist(ames_data_clean[[var]], 
       main=paste("Histogram of", var),
       xlab=var,
       col="lightblue",
       border="darkblue")
}

# Evaluating the categorical variables, I found that 2413 observations of ~3K observations have "SaleCondition" as 'Normal' and are also heavily concentrated towards '1Fam' type houses. We will trim the dataset to these conditions to improve model performance by homogenizing the training data
ames_data_clean_trim <- ames_data_clean[ames_data_clean$SaleCondition == "Normal" & ames_data_clean$BldgType == "1Fam",]
cat("New number of observations:", nrow(ames_data_clean_trim), "\n") # Ensuring data is accurately trimmed

### Problems we can evaluate with the given data.
## Modeling neighborhood changes (certain areas are dependent on school districts, others on proximity to economic centers)
aggregate(SalePrice ~ Neighborhood, data=ames_data_clean_trim, 
          FUN=function(x) c(min=min(x), max=max(x))) %>%
  print()

## Modeling price sensitivity to time of sale (the economy changes over time, and so does the housing market)
aggregate(SalePrice ~ YrSold, data=ames_data_clean_trim, 
          FUN=function(x) c(min=min(x), max=max(x))) %>%
  print()

## Modeling different price segments (starter homes, mid-market, luxury) 
ames_data_clean_trim$PriceSegment <- cut(ames_data_clean_trim$SalePrice,
                                        breaks = quantile(ames_data_clean_trim$SalePrice, 
                                                        probs = c(0, 0.20, 0.80, 1)), # Indicative split
                                        labels = c("Starter", "Mid-Market", "Luxury"),
                                        include.lowest = TRUE)

aggregate(SalePrice ~ PriceSegment, data=ames_data_clean_trim,
          FUN=function(x) c(min=min(x), max=max(x))) %>%
  print()

### Data Quality Checks. This is important to ensure we have the highest possible quality in our modeling data.
top_10_rsq <- names(head(sort(r_squared, decreasing=TRUE), 10))

additional_vars <- c("LotFrontage", "SecondFlrSF", "KitchenAbvGr", "OverallCond", 
                     "BsmtFinSF1", "Fireplaces", "BedroomAbvGr", "MasVnrArea", 
                     "HalfBath", "MoSold")

quality_vars <- unique(c(top_10_rsq, additional_vars))
cat("Selected 20 variables:", paste(quality_vars, collapse=", "), "\n")
cat("Total variables:", length(quality_vars), "\n\n")

# Logical value checks, missing data analysis, and summary statistics (see full notebook for details)

### Initial EDA and Visualization of the trimmed dataset and the top 10 features
continuous_vars <- top_10_rsq[sapply(ames_data_clean_trim[top_10_rsq], function(x) is.numeric(x) && length(unique(x)) > 10)]
discrete_vars <- top_10_rsq[sapply(ames_data_clean_trim[top_10_rsq], function(x) is.numeric(x) && length(unique(x)) <= 10)]

## Continuous Variables vs SalePrice (log transformed) - Scatterplots with LOESS smoothers
if(length(continuous_vars) > 0) {
  par(mfrow=c(2, 4), mar=c(4,4,3,2))
  for(var in continuous_vars) {
    plot(ames_data_clean_trim[[var]], ames_data_clean_trim$SalePrice_log,
         xlab=var, ylab="log(Sale Price)", 
         main=paste("log(Sale Price) vs.", var),
         pch=16, col="steelblue", cex=0.6)
    tryCatch({
      lines(lowess(ames_data_clean_trim[[var]], ames_data_clean_trim$SalePrice_log), 
            col="red", lwd=2)
    }, error=function(e) {})
  }
}

## Discrete Variables vs SalePrice (log transformed) - Boxplots
if(length(discrete_vars) > 0) {
  par(mfrow=c(1,3), mar=c(4,4,3,2))
  for(var in discrete_vars) {
    boxplot(SalePrice_log ~ get(var), data=ames_data_clean_trim,
            xlab=var, ylab="Sale Price (log)",
            main=paste("log(Sale Price) by", var),
            col="lightblue", border="darkblue")
  }
}

## Select the top 3 variables (by RSQ) for detailed analysis
selected_vars <- c("GrLivArea", "OverallQual", "GarageCars")

par(mfrow=c(3,2), mar=c(4,4,3,2))
for(var in selected_vars) {
  if(var == "OverallQual" | var == "GarageCars") {
    boxplot(SalePrice ~ get(var), data=ames_data_clean_trim,
            xlab=var, ylab="Sale Price", main=paste("SalePrice vs", var),
            col="lightblue")
  } else {
    plot(ames_data_clean_trim[[var]], ames_data_clean_trim$SalePrice,
         xlab=var, ylab="Sale Price", main=paste("SalePrice vs", var),
         pch=16, col="steelblue", cex=0.8)
    lines(lowess(ames_data_clean_trim[[var]], ames_data_clean_trim$SalePrice), 
          col="red", lwd=2)
  }
}
