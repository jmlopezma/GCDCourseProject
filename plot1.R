##This Code plot the first graph


data <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, na.strings="?")
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

with(data, hist(Global_active_power[!is.na(Global_active_power)], col="red", xlab="Global Active Porwer (kilowatts)" , main="Global Active Power"))

dev.copy(png, filename = "plot1.png",width = 480, height = 480, units = "px")
dev.off()