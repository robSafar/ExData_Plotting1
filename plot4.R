## First need to download and extract the data

if(!file.exists("household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip")
        unzip("data.zip")
}

## Load and clean the data

workingData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

## Establish Date column as date format and subset

workingData$Date <- as.Date(workingData$Date, format="%d/%m/%Y")
workingData <- subset(workingData, Date >= "2007-02-01" & Date <= "2007-02-02")

## Establish Time column as date/time format

workingData$Time <- strptime(paste(workingData$Date, as.character(workingData$Time), sep=" "), format="%Y-%m-%d %H:%M:%S")

## Output graph to PNG

png(file="plot4.png", width=480, height=480)

par(mfcol = c(2,2))

with(workingData, plot(Time, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l"))

with(workingData, plot(Time, Sub_metering_1, xlab="", ylab="Energy Sub Metering", type="n"))
with(workingData, points(Time, Sub_metering_1, type="l", col="black"))
with(workingData, points(Time, Sub_metering_2, type="l", col="red"))
with(workingData, points(Time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

with(workingData, plot(Time, Voltage, xlab="datetime", ylab="Voltage", type="l"))

with(workingData, plot(Time, Global_reactive_power, xlab="datetime", type="l"))

dev.off()