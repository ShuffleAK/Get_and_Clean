The purpose of this project is to prepare tidy data that can be used for later analysis.  
The dataset used in this project is derived from accelerometer readings from the Samsung Galaxy S smartphone and relates to human activity recognition.
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 

Here are the data for the project:

 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
This repository contains the script run_analysis.R, which performs data cleaning and manipulation to fulfill the project requirements.

The run_analysis.R script performs the following operations:

Merges Training and Test Sets: Combines the training and test datasets to create a single dataset.
Extracts Relevant Measurements: Filters the combined dataset to retain only the measurements on the mean and standard deviation for each measurement.
Descriptive Activity Names: Uses descriptive activity names to label the activities present in the dataset.
Descriptive Variable Names: Appropriately labels the dataset with descriptive variable names.
Creates a Tidy Dataset: Generates a second independent tidy dataset containing the average of each variable for each activity and subject.
