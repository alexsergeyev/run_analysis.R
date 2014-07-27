#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

getdata <- function(url, dest_file=basename(url)) {
  if (!file.exists(dest_file)) {
    download.file(url, destfile = dest_file, method = "curl")
  }
  if (!file.exists("UCI HAR Dataset")) {
    unzip(dest_file)
  }
  dest_file
}

getdata("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",'dataset.zip')
library(reshape2)

# Load all files into R
labels.activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject <- rbind(test.subject, train.subject)
colnames(subject) <- "subject"

label <- rbind(test.y, train.y)
label <- merge(label, labels.activity, by=1)[,2]

data <- rbind(test.x, train.x)
colnames(data) <- features[, 2]
data <- cbind(subject, label, data)

filtered <- data[,c(1,2,grep("-mean|-std", colnames(data)))]
tidy = dcast(melt(filtered, id.var = c("subject", "label")) , subject + label ~ variable, mean)

write.table(tidy, file="tidy_data.txt")
