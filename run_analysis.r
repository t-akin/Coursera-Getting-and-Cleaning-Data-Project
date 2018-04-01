#Download the file if it does not exist
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename = "project_data.zip"

if (!file.exists(filename)){
        download.file(url, destfile = filename, mode = "wb")
}

#Unzip the file
if (!file.exists("UCI HAR Dataset")){
        unzip(filename)
}

#Read main test and train sets.
test = read.table("UCI HAR Dataset/test/X_test.txt")
train = read.table("UCI HAR Dataset/train/X_train.txt")

#Read features document and get the feature names. Then assign these names as column names of test and train sets.
variables = read.table("UCI HAR Dataset/features.txt")
colnames(test) = variables[,2]
colnames(train) = variables[,2]

#Find the indices of the features that show the mean or standard deviation of a variable.
i1 = grep("std()", variables[,2])
i2 = grep("mean\\(\\)", variables[,2])
cols = c(i1, i2)

#Subset test and train sets to get the interest of area features.
test = test[,cols]
train = train[,cols]

#Read the subject and activity sets for test and train sets.
subj.train = read.table("UCI HAR Dataset/train/subject_train.txt")
subj.test = read.table("UCI HAR Dataset/test/subject_test.txt")

activity.train = read.table("UCI HAR Dataset/train/y_train.txt")
activity.test = read.table("UCI HAR Dataset/test/y_test.txt")

#After fully constructing test and train sets, merge them.
test = cbind(subj.test, test, activity.test)
train = cbind(subj.train, train, activity.train)
data = rbind(test, train)

#Add the variable names for subject numbers and activity descriptions.
colnames(data)[1] = "subjectno"
colnames(data)[ncol(data)] = "activity"

#Learn what are the descriptions of activities. Then convert the activity variable values to these descriptive values.
#Factorize the activity and subjectno variables.
activities = read.table("UCI HAR Dataset/activity_labels.txt")
data$activity = factor(data$activity, levels = activities[,1], labels = tolower(activities[,2]))
data$subjectno = as.factor(data$subjectno)

#Clean and tidy the column names.
colnames(data) = sub("^t", "Time", colnames(data))
colnames(data) = sub("^f", "Freq", colnames(data))
colnames(data) = sub("-mean()", "Mean", colnames(data))
colnames(data) = sub("-std()", "Std", colnames(data))
colnames(data) = gsub("[( | )]", "", colnames(data))
colnames(data) = sub("-", "Axis", colnames(data))
colnames(data) = sub("BodyBody", "Body", colnames(data))
colnames(data)

#Melt the data and recast to get the average of each variable for each activity and each subject.
library(reshape2)
data.melt = melt(data, id = c("subjectno", "activity"))
data.cast = dcast(data.melt, subjectno + activity ~ variable, mean)
head(data.cast,1)

#Write the table
write.table(data.cast, "tidy.txt", row.names = FALSE)
