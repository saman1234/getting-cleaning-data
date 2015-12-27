The aim of tidy-uci-har is to create a tidy version of the UCI HAR dataset for the "Getting and Cleaning Data" course offered August 4-31, 2014 on Coursera.

###Files

   1. README.md : describing the overall repository.
   2. CodeBook.md : code book for the data set produced by the tidying process.
   3. run_analysis.R : the main analysis script performing the specified data tidying tasks.
   4. tidydata.txt : sample output from the run_analysis.R script included in the repository for completeness.
	
	
		
### Steps to execute files in this repo:

##### Attention :
Our code run_analysis.R does not download the file. Please do the following before running the script:

1. Download the data folder
2. Unzip the data folder
3. Set the working directory of your R environment to the root directory of the extracted/unzipped file.
   Hint: You can use setwd() to the set the working directory.
   For example, if you download and unzip the data folder in D:/gettingdata , you should call the following:
  
   > setwd("D:/gettingdata/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
  

4. Now download the run_analysis.R from this repo and copy paste it in your working directory which
 you have setup in step.3
 
5.  Use the script by opening an R session . Then execute the script with the R command:

> source('run_analysis.R')


 The run_analysis.R on execution does the following:
 
    > Step 1. Merges the training and the test sets to create one data set.
    > Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    > Step 3. Uses descriptive activity names to name the activities in the data set.
    > Step 4. Appropriately labels the data set with descriptive variable names.
    > Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

	
6. Our run_analysis.R contains a function called my_analysis(). Call this function after you load the script in Step.5

> my_analysis();

7. Check the generated tidydata.txt for output