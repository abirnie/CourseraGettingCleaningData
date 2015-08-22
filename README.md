
# Coursera Getting & Cleaning Data Course Project

The main directory of this repo contains the R script run_analysis.R that is meant to work with data from the Human Activity Recognition Using Smartphones Dataset that can be downloaded here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the full dataset can be found here: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The script can be run as long as the data is in your working directory.

Sourcing the script — i.e., `source("run_analysis.R")` — will initiate the script. No further action is necessary.

## How run_analysis.R works

The goal of the script is to produce a tidy data set of the measures for means and standard deviations in the full data set. The output is .txt file that contains the means of the means and standard deviations for each measure for each activity for each subject. 

The script does this according to the following steps [Note to peer graders: these steps are arranged slightly differently than the suggested steps in the assignment. My aim was to streamline the process as much as possible, which will be explained below.]

**1. Merges the training and the test sets to create one data set:** This is acheived by getting lists of the names of the test files and the training files. Test files and training files are then combined into separate data frames (due to differences in data frame row dimensions), and then combined into a single data frame for subsequent manipulation.

**2. Labels the data set with descriptive variable names:** The variable names are then read into R from the features.txt file and are applied to the data frame column names from step 1 above. Column names for "subjects" and "activity" are also added. This was done immediately after creating the data frame in order acheive the next step — extracting means and standard deviations — by selecting only the column names that contained "mean" and "std" (as well as "subject" and "activity").

**3. Extracts only the measurements on the mean and standard deviation for each measurement:** After naming all of the columns in the dataframe, the script then extracts only the measures on the means and standard deviations from the data set using the `select()` function in the dplyr package. 

**4. Uses descriptive activity names to name the activities in the data set** Numeric codes for the activity names are then replaced with descriptive acitivty names, like so: `data$activity[data$activity == 1] <- "WALKING"`

**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:** A new tidy dataframe is created using `group_by` and `summarise_each` functions that are part of the dplyr package: `tidy_data <- data %>% group_by (subject, activity) %>% summarise_each(funs(mean))`

Data are then saved to a file, "tidy_data.txt", that is saved to the working directory using `write.table`.
