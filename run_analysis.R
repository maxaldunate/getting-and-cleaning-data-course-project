dataDirectory <- paste0(getwd(),"/data")

print("Downloading and unzipping data if 'data' directory doesen't exists ...")
if (!dir.exists("data")){
  dir.create("data")

  if(file.exists("data.zip")){
      filesToUnzip <- c("subject_test.txt","X_test.txt","y_test.txt","subject_train.txt","X_train.txt","y_train.txt","activity_labels.txt","features.txt")
      unzip("data.zip", files = filesToUnzip,exdir = dataDirectory, junkpaths = TRUE)
      rm(filesToUnzip) 
    } else {
      fileName <- paste0(dataDirectory,"/UCI_HAR_Dataset.zip")
      unzipFileName <- paste0(dataDirectory,"/UCI HAR Dataset")
      
      if (!file.exists(fileName)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, fileName)
      }
      
      filesToUnzip <- c("UCI HAR Dataset/test/subject_test.txt","UCI HAR Dataset/test/X_test.txt","UCI HAR Dataset/test/y_test.txt","UCI HAR Dataset/train/subject_train.txt","UCI HAR Dataset/train/X_train.txt","UCI HAR Dataset/train/y_train.txt","UCI HAR Dataset/activity_labels.txt","UCI HAR Dataset/features.txt")
      unzip(fileName, files = filesToUnzip,exdir = dataDirectory, junkpaths = TRUE) 
      rm(fileName, filesToUnzip, fileUrl, unzipFileName)  
    }
}

print("Reading activities and features ...")
activityType <- read.table(paste0(dataDirectory,"/activity_labels.txt"))
featuresVariables <- read.table(paste0(dataDirectory,"/features.txt"))

print("Boxing activities and features to character ...")
activityType[,2] <- as.character(activityType[,2])
featuresVariables[,2] <- as.character(featuresVariables[,2])

print("Getting mean and standard deviation ...")
featuresTarget <- grep(".*mean.*|.*std.*", featuresVariables[,2])
featuresNames <- featuresVariables[featuresTarget,2]
featuresNames <- gsub("-mean", "Mean", featuresNames)
featuresNames <- gsub("-std", "Std", featuresNames)
featuresNames <- gsub("[-()]", "", featuresNames)
rm(featuresVariables)

print("Reading file train tables data ...")
trainData <- read.table(paste0(dataDirectory,"/X_train.txt"))[featuresTarget]
trainActivityData <- read.table(paste0(dataDirectory,"/Y_train.txt"))
trainSubjectData <- read.table(paste0(dataDirectory,"/subject_train.txt"))

print("Reading file test tables data ...")
testData <- read.table(paste0(dataDirectory,"/X_test.txt"))[featuresTarget]
testActivityData <- read.table(paste0(dataDirectory,"/Y_test.txt"))
testSubjectData <- read.table(paste0(dataDirectory,"/subject_test.txt"))
trainData <- cbind(trainSubjectData, trainActivityData, trainData)
testData <- cbind(testSubjectData, testActivityData, testData)
rm(featuresTarget, dataDirectory, trainActivityData, trainSubjectData, testActivityData, testSubjectData)

print("Merging training and test data ...")
trainAndTestData <- rbind(trainData, testData)
colnames(trainAndTestData) <- c("subject", "activity", featuresNames)
rm(featuresNames, trainData, testData)

print("Preparing tidy data set ...")
trainAndTestData$activity <- factor(trainAndTestData$activity, levels = activityType[,1], labels = activityType[,2])
trainAndTestData$subject <- as.factor(trainAndTestData$subject)
rm(activityType)

library(reshape2)
trainAndTestDataJoined <- melt(trainAndTestData, id = c("subject", "activity"))
trainAndTestDataMean <- dcast(trainAndTestDataJoined, subject + activity ~ variable, mean)
rm(trainAndTestData, trainAndTestDataJoined)

print("Writting tidy.txt file ...")
write.table(trainAndTestDataMean, "tidy.txt", row.names = FALSE, quote = FALSE)
