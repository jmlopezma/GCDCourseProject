##This Code plot the fourth graph
##Requires the dplyr package to run


require(dplyr)

data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings="?")
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
data <- mutate(data, Date = paste(Date, Time, sep = " "))
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")

par(mfrow = c(2,2))

##Plot (1,1)
with(data, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Porwer (kilowatts)", lwd=0.5))

##Plot (1,2)
with(data, plot(Date, Voltage, xlab="datatime", type="l", lwd=0.5))

##Plot (2,1)
with(data, plot(Date, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"), lwd=0.5)
with(data, lines(Date, Sub_metering_2, col="red", lwd=0.5))
with(data, lines(Date, Sub_metering_3, col="blue", lwd=0.5))

legend("topright", lty=1, lwd=0.5, col =c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.5, bty = "n")

##Plot (2,2)
with(data, plot(Date, Global_reactive_power, xlab="datatime", type="l", lwd=0.5))

dev.copy(png, filename = "plot4.png",width = 480, height = 480, units = "px")
dev.off()