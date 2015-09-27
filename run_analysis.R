library(dplyr)

# read the data into objects from the files
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("./UCI HAR Dataset/test/Y_test.txt")
trainingSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingActivities <- read.table("./UCI HAR Dataset/train/Y_train.txt")
columns <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# combine relevant data into one data frame
test <- cbind(testSubjects, testActivities, testData)
training <- cbind(trainingSubjects, trainingActivities, trainingData)
allData <- rbind(test, training)

# pull in the column names from the columns object
# first I need to coerce the columns from factors to strings
columnNames <- lapply(columns[, 2], as.character)
# and then change the column names
colnames(allData)[1] <- "subject"
colnames(allData)[2] <- "activity"
colnames(allData)[3:563] <- columnNames

# filter the data to only those that are means or standard deviations, while keeping subject and activity columns
allData <- allData[, grep("mean|Mean|std|subject|activity", colnames(allData))]

# For each combination of subject and activity, compute the mean for each variable
allData <- aggregate(allData, by=list(allData$activity,allData$subject), 
                   FUN=mean)

# Remove the first two columns that were added by the aggregate function
allData <- allData[, 3:90]

# change the actividy IDs in the activity column to the activity labels
allData$activity <- activityLabels$V2[match(allData$activity, activityLabels$V1)]

# write output to a text file
write.table(allData, file = "./outputData.txt", row.names = FALSE)