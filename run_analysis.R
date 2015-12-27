
load_data <- function() {
  dataRoot <- "./data/UCI_HAR_Dataset"
  
  # Common
  features_labels <- read.table(paste(dataRoot, "/features.txt", sep=""))
  
  # Train
  features_train_data <- read.table(paste(dataRoot, "/train/X_train.txt", sep=""))
  activities_train_data <- read.table(paste(dataRoot, "/train/y_train.txt", sep=""))
  subject_train_data <- read.table(paste(dataRoot, "/train/subject_train.txt", sep=""))
  
  # Test
  features_test_data <- read.table(paste(dataRoot, "/test/X_test.txt", sep=""))
  activities_test_data <- read.table(paste(dataRoot, "/test/y_test.txt", sep=""))
  subject_test_data <- read.table(paste(dataRoot, "/test/subject_test.txt", sep=""))
  
  # Combine
  features_data = rbind(features_train_data, features_test_data)
  activities_data = rbind(activities_train_data, activities_test_data)
  subject_data = rbind(subject_train_data, subject_test_data)
  
  data <- data.frame(subject_data, activities_data, features_data)
  colnames(data) <- c("subject", "activity", as.character(features_labels$V2))
  
  data
}

select_mean_and_std <- function(data) {
  data[,grepl("(subject|activity|mean\\(\\)|std\\(\\))", colnames(data))]
}

replace_activities_with_label <- function(data) {
  activities = load_activities()
  data$activity = activities[data$activity]
  data
}

load_activities <- function() {
  dataRoot <- "./data/UCI_HAR_Dataset"
  
  activity_labels <- read.table(paste(dataRoot, "/activity_labels.txt", sep=""), 
                                col.names = c("id", "label"))
  row.names(activity_labels) <- activity_labels$id
  activity_labels$label = as.character(activity_labels$label)
  activity_labels[,"label"]
}

fix_col_names <- function(str) {
  str <- gsub("^f", "freq", str)
  str <- gsub("^t", "time", str)
  str <- gsub("\\(\\)", "", str)
  str <- gsub("Gravity", "_gravity", str)
  str <- gsub("Body", "_body", str)
  str <- gsub("Acc", "_accel", str)
  str <- gsub("Jerk", "_jerk", str)
  str <- gsub("Gyro", "_gyro", str)
  str <- gsub("Mag", "_magnitude", str)
  str <- gsub("-mean", "_mean", str)
  str <- gsub("-std", "_std", str)
  str <- gsub("-X", "_X", str)
  str <- gsub("-Y", "_Y", str)
  str <- gsub("-Z", "_Z", str)
}

generate_tidy_set <- function() {
  raw.data <- load_data()
  selected.data <- select_mean_and_std(raw.data)
  selected.data.with.activity.labels <- replace_activities_with_label(selected.data)
  colnames(selected.data.with.activity.labels) <- fix_col_names(colnames(selected.data.with.activity.labels))

  tidy.set = selected.data.with.activity.labels
  avg.tidy.set = aggregate(.~subject+activity, tidy.set, mean)
}