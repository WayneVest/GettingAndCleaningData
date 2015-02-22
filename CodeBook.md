# GettingAndCleaningData - CodeBook
Programming assignment for the Johns Hopkins Getting And Cleaning Data course.
CodeBook deliverable - outlining the clean data and the steps to get there.
- - -

## What this document includes and excludes
The particular variables in this dataset, which start with tBody..., fBody... or tGravity..., are specifically detailed in the features_info.txt file located at the root of the 'UCI HAR Dataset' folder, and as such their meaning will not be described here. This document will, however, describe where each variable is sourced and, if required, how the values were derrived.

Where variables have been added to the dataset that were not part of the original dataset, they will be described in detail.

There are two datasets covered by this document:
- clean_combined_test_and_training.txt
- clean_combined_test_and_training_averages.txt

- - -

### clean_combined_test_and_training.txt
This dataset is a clean version of the raw data, including only measures that have both mean and standard deviation values.

There are variables described in the UCI HAR Dataset which will not be found in this dataset - this is intentional, as this dataset is only required to include the measurements that have mean AND standard deviation values (plus some other categorical variables such as 'subject' and 'activity').

#### Data cleaning

##### Raw data structure
The raw data set has a distributed structure, with the measurement data in one file (X_test.txt and X_train.txt), the measurement variable names in another file (features.txt), the subjects measured in yet another file (subject_test.txt and sibject_train.txt), the activities performed (represented by an integer) in a separate file again (y_test.txt and y_train.txt) and finally the mapping of the activities integer representations to actual activity names in a final file (activity_labels.txt). The total file list is as follows:
- activity_labels.txt
- features.txt
- X_test.txt
- y_test.txt
- subject_test.txt
- X_train.txt
- y_train.txt
- subject_train.txt

##### Step 1: Naming the measurement variables
Each row in the features.txt file contains the name of a column in the X_test.txt and X_train.txt files - the first row of features.txt represents the first column of X_test.txt/X_train.txt, the second row represents the second column, etc. 

A list of the feature names was subsetted from a data.frame that was created by reading in the features.txt file using read.table().

The list was then assigned as the names() list of a data.frame that was created by reading in the X_test.txt file using read.table(), and then repeated for X_train.txt.

##### Step 2: Selecting only the measurements that have mean and standard deviation variables
According to the features_info.txt file that comes with the raw data, features with mean values have 'mean()' as a part of the feature name, and features with standard deviation values have 'std()' as a part of the feature name.

There are some additional mean values associated with some features, and those features have 'Mean' as a part of their feature name - these were verified to not have a complimentary standtard deviation value and as such were excluded from the dataset.

To ensure the correct, and only the correct, variables are included in the dataset, 'select()' was used on the X_test.txt and X_train.txt data.frames, with the 'contains()' special function to include only those variables with 'mean()' or 'std()' in their name.

##### Step 3: Adding in the remaining variables
At this point we have a tidy dataset that includes only the measurement variables that have mean AND standard deviation values. This step will show how the subject, activity and type variables were bound to the data.frame.

For each observation in the X_test.txt and X_train.txt files, there is an observation in the subject_test.txt and subject_train.txt files respectively. This makes for a straight forward process of creating a new variable in the X_test.txt and X_train.txt data.frames (called 'subject') and doing a 1:1 mapping of data.frame row number to the subject_test.txt/subject_train.txt data.frame row number, assigning the value in the subject_test.txt/subject_train.txt data.frame row to the 'subject' column on the same row in the X_test.txt and X_train.txt data.frames.

The process for adding the 'activity' variable is similar, in that there is a corresponding row in the y_test.txt/y_train.txt data.frame for each observation in the X_test.txt/X_train.txt data.frame. The key difference here is that the value in the y_test.txt/y_train.txt file is an integer (1:6) that corresponds to a row in the activity_labels.txt file. This means that before assigning the value of the row in y_test.txt/y_train.txt to the X_test.txt/X_train.txt data.frame, the vaule needs to be translated from the integer to the corresponding string representation of the acitivy label in the activity_labels.txt file. This is done using a simple for loop and subsetting functions.

##### Step 4: Combine the datasets and output the result
This is done by rbind-ing the X_test.txt and X_train.txt dataframes and assigning them to a new data.frame variable ('combined').

The 'combined' data.frame is then written to file in the present working directory using write.table() as 'clean_combined_test_and_training.txt'.


#### Analysis
No analysis was performed on this dataset.


#### Variable definitions

##### tBodyAcc-mean()-X
- represents the [,1] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-mean()-Y
- represents the [,2] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.02029417

##### tBodyAcc-mean()-Z
- represents the [,3] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.1329051

##### tGravityAcc-mean()-X
- represents the [,41] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.9633961

##### tGravityAcc-mean()-Y
- represents the [,42] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.1408397

##### tGravityAcc-mean()-Z
- represents the [,43] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.1153749

##### tBodyAccJerk-mean()-X
- represents the [,81] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.07799634

##### tBodyAccJerk-mean()-Y
- represents the [,82] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.005000803

##### tBodyAccJerk-mean()-Z
- represents the [,83] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.06783081

