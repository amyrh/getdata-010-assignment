#
#
#
#


library(dplyr)

#
# 01 merge the training and test sets to create one data set
#
activities = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("TrainingLabel", "Activity"))
features = read.table("UCI HAR Dataset/features.txt") # 561 feature lables


subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("SubjectID"))

#
# 04 appropriately label the data set with descriptive variable names
#

x_train = read.table("UCI HAR Dataset/train/X_train.txt", col.names=as.vector(features[,2]), check.names=F) # training set
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("TrainingLabel")) # training labels

# create data frame from training data
trainingData <- data.frame(subject_train, y_train, x_train)

# add Activity label
trainingData <- merge(trainingData, activities, by="TrainingLabel",sort=F)



subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("SubjectID"))
x_test = read.table("UCI HAR Dataset/test/X_test.txt", col.names=as.vector(features[,2]), check.names=F) # training set
y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("TrainingLabel")) # training labels

# create data frame from training data
testData <- data.frame(subject_test, y_test, x_test)


#
# 03 use descriptive activity names to name the activities in the data set
#

# add Activity label
testData <- merge(testData, activities, by="TrainingLabel",sort=F)



#combine the training and test data frames
allData <- rbind(trainingData, testData)






#
# 02 extract only the measurements on the mean and standard deviation for each measurement
#

# convert to tplyr table data frame
allDataTbl <- tbl_df(allData)

# select only data relating to mean to standard deviation
meanAndStd = select(allDataTbl, SubjectID, Activity, contains(".mean.."), contains(".std.."))



#
# 05 from the data set, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
#
tidyData <- meanAndStd %>%
  group_by(Activity, SubjectID) %>%
  summarise_each(funs(mean, "mean")) 


#
# Output tidy data to file
#
write.table(tidyData, file="outputTidyData.txt", row.name=FALSE)