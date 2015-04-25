getTidyData <- function(){
        
        data_set <- getDataSet()
        data_set <- ExtractAndNameData(data_set)
        tidy_data <- fixTable(data_set)
        write.table(tidy_data, ".//tidy_data.txt", row.name=FALSE)
        tidy_data
}
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

fixTable <- function(data_set){
        
        require(reshape2)
        
        data_Melt <- melt(data_set, id = c("Activities", "Subject"), measure.vars = names(data_set[,3:81]))
        act_sub_data_1 <- dcast(data_Melt, Activities + Subject ~ variable, mean)        
}
