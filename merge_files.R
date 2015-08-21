## Compile data files into one data frame

# read the test files
test_subj <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/Y_test.txt")

# read the training files
train_subj <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/Y_train.txt")

# bind the test files
test_dat <- cbind(test_subj, y_test, x_test)

# bind the training files
train_dat <- cbind(train_subj, y_train, x_train)

# bind test and training files
data <- rbind(test_dat, train_dat)

# remove intermediate data frames from environment
rm(test_subj, x_test, y_test, train_subj, x_train, y_train, test_dat, train_dat)


### MEANS AND STDEVS

# Get mean for each measure
means <- lapply(subset(data, select = 3:563), mean)

# Get stdev for each measure
stdevs <- lapply(subset(data, select = 3:563), sd)

# bind mean and sd into one table
mean_sd <- cbind(means, stdevs)

### Renaming columns EXAMPLE
# names(aodata) <- c("country", "countrynumber", "products", "productnumber", "tonnes", "year")

### Summarising by factor column EXAMPLE
#ddply(data, ~Income.Group, summarise, mean=mean(as.numeric(Ranking)))
        

##### THE REAL DEAL


        # return list of files in each subfolder
        files_test_list <- list.files("./test", full.names = TRUE, recursive = FALSE, include.dirs = FALSE)
        files_train_list <- list.files("./train", full.names = TRUE, recursive = FALSE, include.dirs = FALSE)

        # get only the files with '.txt' in the lists
        files_test <- files_test_list[grep(".txt", files_test_list)]
        files_train <- files_train_list[grep(".txt", files_train_list)]


        #combine test files into one data frame
        data_test <- data.frame(dummy=1)
        for (i in seq_along(files_test)){
                data_test <- cbind(data_test, read.csv(files_test[i], header = FALSE, sep = ""))
        }
        data_test$dummy <- NULL
        
        #combine training files into one data frame
        data_train <- data.frame(dummy=1)
        for (i in seq_along(files_train)){
                data_train <- cbind(data_train, read.csv(files_train[i], header = FALSE, sep = ""))
        }
        data_train$dummy <- NULL
                   
