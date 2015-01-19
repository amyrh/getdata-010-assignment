==================================================================
Coursera Getting and Cleaning Data Assignment 
Version 1.0
==================================================================

Usage:
Execute the run_analysis.R script in the same directory as the extracted "UCI HAR Dataset" folder. The script will execute and generate a text file "outputTidyData.txt".

Description:
The script performs the following actions:
1. read the activity_labels.txt file into a data frame 'activities'
2. read the features.txt file into a data frame 'features'
3. read the subject_train.txt file into a data frame 'subject_train'
4. read the x_train.txt file into a data frame 'x_train', setting colum names to be as was read in in step 2.
5. read the y_train.txt file into a data frame 'y_train'
6. create a data frame 'trainingData' where the first column is sourced from 'subject_train', the second column from 'y_train', and the remaining columns from 'x_train'. Each row now represents one compete record of observations.
7. Merge with 'activities' by TrainingLabel to add the textual description of the activity for each record
8. Repeat steps 3-7 on the test data, resulting int the 'testData' data frame, which contains all of the same columns as the 'trainingData' data frame.
9. Use rBind to combine 'trainingData' and 'testData' into a single data frame called 'allData'
10. Load 'allData' into a dplyr data table 'allDataTbl' to give access to dplyr manipulation functions
11. select only measurements on mean and standard deviation for each measurement. 
    From reading "features_info.txt" I took this to mean only columns with names containing "mean()" or "std()". After loading into the data frame, the column names were cleansed, so I searched for column names containing ".mean.." and ".std.." instead of the original "-mean()" and "-std()". This results in the data table 'meanAndStd' which contains only SubjectID, Activity, and columns representing mean and standard deviation.
12. Summarise the data by calling mean() on every column, grouped by Activity and SubjectID
13. Write the resulting data frame to output file outputTidyData.txt