##### tBodyGyro-mean()-X
- represents the [,121] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-mean()-Y
- represents the [,122] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-mean()-Z
- represents the [,123] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-mean()-X
- represents the [,161] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-mean()-Y
- represents the [,162] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-mean()-Z
- represents the [,163] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccMag-mean()
- represents the [,201] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAccMag-mean()
- represents the [,214] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerkMag-mean()
- represents the [,227] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroMag-mean()
- represents the [,240] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerkMag-mean()
- represents the [,253] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-mean()-X
- represents the [,266] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-mean()-Y
- represents the [,267] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-mean()-Z
- represents the [,268] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-mean()-X
- represents the [,345] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-mean()-Y
- represents the [,346] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-mean()-Z
- represents the [,347] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-mean()-X
- represents the [,424] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-mean()-Y
- represents the [,425] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-mean()-Z
- represents the [,426] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccMag-mean()
- represents the [,503] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyAccJerkMag-mean()
- represents the [,516] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroMag-mean()
- represents the [,529] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroJerkMag-mean()
- represents the [,542] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-std()-X
- represents the [,4] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-std()-Y
- represents the [,5] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-std()-Z
- represents the [,6] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAcc-std()-X
- represents the [,44] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAcc-std()-Y
- represents the [,45] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAcc-std()-Z
- represents the [,46] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerk-std()-X
- represents the [,84] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerk-std()-Y
- represents the [,85] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerk-std()-Z
- represents the [,86] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-std()-X
- represents the [,124] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-std()-Y
- represents the [,125] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-std()-Z
- represents the [,126] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-std()-X
- represents the [,164] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-std()-Y
- represents the [,165] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-std()-Z
- represents the [,166] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccMag-std()
- represents the [,202] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAccMag-std()
- represents the [,215] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerkMag-std()
- represents the [,228] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroMag-std()
- represents the [,241] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerkMag-std()
- represents the [,254] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-std()-X
- represents the [,269] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-std()-Y
- represents the [,270] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-std()-Z
- represents the [,271] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-std()-X
- represents the [,348] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-std()-Y
- represents the [,349] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-std()-Z
- represents the [,350] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-std()-X
- represents the [,427] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-std()-Y
- represents the [,428] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-std()-Z
- represents the [,429] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccMag-std()
- represents the [,504] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyAccJerkMag-std()
- represents the [,517] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroMag-std()
- represents the [,530] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroJerkMag-std()
- represents the [,543] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### type
- denotes whether the observation was originally from the '.../UCI HAR Dataset/test/X_test.txt' ('test') or '.../UCI HAR Dataset/train/X_train.txt' ('train') file.
- class = factor
- values = 2 levels: 'test', 'train'

##### subject
- represents the [,] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = integer
- example value = 1 

##### activity
- represents the [,] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = character
- values = 'WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING'

- - - 

### clean_combined_test_and_training_averages.txt
This dataset is based on the clean_combined_test_training.txt dataset, but si reduced to the mean values for each variable, where the subject and activity are the same.


#### Data cleaning
The starting dataset was already tidy, as such no further cleaning was conducted.


#### Analysis

##### Step 1: Persisting data
An empty data.frame is created to store the rows of values of computed means. The below steps will introduce certain looping constructs to determine the appropriate values, and as such this data.frame variable is initaised at a higher stack frame, and therefore has a scope beyond the looping constructs.

##### Step 2: Looping, generating values and storing them
In this step, the original dataset is iterated over with a nested loop. The outer loop iterates on subject and the inner loop iterates on activity, thereby giving unique subject and activity variables for use in filtering out the undesired observations that is then stored in a new data.frame.

With the desired observations obtained, 'colmeans()' is used to obtain a vector of the means of each column across the filtered observations.

This vector is then coerced to a temporary data.frame, which has the means as observations and the variable names as row names. This temporary data.frame is then transposed using 't()', which results in appropriately named variables, but with a default rowname repeated across all rows; 'rownames()' is used to set the temporary data.frame rownames to 'NULL'.

The additional variables are added to the data.frame using 'cbind()', leveraging the subject and activity variables defined by the looping mechanism to fill the 'subject' and 'activity' variables. The 'type' variable is filled by calling on the first observation in the abovementioned filtered observation data.frame and copying the value from the 'type' column. This is deemed reliable as the documentation from the original raw data specifies that the subjects are split 70:30 across training:test observations - no subjects do both training and test exercises.

With the temporary data.frame structure now matching the empty data.frame created at Step 1, the observations in the temporary data.frame are concatenated into the persistent data.frame, which thereby collects all observations across all loop iterations.

##### Step 4: Output the result
The persistent data.frame is written to file in the present working directory using write.table() as 'clean_combined_test_and_training_averages.txt'.


#### Variable definitions

##### tBodyAcc-mean()-X
- represents the mean for subject and activity, of the [,1] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-mean()-Z
- represents the mean for subject and activity, of the [,3] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.1329051

##### tGravityAcc-mean()-X
- represents the mean for subject and activity, of the [,41] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.9633961

##### tGravityAcc-mean()-Y
- represents the mean for subject and activity, of the [,42] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.1408397

