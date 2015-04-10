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

#print plot to png
png("plot3.png",width=480,height=480)
plot(workingdata$DateAndTime,workingdata$Sub_metering_1,  type="l", col="black", xlab ="", ylab ="Energy sub metering")
lines(workingdata$DateAndTime, workingdata$Sub_metering_2, type="l", col="red")
lines(workingdata$DateAndTime, workingdata$Sub_metering_3, type="l", col="blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
dev.off()
