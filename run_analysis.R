run_analysis <- function(){
  #reading features and activiry data
  features <- read.table("../UCI HAR Dataset/features.txt")
  activity_labels <- read.table("../UCI HAR Dataset/activity_labels.txt")
  colnames(activity_labels) <- c("id","activity")
  
  #reading test subject data
  subject_test <- read.table("../UCI HAR Dataset/test/subject_test.txt")
  colnames(subject_test) <- c("subject_id")
  
  #reading test activity data
  y_test <- read.table("../UCI HAR Dataset/test/y_test.txt")
  colnames(y_test) <- c("activity_id")
  
  #reading test features data
  x_test <- read.table("../UCI HAR Dataset/test/X_test.txt")
  colnames(x_test) <- features[,2]

  testdata<- cbind(subject_test,y_test, x_test)
  
  #reading train subject data
  subject_train <- read.table("../UCI HAR Dataset/train/subject_train.txt")
  colnames(subject_train) <- c("subject_id")
  
  #reading train activity data
  y_train <- read.table("../UCI HAR Dataset/train/y_train.txt")
  colnames(y_train) <- c("activity_id")

  #reading train features data
  x_train <- read.table("../UCI HAR Dataset/train/X_train.txt")
  colnames(x_train) <- features[,2]

  traindata<- cbind(subject_train,y_train, x_train)
  
  #merge test train data
  test_train_data <- rbind(testdata, traindata)
  
  #fetching only mean and std variables
  mean_std <- test_train_data[grep("mean\\(\\)|std\\(\\)",names(test_train_data))]
  
  mean_std_data <- cbind(test_train_data["subject_id"], test_train_data["activity_id"], mean_std)
  
  #descriptive variable and activity name
  mean_std_data <- merge(x = mean_std_data, y = activity_labels, by.x = "activity_id", by.y = "id")
  colnames(mean_std_data) <- gsub("-", "", names(mean_std_data))
  colnames(mean_std_data) <- gsub("\\(\\)", "", names(mean_std_data))

  #creating tidy dataset
  mean_std_data <- subset(mean_std_data, select = -c(activity_id))
  
  library(reshape2)
  melt_data <- melt(mean_std_data, id=c("subject_id","activity"))
  tidy_data <- dcast(melt_data, subject_id+activity ~ variable, mean)
  
  write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, sep = "\t", quote = FALSE)
}