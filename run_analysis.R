library("dplyr")
# Set working directory
setwd("~/Dropbox/Data Science/R Programming/GettingData/UCI HAR Dataset")

# Preprocess Test Dataset

# Load the data
testm <- read.table("./test/X_test.txt",sep="",stringsAsFactors=F,header=F)
testf <- read.table("features.txt",sep="",stringsAsFactors=F,header=F)
testlabels <- read.table("./test/y_test.txt",sep="",stringsAsFactors=F,header=F)
subjects <- read.table("./test/subject_test.txt",sep="",stringsAsFactors=F,header=F)
colnames(subjects) <- "Subjects"

# Appropriately labels the data set with descriptive variable names.
colnames(testm) <- testf[,2]

# Extracts only the measurements on the mean and standard deviation for each measurement.
testz <- testm[(grep(("mean|std"),colnames(testm)))]

# Remove the columns that contain "Freq" 
testd <- testz[, -(grep(("Freq"),colnames(testz)))]

# Assign label activities
actlist <- read.table("activity_labels.txt",sep="",stringsAsFactors=F,header=F)
colnames(testlabels) <- "Activity"
for (i in 1:length(testlabels$Activity)) {
    if (testlabels$Activity[i] == 5) {
        testlabels$Activity[i] = "Standing"
    }
    if (testlabels$Activity[i] == 6) {
        testlabels$Activity[i] = "Laying"
    }
    if (testlabels$Activity[i] == 4) {
        testlabels$Activity[i] = "Sitting"
    }
    if (testlabels$Activity[i] == 3) {
        testlabels$Activity[i] = "Walking Downstairs"
    }
    if (testlabels$Activity[i] == 2) {
        testlabels$Activity[i] = "Walking Upstairs"
    }
    if (testlabels$Activity[i] == 1) {
        testlabels$Activity[i] = "Walking"
    }
}

# Merge the test data
testdata <- cbind(testd, testlabels, subjects)

# Preprocess Train Dataset

# Load the data

trainm <- read.table("./train/X_train.txt",sep="",stringsAsFactors=F,header=F)
trainlabels <- read.table("./train/y_train.txt",sep="",stringsAsFactors=F,header=F)
subjects <- read.table("./train/subject_train.txt",sep="",stringsAsFactors=F,header=F)
colnames(subjects) <- "Subjects"


# Appropriately labels the data set with descriptive variable names
colnames(trainm) <- testf[,2]

# Extracts only the measurements on the mean and standard deviation for each measurement.
trainz <- trainm[(grep(("mean|std"),colnames(trainm)))]

# Remove the irrelevant variables
traind <- trainz[, -(grep(("Freq"),colnames(trainz)))]

# Assign label activities
colnames(trainlabels) <- "Activity"
for (i in 1:length(trainlabels$Activity)) {
    if (trainlabels$Activity[i] == 5) {
        trainlabels$Activity[i] = "Standing"
    }
    if (trainlabels$Activity[i] == 6) {
        trainlabels$Activity[i] = "Laying"
    }
    if (trainlabels$Activity[i] == 4) {
        trainlabels$Activity[i] = "Sitting"
    }
    if (trainlabels$Activity[i] == 3) {
        trainlabels$Activity[i] = "Walking Downstairs"
    }
    if (trainlabels$Activity[i] == 2) {
        trainlabels$Activity[i] = "Walking Upstairs"
    }
    if (trainlabels$Activity[i] == 1) {
        trainlabels$Activity[i] = "Walking"
    }
}

#Merge the two tables
traindata <- cbind(traind, trainlabels, subjects)

# Merge train data with test data
finaldata <- rbind(testdata, traindata)


# Find mean of each variable for each Activity and Subject
grdata <- group_by(finaldata, Activity, Subjects) %>% summarise_each(funs(mean))



