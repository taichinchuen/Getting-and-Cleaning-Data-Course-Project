# Getting-and-Cleaning-Data-Course-Project

The purpose of this project is to demonstrate the process of getting and cleaning a data set. The goal is to prepare a tidy data set that can be used for later analysis.

The data adopted in this project represent the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Files
CodeBook.md describes the variables, the data, and any transformations or work that have been performed to clean up the data.

run_analysis.R is the R script that does the following:

* Merges the training and the test sets to create one data set;
* Extracts only the measurements on the mean and standard deviation for each measurement;
* Uses descriptive activity names to name the activities in the data set;
* Appropriately labels the data set with descriptive variable names;
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata.txt is an independent tidy data set with the average of each variable for each activity and each subject.
