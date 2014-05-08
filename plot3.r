# plot3.r

# Load the data
electric.data <- read.table("household_power_consumption.txt", sep = ";",
                            na.strings = "?", header = TRUE, 
                            colClasses = c("character", "character", "numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric",
                                           "numeric"))

#subset for Feb. 1-2, 2007
date.idx <- grepl("^[1-2]\\/2\\/2007", electric.data$Date)
electric.data <- electric.data[date.idx,]
rownames(electric.data) <- NULL

# Combine date and time columns
electric.data$date.time <- paste(electric.data$Date, electric.data$Time)

# Convert date.time column to POSIXct
electric.data$date.time <- as.POSIXct(electric.data$date.time, format = "%d/%m/%Y %H:%M:%S")


# Create plot3.png
png(file = "plot3.png")
with(electric.data, plot(date.time,Sub_metering_1,
                         type = "l", xlab = "", ylab= "Energy sub metering"))
with(electric.data, lines(date.time, Sub_metering_2,col = "red"))
with(electric.data, lines(date.time, Sub_metering_3,col = "blue"))
legend("topright", col = c("black","red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     dev.off()
