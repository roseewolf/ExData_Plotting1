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
png("plot1.png",width=480,height=480)
hist(workingdata$Global_active_power, plot=TRUE, main=paste("Global Active Power"), xlab ="Global Active Power (kilowatts)", col="red")
dev.off()

