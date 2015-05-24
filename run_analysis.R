## Getting the data

if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset,zip", exdir="./data")
path_dt <- file.path("./data", "UCI HAR Dataset")
files<-list.files(path_dt, recursive=TRUE)

## Reading data from the files into the variables
dataActivityTest<-read.table(file.path(path_dt, "test", "Y_test.txt"), header=FALSE)
dataActivityTrain<-read.table(file.path(path_dt, "train", "Y_train.txt"),header=FALSE)

dataSubjectTest<-read.table(file.path(path_dt, "test", "subject_test.txt"), header=FALSE)
dataSubjectTrain<-read.table(file.path(path_dt, "train", "subject_train.txt")header=FALSE)

dataFeaturesTest<-read.table(file.path(path_dt, "test", "X_test.txt"), header=FALSE)
dataFeatureTrain<-read.table(file.path(path_dt, "train", "X_train.txt"), header=FALSE)

## Merging the training and test sets to create one data set.
dataActivity<-rbind(dataActivityTest, dataActivityTrain)
dataSubject<-rbind(dataSubjectTest, dataSubjectTrain)
dataFeatures<-rbind(dataFeaturesTest, dataFeaturesTrain)

names(dataSubject)<-c("subject")
names(dataActivity)<-c("activity")
dataFeaturesNames<-read.table(file.path(path_dt, "features,txt"), head=FALSE)
names(dataFeatures)<-dataFeaturesNames$V2

dataCombined<-cbind(dataSubject, dataActivity)
Data<-cbind(dataFeatures, dataCombined)

## Extract only the measurements on the mean and standard deviation for each measurement.
subdataFeatures<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2]
selected<-c(as.character(subdataFeatures), "subject", "activity")
Data<-subset(Data,select=selected)

## Name the activities in the data set
activityLabels<-read.table(file.path(path_dt, "activity_labels.txt"), header=FALSE)
Data$activity <-  as.character(Data$activity)
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking upstairs"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"
Data$activity <- as.factor(Data$activity)
head(Data$activity)

## Label the data set with descriptive variable names.
names(Data)<-gsub("Acc", "Accelerator", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frecuency", names(Data))
names(Data)

## Create a second independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
Data2<-aggregate(.~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject, Data2$activity),]
write.table(Data2, file="tidydata.txt", row.name=FALSE)