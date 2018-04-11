#download the data 
filepath <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(filepath, destfile = "Dataset.zip")
unzip(zipfile = "Dataset.zip")

#load library
library(dplyr)
library(data.table)
library(tidyr)


#1. Merges the training and the test sets to create one data set.

#Subject file Read
subjectData_Train <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "train", "subject_train.txt")))
SubjectData_Test <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "test", "subject_test.txt")))

#Activity file Read
activityData_Train <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "train", "Y_train.txt")))
activityData_Test <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "test", "Y_test.txt")))

#Data file Read
data_Train <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "train", "X_train.txt" )))
data_Test  <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "test" , "X_test.txt" )))

#Merge subject and activity training and test set by row binding 
merge_dataSubject <- rbind (subjectData_Train, SubjectData_Test)
colnames(merge_dataSubject) <- c("subject")
merge_dataActivity <- rbind (activityData_Train, activityData_Test)
colnames(merge_dataActivity) <- c("activityNum")

#Merge data file for Training and Test
mergedata_Table <- rbind (data_Train,data_Test)
dim (mergedata_Table)

#Rename the merge data column
data_Features <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "features.txt")))
colnames(data_Features) <- c("featureNum", "featureName")
colnames(mergedata_Table) <- data_Features$featureName

#Read Activity data
activity_level <- tbl_df(read.table(file.path(".//UCI HAR Dataset", "activity_labels.txt")))
colnames(activity_level) <- c("activityNum","activityName")

#Merge All the data columns
merge_Subject_activity <- cbind(merge_dataSubject,merge_dataActivity)
final_data_table <- cbind(merge_Subject_activity,mergedata_Table)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.

dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",data_Features$featureName,value=TRUE)
dataFeaturesMeanStd <- union(c("subject","activityNum"), dataFeaturesMeanStd)
dataFeaturesMeanStd
final_data_table<- subset(final_data_table,select=dataFeaturesMeanStd) 

#3. Uses descriptive activity names to name the activities in the data set

final_data_table <- merge(activity_level, final_data_table , by= "activityNum")
final_data_table$activityName <- as.character(final_data_table$activityName)

#4. Appropriately labels the data set with descriptive variable names

names(final_data_table)<-gsub("std()", "SD", names(final_data_table))
names(final_data_table)<-gsub("mean()", "MEAN", names(final_data_table))
names(final_data_table)<-gsub("^t", "time", names(final_data_table))
names(final_data_table)<-gsub("^f", "frequency", names(final_data_table))
names(final_data_table)<-gsub("Acc", "Accelerometer", names(final_data_table))
names(final_data_table)<-gsub("Gyro", "Gyroscope", names(final_data_table))
names(final_data_table)<-gsub("Mag", "Magnitude", names(final_data_table))
names(final_data_table)<-gsub("BodyBody", "Body", names(final_data_table))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(final_data_table, "Tidy_Data.txt", row.name=FALSE)



