Code Book - 

This file contains description of the variables, the data, and any transformations or work that I performed to clean up the original data in "UCI HAR Dataset".

In the analysis conducted in "run_analysis", my goal was to produce two data frames: 1) a large data frame which merged the training and test data obtained in the original experiment (See UCI HAR Dataset/READ ME.txt for the detail) and 2) a smaller data frame which shows the average of each variable for each activity and each subject. The first data frame is named as "data" and the second data frame as "subjectactivity" in the R script "run_analysis.R".

- subject: It identifies a volunteer in the group of 30 within an age bracket of 19-48 year.

- activity: It identifies one of 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) performed while wearing a smartphone (Samsung Galaxy S II) on the waist.

- tBodyAcc-mean()-X - fBodyBodyGyroMag-std() : They indicate the mean and standard deviation related measurements obtained from embedded accelerometer and gyroscope during the experiment.
