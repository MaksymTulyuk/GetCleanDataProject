## Project.
## Getting and Cleaning Data Course Project

readLabels <- function(name) {
    ## readLabels: read labels from file
    read.table(paste0("UCI HAR Dataset/", name, ".txt"), row.names = 1)
}

readDataColumn <- function(testGroup, name) {
    ## readDataColumn: read a column of data from file and reclasity it as factor
    data <- read.table(paste0("UCI HAR Dataset/", testGroup, "/", name, "_", testGroup, ".txt"))
    data[,1] <- as.factor(data[,1])
    data
}

readDataSet <- function(testGroup, name) {
    ## readDataSet: read data set with values from file
    data <- read.table(paste0("UCI HAR Dataset/", testGroup, "/", name, "_", testGroup, ".txt"),
                       colClasses = "character")
    # change all values to class "double"
    as.data.frame(lapply(data, as.double))
}

joinDataInSet <- function(set = "test") {
    ## joinDataInSet: read files with subjects, activities coded for labels,
    ## data of experiments and join them into one data set
    # read separate files
    subjects <- readDataColumn(set, "subject")
    labels <- readDataColumn(set, "y")
    experiments <- readDataSet(set, "x")
    # join subjects, labels and experiments in one data frame
    cbind(subjects[,1], labels[,1], experiments)
}

part1 <- function() {
    ## Part 1: merges the training and the test sets to create one data set
    # read the sets: test and train
    testSet <- joinDataInSet("test")
    trainSet <- joinDataInSet("train")
    # merge the sets
    rbind(testSet, trainSet)
}

getColumnNumbers <- function(string) {
    ## getColumnNumbers: get numbers of columns based on string
    # read features files if it wasn't loaded
    if (!exists("features")) {
        features <- readLabels("features")
    }
    # get column numbers by string in "string"
    columnNumbers <- grep(string, features[,1])
    # add two columns to skip the columns "subjects" and "labels" at the beginning
    columnNumbers + 2
}

getTwoColumnNumbers <- function(string1, string2) {
    ## getColumnNumbers: get numbers of columns from string
    # get both column numbers
    columnsWithString1 <- getColumnNumbers(string1)
    columnsWithString2 <- getColumnNumbers(string2)
    # return joined sort column numbers
    sort(as.integer(c(columnsWithString1, columnsWithString2)))
}

part2 <- function(dataSet) {
    ## Part2: extract only the measurements on the mean and standard deviation
    # get column numbers with Mean and Standart Deviation
    columnsWithMeanSD <- getTwoColumnNumbers("mean\\(\\)", "std\\(\\)")
    # return columns subjects, labels, Mean and Standart Deviation
    dataSet[,c(1, 2, columnsWithMeanSD)]
}

part3 <- function(dataSet) {
    ## Part 3: use descriptive activity names to name the activities
    # read activities file
    activity_labels <- readLabels("activity_labels")    
    # change numeric labels to character activities
    levels(dataSet[,2]) <- c(activity_labels[,1])
    # return dataSet
    dataSet
}

getColumnWithTwoStrings <- function(string1, string2) {
    ## getColumnWithTwoStrings: return columns with string1 and string2
    # read features files if it wasn't loaded
    if (!exists("features")) {
        features <- readLabels("features")
    }
    # get column numbers
    twoColumnNumbers <- getTwoColumnNumbers(string1, string2)
    # remove two first columns "subject" and "activity"
    twoColumnNumbers <- twoColumnNumbers - 2
    # return column names for string1 and string2
    features[c(twoColumnNumbers),]
}

normaliseNames <- function(names) {
    ## normaliseNames: normalise names of columns
    # remove all dashes
    names <- gsub("-", "", names)
    # replaces
    names <- sub("mean\\(\\)", "Mean", names)
    names <- sub("std\\(\\)", "StandardDeviation", names)
    names <- sub("Acc", "Accelerometer", names)
    names <- sub("Gyro", "Gyroscope", names)
    names <- sub("Mag", "Magnitute", names)
    # replaces with regex
    names <- sub("^t", "Time", names)
    names <- sub("^f", "Frequency", names)
    names
}

part4 <- function(dataSet) {
    ## part4: labels the data set with descriptive variable names
    # get column names with Mean and Standart Deviation
    columnNamesWithMeanSD <- getColumnWithTwoStrings("mean\\(\\)", "std\\(\\)")
    # make names readable
    normalisedNames <- normaliseNames(columnNamesWithMeanSD)
    # set column names on joined data frame
    names(dataSet) <- c("subject", "activity", as.character(normalisedNames))
    # return data set with labels in columns
    dataSet
}

part5 <- function(dataSet) {
    ## part5: create tidy data set with the average of each variable
    ## for each activity and each subject
    # get average per each subject and activity
    tidyDataSet <- aggregate(dataSet[,-c(1, 2)], by = list(dataSet$subject, dataSet$activity),
                             FUN=mean)
    # restore names of two first columns
    names(tidyDataSet)[c(1, 2)] <- c("subject", "activity")
    # return data set with means
    tidyDataSet
}

# do the parts of the project one-by-one
dataSet <- part1()
meanSDdataSet <- part2(dataSet)
labeledDataSet <- part3(meanSDdataSet)
namedDataSet <- part4(labeledDataSet)
tidyDataSet <- part5(namedDataSet)
# save tidy data set
write.table(tidyDataSet, "tidy data set.txt", row.name=FALSE)
