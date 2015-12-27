myAnalysis <- function(){  


  #reading subject files

  activityTest<- read.table(file.path("test","y_test.txt"),header=FALSE)
  #print(subjectTest)
  
activityTrain<- read.table(file.path("train","y_train.txt"),header=FALSE)
  #print(subjectTest)
  
subjectTrain<- read.table(file.path("train","subject_train.txt"),header=FALSE)
  #print(subjectTest)
  
subjectTest<- read.table(file.path("test","subject_test.txt"),header=FALSE)
  #print(subjectTest)
  
featureTrain<- read.table(file.path("train","X_train.txt"),header=FALSE)
  #print(subjectTest)
featureTest<- read.table(file.path("test","X_test.txt"),header=FALSE)
  #print(subjectTest)

  subject<-rbind(subjectTrain,subjectTest)
  #print(subject)

  activity<- rbind(activityTrain,activityTest)
   #print(activity)
  
  features<- rbind(featureTest,featureTrain)
  #print(features)

names(subject)<-c("subject")

#write.table(subject,"output1.txt")

names(activity)<-c("activity")

#write.table(activity,"output2.txt")

dataFeaturesNames <- read.table(file.path("features.txt"),header=FALSE)

names(features)<- dataFeaturesNames$V2

#write.table(features,"output3.txt")

#print(features)


dataCombine <- cbind(subject,activity)

#write.table(dataCombine,"subject-activity-combo.txt")

Data <- cbind(features, dataCombine)

#write.table(Data,"subject-activity-feature-combo.txt")
#print(Data)

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#print(subdataFeaturesNames)

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )

#print(selectedNames)


Data<-subset(Data,select=selectedNames)

#print(Data)

activityLabels <- read.table(file.path("activity_labels.txt"),header = FALSE)

#print(activityLabels$V2)

head(Data$activity,30)

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#print(Data)

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)





}
 