# GettingAndCleaningData
Programming assignment for the Johns Hopkins Getting And Cleaning Data course.

The script in this repo is designed to produce the means of a particular data set.

For your convenience, there is only one script (run_analysis.R - here: https://github.com/WayneVest/GettingAndCleaningData/blob/master/run_analysis.R), which will automatically run when sourced.

The script first creates a tidy data set from the raw data obtained at this URI: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once the data is tidy, a new data set is derived that contains fewer observations, which represent the means of the tidied original data, on a per-subject, per-activity basis.

The script requires the R dplyr package, which the script will install if it isn't already installed. The script will then load the dplyr library and proceed to run.

It is expected that the obtained raw data is un-zipped into the present working directory root and has the following structure:
<div>
├── UCI HAR Dataset
│   ├── README.txt
│   ├── activity_labels.txt
│   ├── features.txt
│   ├── features_info.txt
│   ├── test
│   │   ├── Inertial Signals                        <-- NOTE: this directory and its contents are not required
│   │   │   ├── body_acc_x_test.txt
│   │   │   ├── body_acc_y_test.txt
│   │   │   ├── body_acc_z_test.txt
│   │   │   ├── body_gyro_x_test.txt
│   │   │   ├── body_gyro_y_test.txt
│   │   │   ├── body_gyro_z_test.txt
│   │   │   ├── total_acc_x_test.txt
│   │   │   ├── total_acc_y_test.txt
│   │   │   └── total_acc_z_test.txt
│   │   ├── X_test.txt
│   │   ├── subject_test.txt
│   │   └── y_test.txt
│   └── train
│       ├── Inertial Signals                        <-- NOTE: this directory and its contents are not required
│       │   ├── body_acc_x_train.txt
│       │   ├── body_acc_y_train.txt
│       │   ├── body_acc_z_train.txt
│       │   ├── body_gyro_x_train.txt
│       │   ├── body_gyro_y_train.txt
│       │   ├── body_gyro_z_train.txt
│       │   ├── total_acc_x_train.txt
│       │   ├── total_acc_y_train.txt
│       │   └── total_acc_z_train.txt
│       ├── X_train.txt
│       ├── subject_train.txt
│       └── y_train.txt
├── clean_combined_test_and_training.txt             <-- NOTE: output file for the original tidy data
├── clean_combined_test_and_training_averages.txt    <-- NOTE: output file for the derived (and also tidy) data
</div>

The script outputs two files into the present working directory:
- the orginal tidy data as clean_combined_test_and_training.txt
- the derived (and also tidy) data as clean_combined_test_and_training_averages.txt
