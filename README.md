README for the run_analysis.R script:
=====================================
Name of the Script: run_analysis.R

This script is for reading and cleaning the data from the measurements of acceleration and angular velocity while performing various activities monitored by Samsung Smartphone. 

List of steps:
1. Reading all the training and test data from the study containing the subject IDs, Activity ID and corresponding measurements, mean and standard deviation.  
2. Reading the files containing the list of features and Activities. The features file contain the names of the column names for the measurements.  
3. The script then add the column names to the subject (mySubjectTest & mySubjectTrain) and Activity (myyTest & myyTrain) as 'VolunteerID' and 'Activity',respectively.  
4. Then the script replaces the Activity ID to the corresponding name of the Activity in the Activity objects (myyTest & myyTrain).  
5. The next steps involve extracting the list of column names of the variables from features (myFeaturesNames) and convert them into a list (myFeaturesNamesList).  
6. The names of the variables contain some extraneous characters such as -,() etc and these were removed from the list by using gsub or sub. Changed the style of the variable to camelCase. For eg. the variable 'tBodyAcc-mean()-X' was converted to 'tBodyAccMeanX'.   
7. The next step added the variable names (myFeaturesNamesList1) to the training (myxTrain)and test (myxTest) data.  

8.The next step involve merging the subject (mySubjectTrain) and Activity (myyTrain) data frame  to the training data -myxTrain to generate a data frame called mytraindf. This was accomplished using the cbind() function. Similarly, the test data also merged.  
9. Next, the training and test dataset containing the variable names and data were merged into one dataset called myAlldf. This has 563 columns with 10299 observations.  
10. The next step involve extracting the mean and standard deviation of all the measurements along with subject IDs and Activity. The resulting data frame -myAllMeanStdDF contains 88 variables with 10299 observations.  
11. The next involve calculating the average of Means and Standard deviation for each activity and subject. This resulted in 180 rows and 86 averages for all mean and standard deviation of measurements.  
12. The resulting data table was exported into a text file called 'myTidyData'.  

