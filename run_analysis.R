## The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is 
## available at the site where the data was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##** Set up environment and data **##
# Check if dplyr has been installed, and if not, install it
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
# Load (or re-load) the dplyr library
library(dplyr)

# Read in activity labels and feature names
activities = read.table('./UCI HAR Dataset/activity_labels.txt')
features = read.table('./UCI HAR Dataset/features.txt')

# Read in the training data files
train = read.table('./UCI HAR Dataset/train/X_train.txt')
train_activities = read.table('./UCI HAR Dataset/train/y_train.txt')
train_subject = read.table('./UCI HAR Dataset/train/subject_train.txt')

# Read in the test data files
test = read.table('./UCI HAR Dataset/test/X_test.txt')
test_activities = read.table('./UCI HAR Dataset/test/y_test.txt')
test_subject = read.table('./UCI HAR Dataset/test/subject_test.txt')


##** Fulfill objective #3: Uses descriptive activity names to name the activities in the data set. **##
# Give each column a meaningful name
# This is straight forward as the features.txt file has one record for each column in the X_train.txt and X_testl.txt files
colnames(train) = features$V2
colnames(test) = features$V2


##** Fulfill objective #2: Extracts only the measurements on the mean and standard deviation for each measurement. **##
# Remove all duplicate columns - I checked that the duplicate column names do not contain 'mean' or 'std'
# This step is necessary as at least some of the dplyr methods ('verbs') do not operate if there are duplicate column names in the data.frame 
train = train[!duplicated(names(train))]
test = test[!duplicated(names(test))]

# Now we can use dplyr's 'select()' to select only the columns that contain either a mean ('mean()') or standard deviation ('std()')
# The features_info.txt file specifies that features that represent mean or standard devivation values have names including 'mean()' or 'std()', plus several
# features that include 'Mean' in their name.
# NOTE: I chose not to include the additional 'Mean' features as the assignment instructions are not particularly clear on this matter, but do say 'mean AND 
# standard deviation for each measurement', which if taken literally implies that the measurement must have both a mean and a std value, and the additional
# 'Mean' values do not include a complimentary standard deviation value.  
# NOTE: I chose to do these operations before merging in an attempt to make future mutations asymptotically faster (reduce the size of the dataset).
train = select(train, contains('mean()'), contains('std()'))
test = select(test, contains('mean()'), contains('std()'))


##** Fulfill objective #4: Appropriately labels the data set with descriptive variable names. **##
# Add a column for the type of observation (and the value), the subject that was observed (with NAs) and the activity that was observed (with NAs)
# NOTE: I chose to include a column specifying whether the observation came from a test or train 'type' file in case it becomes important in the future
train = cbind(train, type='train', subject=NA, activity=NA)
test = cbind(test, type='test', subject=NA, activity=NA)

# Add the subject data to the subject column in each data set (replace the NAs)
# NOTE: I chose to do this before merging to keep the operation simple - the subject_train.txt and subject_test.txt files have a subject observation for each 
# observation in the X_test.txt and X_train.txt files - a straight match
train$subject = train_subject$V1
test$subject = test_subject$V1

# Add the activity name in the activity column in each data set (replace the NAs)
# NOTE: Essentially the idea is to match an activity observation to the dataset observations and resolve to an activity name. This is done by looping over each 
# observation in the X_train.txt and X_test.txt datasets, and for each one look at the equivilent observation in the associated y_train.txt and y_test.txt 
# files (there is an activity observation for each X_test.txt/X_train.txt observation). These y_... observations are a number (1-6) which them maps to a row in
# the activity_labels.txt file (there are only six rows, each with a unique name), so we then resolve the acitvity number from the y_... file to the activity 
# name in the activity_labels.txt file and put the name into the datasets.
for(observation in 1:nrow(train)){
    # Index to the element at the current row, and the 'activity' column, then assign that attribute the char vector obtained by using the attribute in the 
    # train_activites dataset at the same row index (there is only one column), and using that number to index into the activities name list rows then taking 
    # the value from the 'V2' column.
    train[observation,'activity'] = as.vector(activities[train_activities[observation,],"V2"])
}
for(observation in 1:nrow(test)){
    # Repeat for the test dataset.
    test[observation,'activity'] = as.vector(activities[test_activities[observation,],"V2"])
}


##** Fulfill objective #1: Merges the training and the test sets to create one data set. **##
# Create a new data.frame by concatenating the rows from the train data.frame with the rows from the test data.frame and assigning the result to a new var name
combined = rbind(train, test)


##** Produce the txt file to upload **##
# Write the dataset out to a file
write.table(combined, './clean_combined_test_and_training.txt', row.names=FALSE)


##** Fulfil objective #5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each
# subject. **##
# Create a new data.frame that looks like the combined one, but is empty and ready to receive values. 
# This is needed to persist values out of the below loops.
averages = combined[0,]

# Loop through each subject...
for(this_subject in unique(combined$subject)){
    # ...and loop through each activity done by that subject.
    # Here we filter combined to only this subject's observations, then select only the values in the 'activity' column, then derive a list of unique values.
    # We then loop through those values (activities).
    for(this_activity in unique(select(filter(combined, subject == this_subject), activity))[,'activity']){
        # We then filter out all the rows that are not for 'this' subject and 'this' activity combination.
        var_filtered = filter(combined, subject == this_subject & activity == this_activity)
        
        # Calculate the means on columns 1:66; in this case the colMeans function returns a named numeric vector, so we need to convert that to a data.frame.
        # The resulting data frame has the means as observations (rows), with the numeric vector names as rownames and an undesired column name, so we use t()
        # (the transpose function) to transpose the rows with the columns...
        var = t(as.data.frame(colMeans(var_filtered[1:66])))
        # ...and get rid of the rownames (which was the undesired column name before we transposed). Doing this results in the final data.frame having the 
        # column and row structure of the original 'averages' data.frame (which inherited the structre from the 'combined' data.frame).
        rownames(var) = NULL
        
        # Add the type, subject and activity columns into the data frame and fill the data.
        # NOTE: the README.txt file states that subjects are in either the test or train groups, but not in both, so type is still valid and maybe useful.
        # Here, for convenience, we are taking the 'type' value from the first observation in the filtered data.frame, but all observations in the same filter
        # instance would have the same value. The 'as.vector()' call is just to ensure we are getting a char vector (string) for the value.
        var = cbind(var, type = as.vector(var_filtered[1,'type']), subject = this_subject, activity = this_activity)
        
        # Append the rows from the temporary data frame to the averages data frame, and restart the loop (unless it is the last loop)
        averages = rbind(averages, var)
    }
}

##** Produce the txt file to upload **## 
write.table(averages, './clean_combined_test_and_training_averages.txt', row.names=FALSE)