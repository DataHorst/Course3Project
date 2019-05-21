library(tidyverse)

# Data directory
dir_data <- "./"

# Load training data
load_test_data = FALSE
if (!exists("train_data_subject") | load_test_data) {
train_data_subject <- read_csv(paste(dir_data,"train/subject_train.txt", sep=""), col_names=c("subject"))
train_data_X <- read_delim(paste(dir_data,"train/X_train.txt", sep=""), delim=" ", col_names= FALSE, trim_ws = TRUE)
train_data_y <- read_csv(paste(dir_data,"train/y_train.txt", sep=""), col_names=c("activity"))
}

# Set the correct variable names for the training data
if (!exists("features")){
features <- read_delim(paste(dir_data,"features.txt", sep=""), delim=" ", col_names= c("id", "name"), trim_ws = TRUE)
}
names(train_data_X) <- features$name

# Combine training data into one tibble
train_data <- bind_cols(train_data_subject, train_data_X, train_data_y)

#### Now do the same for the test data

# Load training data
load_test_data = FALSE
if (!exists("test_data_subject") | load_test_data) {
  test_data_subject <- read_csv(paste(dir_data,"test/subject_test.txt", sep=""), col_names=c("subject"))
  test_data_X <- read_delim(paste(dir_data,"test/X_test.txt", sep=""), delim=" ", col_names= FALSE, trim_ws = TRUE)
  test_data_y <- read_csv(paste(dir_data,"test/y_test.txt", sep=""), col_names=c("activity"))
}

# Set the correct variable names for the testing data
if (!exists("features")){
  features <- read_delim(paste(dir_data,"features.txt", sep=""), delim=" ", col_names= c("id", "name"), trim_ws = TRUE)
}
names(test_data_X) <- features$name

# Combine testing data into one tibble
test_data <- bind_cols(test_data_subject, test_data_X, test_data_y)

## Now combine the training and the test data
if (!exists("data")){
data <- bind_rows(train_data,test_data)
}
###
### Task 1: Merges the training and the test sets to create one data set.
### Task 4: Appropriately labels the data set with descriptive variable names. 
### completed
###

## Keep only the variables on standard deviation and mean
data_clean1 <- select(data, matches("subject|activity|std\\(\\)|mean\\(\\)"))

###
### Task 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
### completed
###
 
## Read the activity names
if (!exists("activity_labels")){
activity_labels <- read_delim(paste(dir_data,"activity_labels.txt", sep=""), delim=" ", col_names= FALSE, trim_ws = TRUE)
names(activity_labels) <- c("id", "label")
}

## Replace activity id by activity labels
if (!exists("data_clean2")){
  data_clean2 <- data_clean1
  for (id in activity_labels$id)  {
      data_clean2$activity <- sapply(data_clean2$activity, function(x){ str_replace(x, as.character(id), activity_labels$label[id] )} )
  }
}

###
### Task 3: Uses descriptive activity names to name the activities in the data set
### completed
###
  
################


## Cleaned data
data_cleaned <- data_clean2
write.table(data_cleaned,file = paste(dir_data,"cleaned_data.txt", sep=""), row.names = FALSE)

## Averaged data per subject/activity
data_avg <- 
  data_cleaned %>%
  group_by(subject, activity) %>%
  summarise_all(mean)


