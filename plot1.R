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
####
#  Turn on graphics device
####
png(filename="plot1.png", width=480, height=480)
###
#  Plot
###
hist(data2$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
####
#  Turn off graphics device
#####
dev.off()
