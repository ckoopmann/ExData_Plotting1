
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
png("plot1.png")
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()