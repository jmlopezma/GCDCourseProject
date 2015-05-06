##This Code plot the second graph
##Requires the dplyr package to run


require(dplyr)

data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings="?")
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
data <- mutate(data, Date = paste(Date, Time, sep = " "))
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")

with(data, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Porwer (kilowatts)"))

dev.copy(png, filename = "plot2.png",width = 480, height = 480, units = "px")
dev.off()