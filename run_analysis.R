rm(list = ls())

# Read in all the 'test' tables we need.
subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")
x_test <- read.table("test/X_test.txt")

# Read in all the 'train' tables we need.
subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
x_train <- read.table("train/X_train.txt")

# 1. Merges the training and the test sets to create one data set.

# Merge the subject, y, and x tables.
subject <- rbind(subject_test, subject_train)
y <- rbind(y_test, y_train)
x <- rbind(x_test, x_train)

# Read in the 'feature' names.
features <- read.table("features.txt")

# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 

# Subset x to only those columns in 'features' that have 
# 'mean()' or 'std()' in them.
xMeanStd <- x[,grep("mean()|std()",features$V2)]

# 3. Uses descriptive activity names to name the activities in the data set

# Read in the list of six different activities.
activity_labels <- read.table("activity_labels.txt")

# In the 'y' table, replace the numeric value with the activity name.
y$V1 <- as.character(activity_labels$V2[y$V1])

# 4. Appropriately labels the data set with descriptive variable names. 
# NOTE: As I am not a domain expert, I think the variable names in 
#       'features.txt' are adequately descriptive.

# Get the 'features' column names that have 'mean()' and 'std()' in them.
columnnames <- features[grep("mean()|std()",features$V2),]

# Apply those column names to the table with 'mean()' and 'std()' values.
colnames(xMeanStd) <- columnnames$V2

# Give names to the first two columns.
colnames(subject) <- "subject"
colnames(y) <- "activity"

# Merge the subject column, activity column, and 'x' columns
masterData <- cbind(subject, y, xMeanStd)

# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.

library(dplyr)

# Use dplyr to group the data by subject and activity and then take the mean
# for each variable for each group.
masterDataSummarized <- masterData  %>% 
    group_by(subject, activity) %>% 
    summarise_each(funs(mean))

# Output the "tidy" data set to a file.
write.table(masterDataSummarized, file = "tidy_data.csv", sep = ",", 
            row.names = FALSE)