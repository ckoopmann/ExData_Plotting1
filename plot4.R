
#Sys.setlocale("LC_TIME", "en_US") 

library(lubridate)
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataDEST <- "household_power_consumption.zip"
download.file(dataURL, dataDEST, method = 'curl')
unzip(dataDEST)

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

data$Date  <- as.Date(data$Date, format = "%d/%m/%Y")

data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

data$Time <- strptime(data$Time, format = "%H:%M:%S")
year(data$Time) <- year(data$Date)
month(data$Time) <- month(data$Date)
day(data$Time) <- day(data$Date)

par(mfrow=c(2,2))
png("plot4.png")

plot(data$Time, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

plot(data$Time, data$Voltage type = "l", ylab = "Voltage", xlab = "datetime")

plot(data$Time, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", lty=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,col=c("black","red", "blue"))
dev.off()