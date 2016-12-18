##--------------------------------------------------------------------------
## 1. Merge the training and the test sets to create one data set.

## step 1.1: download zip file from website

if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/projectData_getCleanData.zip")

## step 1.2: unzip data and list the files

listZip <- unzip("./data/projectData_getCleanData.zip", exdir = "./data", overwrite = FALSE)

fpath <- file.path("./data" , "UCI HAR Dataset")
files <-list.files(fpath, recursive=TRUE)
files

## step 1.3: load data into R

train.x <- read.table(file.path(fpath, "train", "X_train.txt"), header = FALSE)
train.y <- read.table(file.path(fpath, "train", "y_train.txt"), header = FALSE)
train.subject <- read.table(file.path(fpath, "train", "subject_train.txt"), header = FALSE)
test.x <- read.table(file.path(fpath, "test", "X_test.txt"), header = FALSE)
test.y <- read.table(file.path(fpath, "test", "y_test.txt"), header = FALSE)
test.subject <- read.table(file.path(fpath, "test", "subject_test.txt"), header = FALSE)

## step 1.4: merge train and test data

names(train.subject) <- c("subject")
names(test.subject) <- c("subject")
names(train.y) <- c("activity")
names(test.y) <- c("activity")
features <- read.table(file.path(fpath, "features.txt"), header = FALSE)
names(train.x) <- features$V2
names(test.x) <- features$V2

traindata <- cbind(train.subject, train.y, train.x)
testdata <- cbind(test.subject, test.y, test.x)
fulldata <- rbind(traindata, testdata)

##-------------------------------------------------------------------------------
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

## step 2.1:  extract mean and standard deviation of each measurements
subfeatures <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

## step 2.2: subset the data
selected <- c("subject", "activity", as.character(subfeatures))
finaldata <- subset(fulldata, select = selected)

##-------------------------------------------------------------------------------
## 3. Uses descriptive activity names to name the activities in the data set

## step 3.1: load activity data into R
activitylabels <- read.table(file.path(fpath, "activity_labels.txt"), header = FALSE)

## step 3.2: replace 1 to 6 with activity names
finaldata$activity <- factor(finaldata$activity, levels = activitylabels$V1, labels = activitylabels$V2)

#-------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names.

## step 4.1: rename labels
names(finaldata) <- gsub("\\()", "", names(finaldata))
names(finaldata) <- gsub("^t", "time", names(finaldata))
names(finaldata) <- gsub("^f", "frequency", names(finaldata))
names(finaldata) <- gsub("-mean", "Mean", names(finaldata))
names(finaldata) <- gsub("-std", "Std", names(finaldata))
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))

## step 4.2: check labels
names(finaldata)

##-------------------------------------------------------------------------------
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## step 5.1: calculate the average of each variable for each activity and each subject from the data set in step 4
library(plyr)

newdata <- aggregate(. ~subject + activity, finaldata, mean)
newdata2 <- newdata[order(newdata$subject, newdata$activity), ]

## step 5.2: creates a second, independent tidy data set
write.table(newdata2, file = "tidydata.txt", row.names = FALSE)

##-------------------------------------------------------------------------------
## 6. Produce a codebook for the final data set

install.packages("memisc")
library(memisc)
codebook(newdata2)