CookBook
========

## Input
Script automatically download UCI dataset data and extract it to working directory.

## Output
Resulting tidy dataset created in working directory by script. It includes mean and std variables 
```
"fBodyAcc", "fBodyAccJerk", "fBodyAccMag", "fBodyBodyAccJerkMag", "fBodyBodyGyroJerkMag", "fBodyBodyGyroMag", "fBodyGyro", "label", "subject", "tBodyAcc", "tBodyAccJerk", "tBodyAccJerkMag", "tBodyAccMag", "tBodyGyro", "tBodyGyroJerk", "tBodyGyroJerkMag", "tBodyGyroMag", "tGravityAcc", "tGravityAccMag"
```

## Transformation

1. Load each file from archive to own dataset
1. Merge all dataset into single dataset and add column labels
1. Create dataset where columns with (mean or std) appear
1. Calculate mean and group by subject/activity
2. Write comma-separated file to 'tidy_data.txt'
