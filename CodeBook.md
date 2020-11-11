HOW TO
To build X_df:
- Merge X_Train and X_test into one dataset X_df with rbind to add X_test rows after X_train rows
- Use feature.txt provided in the raw data. Filter this to extract only the labels of the mean and standard variation for each feature and their number
- Select from X_df only the columns matching with the prefiltered labels
- Merge Y_train and Y_test into one dataset Y_df with rbind to add Y_test rows after Y_train rows
- Y_df provide for each X_df row, the id of the activity tested.Merge X_df and Y_df on row.names into X_df
- activity_labels.txt provide the label for activity ids in Y_df
- Merge X_df and activity_labels (firstly charged into a dataset)
- Merge subject_train and subject_test into subject_Id with rbind to add subject_test rows after subject_train rows
- subject_Id provide for each row of X_df the id of the subject tested. Merge X_df and subject_Id into X_df
- Then is X_df done and tidy

To build averageX_d:
- Use ddplyr summarise_all function, first group by the subject id and the activity label
- Get rid of column you don't need with the dplyr select function
- Then is averageX_df done and tidy

VARIABLES
Here is a description of the features tested:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration 
signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

In X_df for each of the 17 features listed above we can understand variables like:
- the mean value so variable is named after this pattern Feature-mean()
- the standard deviation so variable is named after this pattern Feature-std()
- Except for the mag (Mag), all features are 3 dimensional vectors so we have one variable in each direction named after this pattern Feature-mean()-X

In averageX_df the variables are the same name as in X_df but the value is the average of the data from X_df grouped by each subject on each activity

We added these variables:
- subjectId: the ID of the subject tested
- label: the activity tested