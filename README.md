# Getting and Cleaning Data - Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. It will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.This repo explains how all of the scripts work and how they are connected.

In this repository we use the [UCI Human Activity Recognition using Smartphones data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
), and here is the data set for this project:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

The five tasks to complete the project are as follows:

1. Merge the training and test sets to create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the data set
4. Label de data set with descriptive variable names
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

## Getting the data

### A. Download the file into a new folder "data"

```
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip")
```

### B. Unzip the file

```
unzip(zipfile="./data/Dataset,zip", exdir="./data")
```

### C. Get the list of files from the [UCI HAR dataset]

```
path_dt <- file.path("./data", "UCI HAR Dataset")
files<-list.files(path_dt, recursive=TRUE)
```

### D. Read the data and separate it in group variables

Activity data

```
dataActivityTest<-read.table(file.path(path_dt, "test", "Y_test.txt"), header=FALSE)
dataActivityTrain<-read.table(file.path(path_dt, "train", "Y_train.txt"),header=FALSE)
```
Subject data

```
dataSubjectTest<-read.table(file.path(path_dt, "test", "subject_test.txt"), header=FALSE)
dataSubjectTrain<-read.table(file.path(path_dt, "train", "subject_train.txt")header=FALSE)
```

Features data

```
dataFeaturesTest<-read.table(file.path(path_dt, "test", "X_test.txt"), header=FALSE)
dataFeatureTrain<-read.table(file.path(path_dt, "train", "X_train.txt"), header=FALSE)
```

You can see the structure of every variable group using the str() function.

## 1. Merge the training and test sets to create one data set

First we concatenate the data tables by rows

```
dataActivity<-rbind(dataActivityTest, dataActivityTrain)
dataSubject<-rbind(dataSubjectTest, dataSubjectTrain)
dataFeatures<-rbind(dataFeaturesTest, dataFeaturesTrain)
```

Then we set names for each variable

```
names(dataSubject)<-c("subject")
names(dataActivity)<-c("activity")
dataFeaturesNames<-read.table(file.path(path_dt, "features,txt"), head=FALSE)
names(dataFeatures)<-dataFeaturesNames$V2
```

Finally we merge the columns to get the data frame that we will call "Data".

```
dataCombined<-cbind(dataSubject, dataActivity)
Data<-cbind(dataFeatures, dataCombined)
```

## 2. Extract only the measurements on the mean and standard deviation for each measurement

First we need to subset the Names of Features by mean and standard deviation.

```
subdataFeatures<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2]
```

Then we subset the "Data" by selected names of Features.

```
selected<-c(as.character(subdataFeatures), "subject", "activity")
Data<-subset(Data,select=selected)
```

If we want to check the extracted data we can use the str() function on the Data set.

## 3.Use descriptive activity names to name the activities in the data set

First we need to read the descriptive activity names from the file "activity_labels.txt"

```
activityLabels<-read.table(file.path(path_dt, "activity_labels.txt"), header=FALSE)
```

Then, now that we know the label that corresponds for each code, we give a name for each activity

```
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking upstairs"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"
```
The variables activity and subject and names of the activities have been labelled using descriptive names.

## 4. Label de data set with descriptive variable names

Now the names of Feteatures will labelled using descriptive variable names.

```
names(Data)<-gsub("Acc", "Accelerator", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frecuency", names(Data))
names(Data)
```

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

A second, independent tidy data set will be created with the average of each variable for each activity and each subject based on the data set in step 4.

```
library(plyr)
Data2<-aggregate(.~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject, Data2$activity),]
write.table(Data2, file="tidydata.txt", row.name=FALSE)

To see this new data you can find it in this repo under the name of "tidydata.txt".