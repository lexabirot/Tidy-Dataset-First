library(dplyr)
#First read both X and Y train and test sets
X_train<-read.csv("./UCI HAR Dataset/train/X_train.txt",sep="",header=F) #header set to false cause there is no header in the file
X_test<-read.csv("./UCI HAR Dataset/test/X_test.txt",sep="",header=F) #header set to false cause there is no header in the file
Y_train<-read.csv("./UCI HAR Dataset/train/Y_train.txt",sep="",header=F) #Here to identify the activity number for each X_train row
Y_test<-read.csv("./UCI HAR Dataset/test/Y_test.txt",sep="",header=F) #Here to identify the activity number for each X_test row

#Merge the train and the test sets into one Dataframe
X_df<-rbind(X_train,X_test,stringsAsFactors = F)#merging

# Extract std and mean of each variable
features<-read.csv("./UCI HAR Dataset/features.txt",sep="",header=F,stringsAsFactors = F )#Features file contains the names of all 561 columns of X_df
t<-grep("mean\\(\\)|std()",features[,2],perl=T)#get the row numbers with stds and means columns names

X_df<-select(X_df,num_range("V",t))#each number from vector t match the column number in X_df thant we are interested in
names_X <- features[t,2]#each row of features, filtered by vector t, match with each column of X_df
X_df<-setNames(X_df,names_X)#Properly label dataset with descriptive variable names

#Identify the activity tested on each row of X_df
Y_df<-rbind(Y_train,Y_test,stringsAsFactors = F)#Y datasets match each row from X datasets with the activity number
X_df<-merge(X_df,Y_df,by="row.names")
X_df<-rename(X_df,activityNumber=V1)
activityLabels<-read.csv("./UCI HAR Dataset/activity_labels.txt",sep="",header=F,stringsAsFactors = F)#match activity numbers with their labels
activityLabels<-rename(activityLabels,activityNumber=V1,label=V2)
X_df<-merge(X_df,activityLabels,sort=F)
#match X_df with the subject id
subject_train<-read.csv("./UCI HAR Dataset/train/subject_train.txt",sep="",header=F,stringsAsFactors = F)
subject_test<-read.csv("./UCI HAR Dataset/test/subject_test.txt",sep="",header=F,stringsAsFactors = F)
subject_id<-rbind(subject_train,subject_test,stringsAsFactors=F)
X_df<-merge(X_df,subject_id,by.x="Row.names",by.y="row.names",no.dups=T)#creating the second dataset that's X_df plus a column with subject id tested on each row
X_df<-rename(X_df,subjectId=V1)

#Create a tidy data set witth the average of each variable grouped by subject and the activity tested
averageX_df<-X_df%>%group_by(subjectId,label)%>%summarize_all(mean)#summarise_all function to calculate mean of each variable
averageX_df<-select(averageX_df,-(Row.names:activityNumber))
