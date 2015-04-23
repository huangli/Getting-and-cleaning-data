# 0. Initial
  library(dplyr)
  
# 1. read train data
  train_x <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
  
  # 1.1 get names for train data
  features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
  names(train_x) <- features$V2
  
  # 1.2 validate names
  valid_column_names <- make.names(names=names(train_x), unique=TRUE, allow_ = TRUE)
  names(train_x) <- valid_column_names
  
  # 1.3 read train_y
  train_y <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
  names(train_y) <- "activity"
  
  #1.4 uses descriptive for activity names
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
  activity_labels <- as.matrix(activity_labels)  
  train_y <- mutate(train_y, activity = activity_labels[activity,2])
  
  # 1.5 read subject data and get names
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
  names(subject_train) <- "subject"
  
# 2. read test data
  test_x <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
  
  # 1.1 get names for train data
  names(test_x) <- features$V2
  
  # 1.2 validate names
  names(test_x) <- valid_column_names
  
  # 1.3 read train_y
  test_y <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
  names(test_y) <- "activity"
  
  #1.4 uses descriptive for activity names
  test_y <- mutate(test_y, activity = activity_labels[activity,2])
  
  # 1.5 read subject data and get names
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
  names(subject_test) <- "subject"
  
# 3. merge the two parts
  train_df <- cbind(subject_train, train_y, train_x)
  test_df <- cbind(subject_test, test_y, test_x)
  total_record <- rbind(train_df, test_df)
  
# 4. Extracts only the measurements on the mean and standard deviation
  total_record <- select(total_record, matches(".std.|.mean.|subject|activity"))
  
# 5.average of each variable for each activity and each subject.
  results <-
    total_record %>%
    group_by(activity, subject) %>%
    summarise_each(funs(mean))
  