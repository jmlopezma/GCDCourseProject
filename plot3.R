##This Code plot the third graph
##Requires the dplyr package to run



require(dplyr)

data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings="?")
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
data <- mutate(data, Date = paste(Date, Time, sep = " "))
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")

with(data, plot(Date, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(Date, Sub_metering_2, col="red"))
with(data, lines(Date, Sub_metering_3, col="blue"))

legend("topright", lty=1, col =c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.5)

dev.copy(png, filename = "plot3.png",width = 480, height = 480, units = "px")
dev.off()