#import data and specify data types
mydata <- read.table("household_power_consumption.txt",
                     header = TRUE, sep =";", na.strings ="?",
                     colClasses = c("character", "character", "numeric", 
                                    "numeric", "numeric", "numeric", "numeric", 
                                    "numeric", "numeric"))

#Edit Date format in data
mydata$Date <- strptime(mydata$Date, '%d/%m/%Y')

#Filter data for specified date range
a <- mydata[which(mydata$Date > "2007-01-31"),]
workingdata <- a[which(a$Date < "2007-02-03"),]

#create new column for combined Date and Time data
workingdata["DateAndTime"] <- NA

#Fill in newly created column with correctly formatted datetime data
workingdata$DateAndTime <- as.POSIXct(paste(workingdata$Date, workingdata$Time), format="%Y-%m-%d %H:%M:%S")

#save plot to png
png("plot4.png",width=480,height=480)
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
#Plot 4.1
plot(workingdata$DateAndTime,workingdata$Global_active_power, type ="l", xlab ="", ylab = "Global Active Power (kilowatts)")

#Plot 4.2
plot(workingdata$DateAndTime,workingdata$Voltage,  type="l", col="black", xlab ="datetime", ylab ="Voltage")

#Plot 4.3
plot(workingdata$DateAndTime,workingdata$Sub_metering_1,  type="l", col="black", xlab ="", ylab ="Energy sub metering")
lines(workingdata$DateAndTime, workingdata$Sub_metering_2, type="l", col="red")
lines(workingdata$DateAndTime, workingdata$Sub_metering_3, type="l", col="blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"), bty="n")

#Plot 4.4
plot(workingdata$DateAndTime,workingdata$Global_reactive_power,  type="l", col="black", xlab="datetime", ylab ="Global_reactive_power")
dev.off()
