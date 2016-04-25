#Downloading the files


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="C:/Apps/python/R/dataset.zip")


##Unzipping the file 

unzip(zipfile="C:/Apps/python/R/dataset.zip", exdir= "C:/Apps/python/R/analysis_new")

##Unzipped files are in the folder UCI HAR Dataset.

path_rf <- file.path ("C:/Apps/python/R/analysis_new", "UCI HAR Dataset")
files <- list.files (path_rf, recursive =TRUE)
files

## read data from the files into the variables

## 1. Read the Activity files

data_activity_test <- read.table(file.path(path_rf, "test", "Y_test.txt"), header=FALSE)
data_activity_train <- read.table(file.path(path_rf, "train", "Y_train.txt"), header=FALSE)

## 2. Reading the subject files

data_subject_test <- read.table(file.path(path_rf, "test", "subject_test.txt"), header=FALSE)
data_subject_train <- read.table(file.path(path_rf, "train", "subject_train.txt"), header=FALSE)

## 3. Reading Features file

data_features_test <- read.table(file.path(path_rf, "test", "X_test.txt"), header=FALSE)
data_features_train <- read.table(file.path(path_rf, "train", "X_train.txt"), header=FALSE)

## Merging the training and the test sets to create one data set

## 1. Join or concatenate the data tables by row

dataSubject <- rbind (data_subject_train, data_subject_test)
dataActivity <-rbind (data_activity_train, data_activity_test)
dataFeatures <- rbind (data_features_train, data_features_test)

## 2. set names to variables 
names(dataSubject) <- c("subject")
names(dataActivity)<- c("activity")
dataFeaturesName <- read.table (file.path(path_rf, "features.txt"), head= FALSE)
names(dataFeatures) <- dataFeaturesName$V2

## 3. Merge columns to get the data frame

dataCombine <- cbind (dataSubject, dataActivity)
Data<- cbind(dataFeatures, dataCombine)

##Extracts only measurements for mean and standard deviation 

subdataFeaturesNames <- dataFeaturesName$V2 [grep("mean\\(\\)|std\\(\\)", dataFeaturesName$V2)]
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity")
Data<- subset(Data, select=selectedNames)

str(Data)

## Using descriptive activity names to the data set

## 1. Read desciptive activity from "activity_lables.txt"

activityLabels <- read.table(file.path(path_rf, "C:/Apps/python/R/analysis_new/UCI HAR Dataset/activity_labels.txt"), header= FALSE)


head(Data$activity, 30)
