#Getting and Cleaning Data Course Project

##Instructions for project

>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[Project Details](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

 [project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following.

    1 Merges the training and the test sets to create one data set.
    2 Extracts only the measurements on the mean and standard deviation for each measurement.
    3 Uses descriptive activity names to name the activities in the data set
    4 Appropriately labels the data set with descriptive variable names.
    5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


	
##1. Get the data

####1.1 Download the file and put the file in the data folder

> if(!file.exists("./data")){dir.create("./data")}
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

####1.2 Unzip the file

> unzip(zipfile="./data/Dataset.zip",exdir="./data")

####1.3 unzipped files are in the folderUCI HAR Dataset. Get the list of the files

> path_rf <- file.path("./data" , "UCI HAR Dataset")
> files<-list.files(path_rf, recursive=TRUE)


##2. Read data from the files into the variables

####2.1 Read the Activity files

> dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
> dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

####2.2 Read the Subject files

> dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
> dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

####2.3 Read Fearures files

> dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
> dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


#####Look at the properties of the above varibles (we are showing only few lines of o/p)

* str(dataActivityTest)

> 'data.frame':    2947 obs. of  1 variable:
> $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

* str(dataActivityTrain)

> 'data.frame':    7352 obs. of  1 variable:
>  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

* str(dataSubjectTrain)

> 'data.frame':    7352 obs. of  1 variable:
>  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...

* str(dataSubjectTest)

> 'data.frame':    2947 obs. of  1 variable:
> $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

* str(dataFeaturesTest)

> 'data.frame':    2947 obs. of  561 variables:
> $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
> $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
  
##   [list output truncated]

* str(dataFeaturesTrain)

> 'data.frame':    7352 obs. of  561 variables:
>  $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
>  $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
>  $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
  
##   [list output truncated]


#Assignment Steps

##Merges the training and the test sets to create one data set

####1.Concatenate the data tables by rows

> dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
> dataActivity<- rbind(dataActivityTrain, dataActivityTest)
> dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

####2.set names to variables

> names(dataSubject)<-c("subject")
> names(dataActivity)<- c("activity")
> dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
> names(dataFeatures)<- dataFeaturesNames$V2

####3.Merge columns to get the data frame Data for all data

> dataCombine <- cbind(dataSubject, dataActivity)
> Data <- cbind(dataFeatures, dataCombine)

Extracts only the measurements on the mean and standard deviation for each measurement

    Subset Name of Features by measurements on the mean and standard deviation

i.e taken Names of Features with “mean()” or “std()”

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

    Subset the data frame Data by seleted names of Features

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

    Check the structures of the data frame Data

str(Data)

 'data.frame':    10299 obs. of  68 variables:
  $ tBodyAcc-mean()-X          : num  0.289 0.278 0.28 0.279 0.277 ...
  $ tBodyAcc-mean()-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
  $ tBodyAcc-mean()-Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
  $ tBodyAcc-std()-X           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
  $ tBodyAcc-std()-Y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
  $ tBodyAcc-std()-Z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
  $ tGravityAcc-mean()-X       : num  0.963 0.967 0.967 0.968 0.968 ...
  $ tGravityAcc-mean()-Y       : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
  $ tGravityAcc-mean()-Z       : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
  $ tGravityAcc-std()-X        : num  -0.985 -0.997 -1 -0.997 -0.998 ...
  $ tGravityAcc-std()-Y        : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
  $ tGravityAcc-std()-Z        : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
  $ tBodyAccJerk-mean()-X      : num  0.078 0.074 0.0736 0.0773 0.0734 ...
  $ tBodyAccJerk-mean()-Y      : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
  $ tBodyAccJerk-mean()-Z      : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
  $ tBodyAccJerk-std()-X       : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
  $ tBodyAccJerk-std()-Y       : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
  $ tBodyAccJerk-std()-Z       : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
  $ tBodyGyro-mean()-X         : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
  $ tBodyGyro-mean()-Y         : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
  $ tBodyGyro-mean()-Z         : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
  $ tBodyGyro-std()-X          : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
  $ tBodyGyro-std()-Y          : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
  $ tBodyGyro-std()-Z          : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
  $ tBodyGyroJerk-mean()-X     : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
  $ tBodyGyroJerk-mean()-Y     : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
  $ tBodyGyroJerk-mean()-Z     : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
  $ tBodyGyroJerk-std()-X      : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
  $ tBodyGyroJerk-std()-Y      : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
  $ tBodyGyroJerk-std()-Z      : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
  $ tBodyAccMag-mean()         : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
  $ tBodyAccMag-std()          : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
  $ tGravityAccMag-mean()      : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
  $ tGravityAccMag-std()       : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
  $ tBodyAccJerkMag-mean()     : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
  $ tBodyAccJerkMag-std()      : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
  $ tBodyGyroMag-mean()        : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
  $ tBodyGyroMag-std()         : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
  $ tBodyGyroJerkMag-mean()    : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
  $ tBodyGyroJerkMag-std()     : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
  $ fBodyAcc-mean()-X          : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
  $ fBodyAcc-mean()-Y          : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
  $ fBodyAcc-mean()-Z          : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
  $ fBodyAcc-std()-X           : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
  $ fBodyAcc-std()-Y           : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
  $ fBodyAcc-std()-Z           : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
  $ fBodyAccJerk-mean()-X      : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
  $ fBodyAccJerk-mean()-Y      : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
  $ fBodyAccJerk-mean()-Z      : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
  $ fBodyAccJerk-std()-X       : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
  $ fBodyAccJerk-std()-Y       : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
  $ fBodyAccJerk-std()-Z       : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
  $ fBodyGyro-mean()-X         : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
  $ fBodyGyro-mean()-Y         : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
  $ fBodyGyro-mean()-Z         : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
  $ fBodyGyro-std()-X          : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
  $ fBodyGyro-std()-Y          : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
  $ fBodyGyro-std()-Z          : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
  $ fBodyAccMag-mean()         : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
  $ fBodyAccMag-std()          : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
  $ fBodyBodyAccJerkMag-mean() : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
  $ fBodyBodyAccJerkMag-std()  : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
  $ fBodyBodyGyroMag-mean()    : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
  $ fBodyBodyGyroMag-std()     : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
  $ fBodyBodyGyroJerkMag-mean(): num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
  $ fBodyBodyGyroJerkMag-std() : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
  $ subject                    : int  1 1 1 1 1 1 1 1 1 1 ...
  $ activity                   : int  5 5 5 5 5 5 5 5 5 5 ...

Uses descriptive activity names to name the activities in the data set

1.Read descriptive activity names from “activity_labels.txt”

activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

    facorize Variale activity in the data frame Data using descriptive activity names

    check

head(Data$activity,30)

  [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
  [8] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
 [15] STANDING STANDING STANDING STANDING STANDING STANDING STANDING
 [22] STANDING STANDING STANDING STANDING STANDING STANDING SITTING 
 [29] SITTING  SITTING 
 6 Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS ... LAYING

Appropriately labels the data set with descriptive variable names

In the former part, variables activity and subject and names of the activities have been labelled using descriptive names.In this part, Names of Feteatures will labelled using descriptive variable names.

    prefix t is replaced by time
    Acc is replaced by Accelerometer
    Gyro is replaced by Gyroscope
    prefix f is replaced by frequency
    Mag is replaced by Magnitude
    BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

check

names(Data)

  [1] "timeBodyAccelerometer-mean()-X"                
  [2] "timeBodyAccelerometer-mean()-Y"                
  [3] "timeBodyAccelerometer-mean()-Z"                
  [4] "timeBodyAccelerometer-std()-X"                 
  [5] "timeBodyAccelerometer-std()-Y"                 
  [6] "timeBodyAccelerometer-std()-Z"                 
  [7] "timeGravityAccelerometer-mean()-X"             
  [8] "timeGravityAccelerometer-mean()-Y"             
  [9] "timeGravityAccelerometer-mean()-Z"             
 [10] "timeGravityAccelerometer-std()-X"              
 [11] "timeGravityAccelerometer-std()-Y"              
 [12] "timeGravityAccelerometer-std()-Z"              
 [13] "timeBodyAccelerometerJerk-mean()-X"            
 [14] "timeBodyAccelerometerJerk-mean()-Y"            
 [15] "timeBodyAccelerometerJerk-mean()-Z"            
 [16] "timeBodyAccelerometerJerk-std()-X"             
 [17] "timeBodyAccelerometerJerk-std()-Y"             
 [18] "timeBodyAccelerometerJerk-std()-Z"             
 [19] "timeBodyGyroscope-mean()-X"                    
 [20] "timeBodyGyroscope-mean()-Y"                    
 [21] "timeBodyGyroscope-mean()-Z"                    
 [22] "timeBodyGyroscope-std()-X"                     
 [23] "timeBodyGyroscope-std()-Y"                     
 [24] "timeBodyGyroscope-std()-Z"                     


Creates a second,independent tidy data set and ouput it

In this part,a second, independent tidy data set will be created with the average of each variable for each activity and each subject based on the data set in step 4.

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)