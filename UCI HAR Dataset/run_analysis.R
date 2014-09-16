# read X
train_x<-read.table("train/X_train.txt")
test_x<-read.table("test/X_test.txt")
# merge the training set and testing set
merged_x<-rbind(train_x,test_x)

# read y
train_y<-read.table("train/y_train.txt")
test_y<-read.table("test/y_test.txt")
# merge the training set and testing set
merged_y<-rbind(train_y,test_y)

# read subject
train_subject<-read.table("train/subject_train.txt")
test_subject<-read.table("test/subject_test.txt")
# merge the training set and testing set
merged_subject<-rbind(train_subject,test_subject)

# read body_acc_x
train_body_acc_x<-read.table("train/Inertial Signals/body_acc_x_train.txt")
test_body_acc_x<-read.table("test/Inertial Signals/body_acc_x_test.txt")
# merge the training set and testing set
merged_body_acc_x<-rbind(train_body_acc_x,test_body_acc_x)

# read body_acc_y
train_body_acc_y<-read.table("train/Inertial Signals/body_acc_y_train.txt")
test_body_acc_y<-read.table("test/Inertial Signals/body_acc_y_test.txt")
# merge the training set and testing set
merged_body_acc_y<-rbind(train_body_acc_y,test_body_acc_y)

# read body_acc_z
train_body_acc_z<-read.table("train/Inertial Signals/body_acc_z_train.txt")
test_body_acc_z<-read.table("test/Inertial Signals/body_acc_z_test.txt")
# merge the training set and testing set
merged_body_acc_z<-rbind(train_body_acc_z,test_body_acc_z)

# read body_gyro_x
train_body_gyro_x<-read.table("train/Inertial Signals/body_gyro_x_train.txt")
test_body_gyro_x<-read.table("test/Inertial Signals/body_gyro_x_test.txt")
# merge the training set and testing set
merged_body_gyro_x<-rbind(train_body_gyro_x,test_body_gyro_x)

# read body_gyro_y
train_body_gyro_y<-read.table("train/Inertial Signals/body_gyro_y_train.txt")
test_body_gyro_y<-read.table("test/Inertial Signals/body_gyro_y_test.txt")
# merge the training set and testing set
merged_body_gyro_y<-rbind(train_body_gyro_y,test_body_gyro_y)

# read body_gyro_z
train_body_gyro_z<-read.table("train/Inertial Signals/body_gyro_z_train.txt")
test_body_gyro_z<-read.table("test/Inertial Signals/body_gyro_z_test.txt")
# merge the training set and testing set
merged_body_gyro_z<-rbind(train_body_gyro_z,test_body_gyro_z)

# read total_acc_x
train_total_acc_x<-read.table("train/Inertial Signals/total_acc_x_train.txt")
test_total_acc_x<-read.table("test/Inertial Signals/total_acc_x_test.txt")
# merge the training set and testing set
merged_total_acc_x<-rbind(train_total_acc_x,test_total_acc_x)

# read total_acc_y
train_total_acc_y<-read.table("train/Inertial Signals/total_acc_y_train.txt")
test_total_acc_y<-read.table("test/Inertial Signals/total_acc_y_test.txt")
# merge the training set and testing set
merged_total_acc_y<-rbind(train_total_acc_y,test_total_acc_y)

# read total_acc_z
train_total_acc_z<-read.table("train/Inertial Signals/total_acc_z_train.txt")
test_total_acc_z<-read.table("test/Inertial Signals/total_acc_z_test.txt")
# merge the training set and testing set
merged_total_acc_z<-rbind(train_total_acc_z,test_total_acc_z)

# read features
features<-read.table("features.txt")
names(merged_x)<-features$V2

# choose only mean and standard deviation
std_mean_x<-merged_x[,grep("-std()|-mean()",features$V2)]

# read activity labels
activity_labels<-read.table("activity_labels.txt")

# add an index to y
merged_y$index <- 1:nrow(merged_y)
# apply activity labels
y_activity<-merge.data.frame(merged_y,activity_labels,by.x = "V1",by.y = "V1", sort = FALSE, all=FALSE)
y_str_activity <- y_activity[with(y_activity,order(index)),c("V1","V2")]
names(y_str_activity) <- c("activity","activity_label")
names(merged_subject) <- c("subject")
#y_str_activity["activity_label"] <- data.frame(lapply(y_str_activity["activity_label"],as.character))

#bind all data
m_data <- cbind(std_mean_x,y_str_activity,merged_subject)

# create the aggregated data
agg_data <- aggregate(.~activity+subject,m_data,mean)
agg_data_activity <- merge.data.frame(agg_data,activity_labels,by.x = "activity",by.y = "V1", sort = FALSE, all=FALSE)
agg_data_sorted <- agg_data_activity[with(agg_data_activity,order(activity,subject)),]

# write the table
write.table(agg_data_sorted,"avg_data_by_activity_by_subject.txt", row.names=FALSE)
#write.table(merged_x,"merged_x.txt", row.names=FALSE, col.names=FALSE)
