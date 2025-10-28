# Crime Data Analysis 

This project analyzes crime data from 2010 to 2019 using machine learning techniques to predict violent crimes based on various features such as victim demographics, location characteristics, and time of occurrence.

## Project Overview

The project implements a logistic regression model to predict whether a crime is violent based on multiple features including:
- Victim's age
- Time of occurrence
- Location (latitude and longitude)
- Victim's race/ethnicity
- Premise type (e.g., alley, apartment, business, educational location, etc.)

## Features

The model includes various binary features for:
- Different premises (15+ location types)
- Victim's race/ethnicity (White, Black, Hispanic, Other)
- Violent crime classification
- Geographic coordinates

## Data Processing

1. Data cleaning:
   - Removal of records with age = 0
   - Filtering specific crime codes (944, 954)
   - Filtering specific premise codes (601, 750, 803)
   - Random sampling of 2,500 records for analysis

2. Feature engineering:
   - Creation of binary indicators for different premises
   - Encoding of victim race/ethnicity
   - Classification of violent crimes based on crime codes

## Model Implementation

The project uses logistic regression (`glm` with binomial family) to predict violent crimes. The implementation includes:
- Training/testing split (80/20)
- 10-fold cross-validation
- Mean Square Error (MSE) calculation
- Root Mean Square Error (RMSE) reporting

## Requirements

To run this project, you need:
- R programming environment
- Required R packages:
  - base R statistical functions
  - CSV file reading capabilities

## Usage

1. Ensure your crime data CSV file is properly formatted and accessible
2. Update the file path in the script to point to your data file
3. Run the R script to:
   - Load and process the data
   - Train the model
   - Evaluate the model's performance

## Model Evaluation

The model's performance is evaluated using:
- Cross-validation with 10 iterations
- RMSE (Root Mean Square Error) calculation for each iteration
- Average RMSE across all iterations

## Contributors

Bao Khoi Bui, 
Sally Alakeel, 
Max Ouellette, 
Gabriel Mena, 
Luis Waldo
