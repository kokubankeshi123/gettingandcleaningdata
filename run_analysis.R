# Read files necessary for the analysis
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
features <- read.table("./features.txt")

# Check the dimension of the data
dim(x_test)
dim(y_test)
dim(subject_test)
dim(x_train)
dim(y_train)
dim(subject_train)

# Check the numbers of mean and standard deviation related columns
length(grep("mean()", features$V2))
length(grep("std()", features$V2))

# Make a vector for the name of columns of the first tidy data set
featuresmean <- grep("mean()", features$V2, value = TRUE)
featuresstd <- grep("std()", features$V2, value = TRUE)
columns <- c("subject", "activity", featuresmean, featuresstd)

# Make the "test" data frame
testmean <- x_test[, grep("mean()", features$V2)]
teststd <- x_test[, grep("std()", features$V2)]
testdata <- cbind(subject_test, y_test, testmean, teststd)

# Make the "train" data frame
trainmean <- x_train[, grep("mean()", features$V2)]
trainstd <- x_train[, grep("std()", features$V2)]
traindata <- cbind(subject_train, y_train, trainmean, trainstd)

# Conbine the "test" data frame and "train" data frame 
data <- rbind(testdata, traindata)

# Rename the columns
names(data) <- columns

# Reorder the data frame according to "subject" and "activity"
data <- data[order(data$subject, pmax(data$activity)),]

# Attach discriptive activity names to the data frame
data$activity <- sub(1, "WALKING", data$activity)
data$activity <- sub(2, "WALKING_UPSTAIRS", data$activity)
data$activity <- sub(3, "WALKING_DOWNSTAIRS", data$activity)
data$activity <- sub(4, "SITTING", data$activity)
data$activity <- sub(5, "STANDING", data$activity)
data$activity <- sub(6, "LAYING", data$activity)

# Factorise the "activity" and "subject" columns
data$activity <- factor(data$activity, 
                        levels = c("WALKING", "WALKING_UPSTAIRS", 
                                   "WALKING_DOWNSTAIRS", "SITTING", 
                                   "STANDING", "LAYING"))
data$subject <- factor(data$subject)

# View the first tidy data set
View(data)

# Load "reshape2" package for reshaping the first tidy data set
# to produce the second tidy data set
library(reshape2)

# Melt the first tidy data set
dataMelt <- melt(data, id = c("subject", "activity"), measure.vars = 3:81)
head(dataMelt)
tail(dataMelt)

# Create a data set with the average of each variable for each subject and activity
subjects <- data.frame()
subjectavtivity <- data.frame()
for(i in 1:30) {
        subjects <- dcast(dataMelt[dataMelt$subject == i,], activity ~ variable, mean)
        subjectavtivity <- rbind(subjectavtivity, subjects)
        }
subjectavtivity <- mutate(subjectavtivity, subject = rep(1:30, each = 6))
subjectavtivity <- subjectavtivity[, c(81, 1:80)]
View(subjectavtivity)

# Save the data frame
write.table(subjectavtivity, file = "subjectactivity.txt", row.names = FALSE)

