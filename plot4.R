#####
#  Read in data for relevant dates and assign to data2
######
library(sqldf)
data2 <- read.csv.sql("household_power_consumption.txt",
                      header=TRUE,
                      sep=";",
                      " select *
                  from file
                where Date = '1/2/2007'
                  or Date = '2/2/2007'")
#####
#   Convert factor to numberic
#####
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
#####
#  Convert Date and Time to a common POSIX datatime field
######
datetime <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S")
#######
#  Add datetime to existing data, result called hpc
######
hpc <- cbind(datetime, data2)
######
#  Convert Voltage and Global reactive power from factor to numeric
###
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
#####
#   Set up parameters for a 4x4 plot to graphics device
#####
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,4,2), cex=.6)
type = "l",ylab = "Global Active Power (kilowatts)", xlab="")
#####
#  the plots
#####
plot(hpc$datetime, hpc$Voltage, ylab="Voltage", xlab="datetime", type="l" )
plot(hpc$datetime, hpc$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l" )
plot(hpc$datetime, hpc$Sub_metering_1,ylab="Energy sub metering", type="l", col = "black", xlab="")
lines(hpc$datetime, hpc$Sub_metering_2,ylab="Energy sub metering", type="l", col = "red")
lines(hpc$datetime, hpc$Sub_metering_3,ylab="Energy sub metering", type="l", col = "blue")
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col= c("black", "red", "blue"),
       cex = .5,
       lwd = .5)
####
#  turn off graphics device
####
dev.off()
