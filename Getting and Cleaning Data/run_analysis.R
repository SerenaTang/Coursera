# Course 3 - WEEK 4
## Getting and Cleaning Data Course Project
## 12-10-2017

library(dplyr)
dpath<-"./Course3/UCI HAR Dataset/"

##########################################################################
#####1. Reads & merges training and test sets#############################
##########################################################################

## Reads data
activities <- read.table(paste(dpath,"activity_labels.txt", sep=""))
features <- read.table(paste(dpath,"features.txt", sep=""))

train.x <- read.table(paste(dpath,"train/X_train.txt", sep=""))
train.y <- read.table(paste(dpath,"train/y_train.txt", sep=""))
train.subjects <- read.table(paste(dpath,"train/subject_train.txt", sep=""))

test.x <- read.table(paste(dpath,"test/X_test.txt", sep=""))
test.y <- read.table(paste(dpath,"test/y_test.txt", sep=""))
test.subjects <- read.table(paste(dpath,"test/subject_test.txt", sep=""))

## Combine training and test data
train <- cbind(train.subjects,train.y,train.x)
test <- cbind(test.subjects,test.y,test.x)
dataMerged <- rbind(train, test)

## Change column names
colnames(activities) <- c("activityLabel", "activity")
colnames(dataMerged) <- c("subjectId","activityLabel", as.character(features[,2]))

########################################################################
#####2. Extracts only measures on mean and std for each measurement#####
########################################################################

## Gets columns which measures the mean and standard deviation for each measurement
col.extract <- grep("subjectId|activityLabel|mean|std", colnames(dataMerged))

## Data subset
dataMeanAndStd<- dataMerged[,col.extract]

########################################################################
#####3. Gets descriptive activity names for activities in data set #####
########################################################################

## Data with activity description
dataWithActivityDesc <- merge(dataMeanAndStd, activities, by="activityLabel", all.x = TRUE)


########################################################################
#####4. Labels dataset with descriptive variable names #################
########################################################################

## Cleans up column names
cols<-colnames(dataWithActivityDesc) 

cols <- gsub("[\\(\\)-]", "", cols)
cols <- gsub("BodyBody", "Body", cols)

cols <- gsub("^t", "time",cols)
cols <- gsub("^f", "frequency",cols)
cols <- gsub("Acc", "Accelerometer", cols)
cols <- gsub("Gyro", "Gyroscope", cols)
cols <- gsub("Mag", "Magnitude", cols)

cols <- gsub("-mean", "Mean",cols)
cols <- gsub("-std", "StandardDeviation",cols)
cols <- gsub("Freq", "Frequency",cols)

## Assigns new column names
colnames(dataWithActivityDesc) <- cols

########################################################################
#####5. Create second independent tidy data set with avgs ##############
########################################################################

dataNew <- dataWithActivityDesc

## Groups by activity and subject, then summarise for means
dataNew <- dataNew %>% 
        group_by(activity, subjectId) %>% 
        summarise_all(mean)

## Saves new tidy data set for submission
write.table(dataNew,paste(dpath,"dataNew.txt", sep=""),row.names = FALSE, quote = FALSE)