##### tGravityAcc-mean()-Z
- represents the mean for subject and activity, of the [,43] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.1153749

##### tBodyAccJerk-mean()-X
- represents the mean for subject and activity, of the [,81] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.07799634

##### tBodyAccJerk-mean()-Y
- represents the mean for subject and activity, of the [,82] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.005000803

##### tBodyAccJerk-mean()-Z
- represents the mean for subject and activity, of the [,83] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = -0.06783081

##### tBodyGyro-mean()-X
- represents the mean for subject and activity, of the [,121] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-mean()-Y
- represents the mean for subject and activity, of the [,122] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-mean()-Z
- represents the mean for subject and activity, of the [,123] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-mean()-X
- represents the mean for subject and activity, of the [,161] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-mean()-Y
- represents the mean for subject and activity, of the [,162] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-mean()-Z
- represents the mean for subject and activity, of the [,163] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccMag-mean()
- represents the mean for subject and activity, of the [,201] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAccMag-mean()
- represents the mean for subject and activity, of the [,214] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerkMag-mean()
- represents the mean for subject and activity, of the [,227] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroMag-mean()
- represents the mean for subject and activity, of the [,240] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerkMag-mean()
- represents the mean for subject and activity, of the [,253] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-mean()-X
- represents the mean for subject and activity, of the [,266] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-mean()-Y
- represents the mean for subject and activity, of the [,267] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-mean()-Z
- represents the mean for subject and activity, of the [,268] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-mean()-X
- represents the mean for subject and activity, of the [,345] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-mean()-Y
- represents the mean for subject and activity, of the [,346] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-mean()-Z
- represents the mean for subject and activity, of the [,347] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-mean()-X
- represents the mean for subject and activity, of the [,424] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-mean()-Y
- represents the mean for subject and activity, of the [,425] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-mean()-Z
- represents the mean for subject and activity, of the [,426] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccMag-mean()
- represents the mean for subject and activity, of the [,503] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyAccJerkMag-mean()
- represents the mean for subject and activity, of the [,516] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroMag-mean()
- represents the mean for subject and activity, of the [,529] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroJerkMag-mean()
- represents the mean for subject and activity, of the [,542] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-std()-X
- represents the mean for subject and activity, of the [,4] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-std()-Y
- represents the mean for subject and activity, of the [,5] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAcc-std()-Z
- represents the mean for subject and activity, of the [,6] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAcc-std()-X
- represents the mean for subject and activity, of the [,44] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAcc-std()-Y
- represents the mean for subject and activity, of the [,45] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAcc-std()-Z
- represents the mean for subject and activity, of the [,46] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerk-std()-X
- represents the mean for subject and activity, of the [,84] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerk-std()-Y
- represents the mean for subject and activity, of the [,85] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerk-std()-Z
- represents the mean for subject and activity, of the [,86] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-std()-X
- represents the mean for subject and activity, of the [,124] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-std()-Y
- represents the mean for subject and activity, of the [,125] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyro-std()-Z
- represents the mean for subject and activity, of the [,126] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-std()-X
- represents the mean for subject and activity, of the [,164] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-std()-Y
- represents the mean for subject and activity, of the [,165] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerk-std()-Z
- represents the mean for subject and activity, of the [,166] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccMag-std()
- represents the mean for subject and activity, of the [,202] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tGravityAccMag-std()
- represents the mean for subject and activity, of the [,215] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyAccJerkMag-std()
- represents the mean for subject and activity, of the [,228] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroMag-std()
- represents the mean for subject and activity, of the [,241] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### tBodyGyroJerkMag-std()
- represents the mean for subject and activity, of the [,254] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-std()-X
- represents the mean for subject and activity, of the [,269] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-std()-Y
- represents the mean for subject and activity, of the [,270] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAcc-std()-Z
- represents the mean for subject and activity, of the [,271] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-std()-X
- represents the mean for subject and activity, of the [,348] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-std()-Y
- represents the mean for subject and activity, of the [,349] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccJerk-std()-Z
- represents the mean for subject and activity, of the [,350] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-std()-X
- represents the mean for subject and activity, of the [,427] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-std()-Y
- represents the mean for subject and activity, of the [,428] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyGyro-std()-Z
- represents the mean for subject and activity, of the [,429] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyAccMag-std()
- represents the mean for subject and activity, of the [,504] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyAccJerkMag-std()
- represents the mean for subject and activity, of the [,517] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroMag-std()
- represents the mean for subject and activity, of the [,530] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### fBodyBodyGyroJerkMag-std()
- represents the mean for subject and activity, of the [,543] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = numeric
- example value = 0.2885845

##### type
- denotes whether the observation was originally from the '.../UCI HAR Dataset/test/X_test.txt' ('test') or '.../UCI HAR Dataset/train/X_train.txt' ('train') file.
- class = factor
- values = 2 levels: 'test', 'train'

##### subject
- represents the [,] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = integer
- example value = 1 

##### activity
- represents the [,] variable found in either the '.../UCI HAR Dataset/test/X_test.txt' or '.../UCI HAR Dataset/train/X_train.txt' files.
- class = character
- values = 'WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING'
