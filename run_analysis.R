## Set working directory to datasets 
setwd("./UCI HAR Dataset")

## Read labels/column names
features <- read.table("features.txt",header=FALSE)
activity <- read.table("activity_labels.txt",header=FALSE)


## Read train data
x_train <- read.table("./train/x_train.txt",header=FALSE)
subject_train <- read.table("./train/subject_train.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)


## Read test data
x_test <- read.table("./test/x_test.txt",header=FALSE)
subject_test <- read.table("./test/subject_test.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)


## Change column names
colnames(activity) <- c("ActivityCode","ActivityName")
colnames(x_train) <- features[,2]
colnames(subject_train) <- c("SubjectNbr")
colnames(y_train) <- c("ActivityCode")

colnames(x_test) <- features[,2]
colnames(subject_test) <- c("SubjectNbr")
colnames(y_test) <- c("ActivityCode")


##   #2 Extract measurements only on mean and standard deviation
std_mean_cols <- grep("(*-std()*|*-mean()*)",features[,2])
x_train_mean_std <- x_train[,std_mean_cols]
x_test_mean_std <- x_test[,std_mean_cols]


## Combine train column data
train_df <- cbind(y_train,subject_train,x_train_mean_std)


## Combine test column data
test_df <- cbind(y_test, subject_test, x_test_mean_std)


###   #1 Merge train and test data
train_test_df <- rbind(train_df,test_df)

##   #3 Uses descriptive activity names to name the activities in the data set        
final <- merge(train_test_df, activity, by="ActivityCode") 

##   #4 Appropriately labels the data set with descriptive variable names.
names(final) <- gsub("[()]", "", names(final))
names(final) <- gsub("-std", "-Std", names(final))
names(final) <- gsub("-mean", "-Mean", names(final))


##  Move column "ActivityName" to first column and remove column "ActivityCode"
final <- final[c(82,2:81)]

##   #5 creates a second, independent tidy data set with the 
##      average of each variable for each activity and each subject
final_avg <- aggregate(final, by=list(final$ActivityName,final$SubjectNbr), FUN=mean,na.rm=TRUE)

## Remove 2 columns with NA values 
final_avg$ActivityName <- NULL
final_avg$SubjectNbr <- NULL

## Rename group by columns
colnames(final_avg)[1:2] <- c("ActivityName","SubjectNbr")

## write to file the dataframe 
write.table(final_avg,"./final_avg.txt",row.names=FALSE,sep=",")



