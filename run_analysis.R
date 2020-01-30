
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

subject <- rbind(subject_train, subject_test)
setnames(subject, names(subject), "subject")

y <- rbind(y_train, y_test )
setnames(y, names(y), "activityNumber")
x <- rbind(x_train, x_test )

new_activity_labels=merge(y, activity_labels)
result=cbind(new_activity_labels[,2],subject,x)
names(result)[1] <- "Activity"
names(result)[2] <- "Subject"

mean <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x_mean <- x[, mean]

names(x_mean) <- features[mean, 2]
write.table(names(x_mean), "codebook.md",row.names = FALSE, quote = FALSE)
write.table(x_mean, "tidy_data.txt",row.names = FALSE, quote = FALSE)
