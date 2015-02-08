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
#####
#   Convert submetering data from factor to numberic
#####
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))
####
#   Open graphics device
#####
png(filename="plot3.png", width=480, height=480)
####
#  Plot
plot(hpc$datetime, hpc$Sub_metering_1,ylab="Energy sub metering", type="l", col = "black", xlab="")
lines(hpc$datetime, hpc$Sub_metering_2,ylab="Energy sub metering", type="l", col = "red")
lines(hpc$datetime, hpc$Sub_metering_3,ylab="Energy sub metering", type="l", col = "blue")
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col= c("black", "red", "blue"),
       lwd = .75,
       cex = .75)
###
#  Close graphics device
###
dev.off()