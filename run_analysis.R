library (reshape2)


# get column names
fields <- read.table ("UCI HAR Dataset\\features.txt",header=FALSE)
f <- as.vector (fields[[2]])
x_test <- read.table ("UCI HAR Dataset\\test\\x_test.txt", header=FALSE)
x_train <- read.table ("UCI HAR Dataset\\train\\x_train.txt", header=FALSE)
names(x_test) <- f
names(x_train) <- f
# get subject and activity
y_test <- read.table ("UCI HAR Dataset\\test\\y_test.txt", header=FALSE)
names (y_test) <- c("ACTIVITY_ID")
y_subject_test <- read.table  ("UCI HAR Dataset\\test\\subject_test.txt", header=FALSE)
names(y_subject_test) <- c("SUBJECT_ID")

y_train <-  read.table ("UCI HAR Dataset\\train\\y_train.txt", header=FALSE)
names(y_train) <- c("ACTIVITY_ID")
y_subject_train <- read.table  ("UCI HAR Dataset\\train\\subject_train.txt", header=FALSE)
names(y_subject_train) <- c("SUBJECT_ID")

#add subject and activity
x_train <- cbind (x_train, y_train, y_subject_train)
x_test <- cbind (x_test, y_test, y_subject_test)

#combine
df <- rbind (x_train, x_test)
colNames <- grepl ("mean|std|ACTIVITY|SUBJECT",names(df))
df <- df[colNames] 

#merge activity labels with codes
activity_labels <- read.table ("UCI HAR Dataset\\activity_labels.txt")
names (activity_labels) <- c("ID","ACTIVITY")
df <- merge (df,activity_labels,by.x="ACTIVITY_ID",by.y="ID")

# get measurement fields
mcol <- grepl ("mean|std",f)
measurements <- f[mcol]

# melt
dfmelt <- melt(df,id=c("ACTIVITY","SUBJECT_ID"),measure.vars=measurements)
#dcast

dftidy <- dcast (dfmelt, ACTIVITY + SUBJECT_ID ~ variable,mean)

# delete temporary data frames
rm (x_train)
rm (x_test)
rm (y_train)
rm (y_test)
rm (f)
rm (fields)
rm (y_subject_test)
rm (colNames)
rm (activity_labels)
rm (dfmelt)
rm (measurements)

