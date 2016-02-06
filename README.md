# GetCleanDataCourseProj
Getting and Cleaning Data Course Project

The following is, for the most part, the comments contained in my code, 
describing how the script works.

run_analysis.R contains a function, 'tidyDataMagic', that does everything as
specified in the problem specification, which I also quote.  It does the 
following:

- Read in all the 'test' tables we need.
- Read in all the 'train' tables we need.

####1. Merges the training and the test sets to create one data set.
    
- Merge the subject, y, and x tables.
- Read in the 'feature' names.
    
####2. Extracts only the measurements on the mean and standard deviation for 
####   each measurement.

- Subset x to only those columns in 'features' that have 'mean()' or 'std()' 
-   in them.
    
####3. Uses descriptive activity names to name the activities in the data set
    
- Read in the list of six different activities.
- In the 'y' table, replace the numeric value with the activity name.

####4. Appropriately labels the data set with descriptive variable names.

- NOTE: As I am not a domain expert, I think the variable names in 'features.txt' 
- are adequately descriptive.
- Get the 'features' column names that have 'mean()' and 'std()' in them.
- Apply those column names to the table with 'mean()' and 'std()' values.
- Give names to the first two columns.
- Merge the subject column, activity column, and 'x' columns
    
####5. From the data set in step 4, creates a second, independent tidy data set 
####   with the average of each variable for each activity and each subject.
    
- Use dplyr to group the data by subject and activity and then take the mean
- for each variable for each group.
- Output the "tidy" data set to a file, space-separated.
- Return the final tidy data.
