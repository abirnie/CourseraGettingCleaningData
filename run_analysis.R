# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity 
#    and each subject.


#### 1. MERGE TRAINING AND TEST DATA

        # return list of files in each subfolder
        files_test_list <- list.files("./test", full.names = TRUE, recursive = FALSE, include.dirs = FALSE)
        files_train_list <- list.files("./train", full.names = TRUE, recursive = FALSE, include.dirs = FALSE)
        
        # get only the files with '.txt' in the lists
        files_test <- files_test_list[grep(".txt", files_test_list)]
        files_train <- files_train_list[grep(".txt", files_train_list)]

        # read and combine test files into one df
        listDataTest <- lapply(files_test, function(i){read.csv(i, header = FALSE, sep = "")
        })
        dataTest <- do.call(cbind, listDataTest)
        
        # read and combine training files into one df
        listDataTrain <- lapply(files_train, function(i){read.csv(i, header = FALSE, sep = "")
                })
        dataTrain <- do.call(cbind, listDataTrain)
        
        
        ## combine test and training data into one df 
        data_all <- rbind(dataTest, dataTrain)
        
        
### 2. ASSIGN DESCRIPTIVE VARIABLE NAMES

        # assign variable names to columns
        xvar_names <- read.csv("features.txt", header = FALSE, sep = "")        # Read x var file
        var_list <- c("subject", as.character(xvar_names[,2]), "activity")      # create full var list
        names(data_all) <- make.names(var_list, unique = TRUE)                  # change df names to var list
        
### 3. EXTRACT MEANS AND STDEVS
        # extract subject, activity, means and stdevs
        library(dplyr)
        data <- select(data_all, matches("subject"), matches("activity"), contains("mean"), contains("std"))


### 4. DESCRIPTIVE ACTIVITY NAMES
        
        # replace numeric values with activity names
        data$activity[data$activity == 1] <- "WALKING"
        data$activity[data$activity == 2] <- "WALKING_UPSTAIRS"
        data$activity[data$activity == 3] <- "WALKING_DOWNSTAIRS"
        data$activity[data$activity == 4] <- "SITTING"
        data$activity[data$activity == 5] <- "STANDING"
        data$activity[data$activity == 6] <- "LAYING"
        
        
### 5. TIDY DATA SET 2 - MEANS
        
        # use group_by and summarise_each (dplyr functions) to create tidy data set
        tidy_data <- data %>% group_by (subject, activity) %>% summarise_each(funs(mean))
        
        # output tidy data df to .txt file
        write.table(tidy_data, file="tidy_data.txt", row.names = FALSE)
        
        
        