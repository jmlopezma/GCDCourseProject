---
title: "INSTRUCTIONS"
author: "Juan M. López"
date: "Saturday, April 25, 2015"
output: html_document
---
First, sorry for my writing. English is not my language so be patient. I will try to not make grammar mistakes but this is not guaranteed. 

The code was written in RStudio under Windows 7. To run my script, you just need to have the UCI HAR Dataset folder (the one you may find in the zip file) in your working directory. Then you just need to call the main function (getTidyData) like this:

```{r}
> source("run_analysis.R")
> my_data <- getTidyData ()
```

##HOW THE SCRIPT WORKS

getTidyData returns the tidy data described on STEP 5, and writes a txt file named "tidy_data.txt" which contains the data.

```{r}
getTidyData <- function(){
        
        data_set <- getDataSet()
        data_set <- ExtractAndNameData(data_set)
        tidy_data <- fixTable(data_set)
        write.table(tidy_data, ".//tidy_data.txt", row.name=FALSE)
        tidy_data
}

```
First, getTidyData calls the getDataSet() function, which does STEP 1 and returns a data frame with the data merged from the train and test subfolder. The data frame returned have the next structure: Activities + Subjects + 561 other variables. 

```{r}
getDataSet <- function(){
        
        train_x <- read.table(".//UCI HAR Dataset//train//X_train.txt")
        test_x <- read.table(".//UCI HAR Dataset//test//X_test.txt")
        test_y <- read.table(".//UCI HAR Dataset//test//y_test.txt")
        train_y <- read.table(".//UCI HAR Dataset//train//y_train.txt")
        sub_test <- read.table(".//UCI HAR Dataset//test//subject_test.txt")
        sub_train <- read.table(".//UCI HAR Dataset//train//subject_train.txt")
       
        test_set <- cbind(test_y, sub_test, test_x)
        train_set <- cbind(train_y, sub_train, train_x)
        data_set <- rbind(train_set, test_set)
}

```

Then the ExtractAndNameData function is called. This function does STEP 2, 3 and 4. Extracting the data, I believed that the correct variables to retrieve were those which ended in "-std()" or "-mean()". If just made sense to me. So I retrieved them using the grepl function to create a logic array called mean_std, and fixed it so It would includ 2 extra "TRUE" for the Activities and Subject. Once I extracted the desired data, I wrote the correct names of the activities and the correct names of the variables.

```{r}
ExtractAndNameData <- function(data_set){
        
        activities <- read.table(".//UCI HAR Dataset//activity_labels.txt")
        features <- read.table(".//UCI HAR Dataset//features.txt")
        
        labels <- as.vector(features[,2])
        mean_std <- grepl("-std()" , labels) | grepl("-mean()" , labels)

        labels <- c("Activities", "Subject", labels)
        mean_std <- c(TRUE,TRUE,mean_std)

        data_set <- data_set[,mean_std]
        labels <- labels[mean_std]

        data_set[,1] <- levels(activities[,2])[data_set[,1]]
        names(data_set) <- labels
        data_set
}

```

Finally, getTidyData calls the fixTable function which require the reshape2 package to work and does STEP 5.It returns a 180x80 data frame.

```{r}
fixTable <- function(data_set){
        
        require(reshape2)
        
        data_Melt <- melt(data_set, id = c("Activities", "Subject"), measure.vars = names(data_set[,3:81]))
        act_sub_data_1 <- dcast(data_Melt, Activities + Subject ~ variable, mean)        
}

```
