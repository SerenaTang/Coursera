Getting and Cleaning Data Course Project
==================================================================

Overview
-------------------
The purpose of this project is to demonstrate one's ability to collect, work with, and clean a data set, using data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at [UCI Machine Learning Repository].(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

This repo contains the following files:
-------------------
- 'README.md'
- 'CodeBook.md'
- 'run_analysis.R'
- 'dataNew.txt'

How to perform data transformation to get to tidy data set
-------------------
1. Download and unzip the data set from at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Run the script `run_analysis.R` which does the following:
        * Merges the training and the test sets to create one data set.
        * Extracts only the measurements on the mean and standard deviation for each measurement.
        * Uses descriptive activity names to name the activities in the data set
        * Appropriately labels the data set with descriptive variable names.
        * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        * Writes the new tidy data set to `dataNew.txt`

Additional information
-------------------
Requires `dplyr` package.