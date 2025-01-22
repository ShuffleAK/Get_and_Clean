library(dplyr)

file<- "UCI HAR Dataset.zip"
fileURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,file, method = "curl")
unzip(file)

#Define path for feature and activity datasets
feature_path <- "./UCI HAR Dataset/features.txt"
activity_path <-"./UCI HAR Dataset/activity_labels.txt"

#Load datasets
features <- read.table(feature_path,col.names = c("n","functions"))
activities <- read.table(activity_path, col.names = c("code", "activity"))

# Define paths for the training and test datasets
train_x_path <- "./UCI HAR Dataset/train/X_train.txt"
test_x_path <- "./UCI HAR Dataset/test/X_test.txt"

# Load the training and test datasets
train_x <- read.table(train_x_path, col.names = features$functions)
test_x <- read.table(test_x_path, col.names = features$functions)

# Define paths for the training and test labels
train_y_path <- "./UCI HAR Dataset/train/y_train.txt"
test_y_path <- "./UCI HAR Dataset/test/y_test.txt"

# Load the training and test labels
train_y <- read.table(train_y_path, col.names = "code")
test_y <- read.table(test_y_path, col.names = "code")

# Define paths for the training and test subject IDs
train_subject_path <- "./UCI HAR Dataset/train/subject_train.txt"
test_subject_path <- "./UCI HAR Dataset/test/subject_test.txt"

# Load the training and test subject IDs
train_subject <- read.table(train_subject_path, col.names = "subject")
test_subject <- read.table(test_subject_path, col.names = "subject")

# Merge the training data, labels, and subject IDs
merged_train_data <- cbind(train_subject, train_y, train_x)

# Merge the test data, labels, and subject IDs
merged_test_data <- cbind(test_subject, test_y, test_x)

# Combine the training and test datasets into one dataset
final_dataset <- rbind(merged_train_data, merged_test_data)

# Extract only the columns with mean() or std() in their names
final_dataset_mean_std <- final_dataset %>% select(subject, code, contains("mean"),contains("std"))

#Uses descriptive activity names to name the activities in the data set.
final_dataset_mean_std$code <- activities[final_dataset_mean_std$code,2]

#Appropriately labels the data set with descriptive variable names. 
names(final_dataset_mean_std)[2] = "activity"
names(final_dataset_mean_std)<-gsub("^t", "Time", names(final_dataset_mean_std))
names(final_dataset_mean_std)<-gsub("^f", "Frequency", names(final_dataset_mean_std))
names(final_dataset_mean_std)<-gsub("Acc", " Accelerometer", names(final_dataset_mean_std))
names(final_dataset_mean_std)<-gsub("Gyro", " Gyroscope", names(final_dataset_mean_std))
names(final_dataset_mean_std)<-gsub("BodyBody", " Body", names(final_dataset_mean_std))
names(final_dataset_mean_std)<-gsub("Mag", " Magnitude", names(final_dataset_mean_std))

# From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.
cleaned_data <- final_dataset_mean_std %>%
group_by(subject, activity) %>%
summarise(across(everything(), mean, na.rm = TRUE))
write.table(cleaned_data,"cleaned_data.txt",row.names = FALSE)
