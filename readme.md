## Getting and Cleaning Data - Course Project
### This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

* Download the dataset if it does not already exist in the working directory
* Load the activity and feature info
* Loads both the training and test datasets
* Merges the two datasets
* Loads only mean and std variables from merge dataset
* Create readable activities and variable names
* Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt.