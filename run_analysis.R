#Name of the Script -run_analysis.R
#Require plyr and data.table package

# The script - run_analysis.R take a list of files having data collected from the 
# study of six activities wearing a Samsung smartphone that have an embedded 
# accerometer and gyroscope. The script imports the data from the training and 
# test datasets and merge them into one dataset containing the all the measurements data, 
# mean, standard deviation, names of the activities for all the 30 subjects. 
# From the merged dataset the average of all measurements mean and standard 
# deviation per activities per subject were dertermined. The results were exported to
# a text file called 'myTidyData.txt' into the current working directory.

require(plyr)
require(data.table)


#Reading test files
mySubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)
myxTest <- read.table("./UCI HAR Dataset/test/x_test.txt",sep="",header=FALSE)
myyTest <- read.table("./UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)

#Reading training files

mySubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
myxTrain <- read.table("./UCI HAR Dataset/train/x_train.txt",sep="",header=FALSE)
myyTrain <- read.table("./UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)

#Reading features and activity files containing list of measurements variable
# names and activity names

myFeatures <- read.table("./UCI HAR Dataset/features.txt",sep="",header=FALSE)
myActivityLabel <-read.table("./UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)

#Adding Column name to subject_test and subject_train as Volunteer_ID

names(mySubjectTest)[1]<-"VolunteerID"
names(mySubjectTrain)[1]<-"VolunteerID"


#Adding Column name to myyTest and myyTrain as Activity

names(myyTest)[1]<-"Activity"
names(myyTrain)[1]<-"Activity"

#Changing the Activity ID with Activity name in myyTest and myytrain

myyTest1<- data.frame(Activity=myActivityLabel[match(myyTest$Activity, myActivityLabel$V1), 2])
myyTrain1<- data.frame(Activity=myActivityLabel[match(myyTrain$Activity, myActivityLabel$V1), 2])


#Extracting the variable names from features

myFeaturesNames <-myFeatures$V2
myFeaturesNamesList <-as.character(t(myFeaturesNames))

#Removing the extraneous characters like -,() etc from the features names ie variable names

myFeaturesNamesList1 <- gsub('-',"",myFeaturesNamesList)
myFeaturesNamesList1 <- gsub("\\(","",myFeaturesNamesList1)
myFeaturesNamesList1 <- gsub("\\)","",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("mean","Mean",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("mad","Mad",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("std","Std",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("min","Min",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("max","Max",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("sma","Sma",myFeaturesNamesList1)
myFeaturesNamesList1 <- sub("\\,","_",myFeaturesNamesList1)

#Adding Column name to myxtest as Activity

names(myxTest) <-myFeaturesNamesList1
names(myxTrain) <-myFeaturesNamesList1

#Combining Subjects, Activities and measurements into one dataframe

mytestdf <-cbind(mySubjectTest,myyTest1,myxTest)
mytraindf <-cbind(mySubjectTrain,myyTrain1,myxTrain)

#combining test and training datasets into one dataset

myAlldf <-rbind(mytestdf,mytraindf)

#Extracting only mean and standard deviation of all measurements

PartialFeature <-c("Volunteer|Activity|Mean|Std")

myAllMeanStdDF<- myAlldf[,grep(PartialFeature, colnames(myAlldf))] 

# converting the AllMeanStdDF data frame to a data table
myAllMeanStdDT <-data.table(myAllMeanStdDF)

# Getting the average of all measurements based on each subject and activity

myTidyData <- ddply(myAllMeanStdDT, .(VolunteerID,Activity), numcolwise(mean))

# Upload the tidydata into a file

write.table(myTidyData,file="myTidyData.txt",row.names=FALSE,sep=",")

