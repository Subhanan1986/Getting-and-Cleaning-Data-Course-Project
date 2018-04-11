# CodeBook

This is a code book that describes the variables, the data, and any transformations or work to clean up the data.

## Information

This script will download the file in your working directory.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## 1. Merges the training and the test sets to create one data set.

* subjectData_Train : Data from subject_train.txt (Subject ID -> Train)
* SubjectData_Test : Data from subject_test.txt (Subject ID ->Test
* activityData_Train : Data from Y_train.txt
* activityData_Test : Data from Y_test.txt
* data_Train : Data from X_train.txt
* data_Train : Data from X_test.txt
* final_data_table : Final merge table of data.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* dataFeaturesMeanStd : Vector of only mean and std labels extracted from 2nd column of features
* final_data_table : Only contain mean and std variables

## 3. Uses descriptive activity names to name the activities in the data set.

* final_data_table$activityName : Change the acivity name from number to activity name.

## 4. Uses descriptive activity names to name the activities in the data set.
* t= time 
* f= frequency measurements.
* Body = related to body movement.
* Gravity = acceleration of gravity.
* Acc = accelerometer measurement.
* Gyro = gyroscopic measurements.
* Jerk = sudden movement acceleration.
* Mag = magnitude of movement.

## 5. Uses descriptive activity names to name the activities in the data set.

 * Tidy data can be found in Tidy_Data.txt


