## First need to download and extract the data

if(!file.exists("household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip")
        unzip("data.zip")
}

## Load and clean the data

if (!exists("workingData")){
        
        workingData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
        
        ## Establish Date column as date format and subset
        
        workingData$Date <- as.Date(workingData$Date, format="%d/%m/%Y")
        workingData <- subset(workingData, Date >= "2007-02-01" & Date <= "2007-02-02")
        
        ## Establish Time column as date/time format
        
        workingData$Time <- strptime(paste(workingData$Date, as.character(workingData$Time), sep=" "), format="%Y-%m-%d %H:%M:%S")
        
}

## Output graph to PNG

png(file="plot2.png", width=480, height=480)

with(workingData, plot(Time, Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l"))

dev.off()