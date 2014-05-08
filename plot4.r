# plot 4

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
electric.data$datetime <- paste(electric.data$Date, electric.data$Time)

# Convert date.time column to POSIXct
electric.data$datetime <- as.POSIXct(electric.data$datetime, format = "%d/%m/%Y %H:%M:%S")

# Create plot 4

png(file = "plot4.png")
par(mfrow = c(2, 2)) 

with(electric.data, {
    plot(datetime,Global_active_power,type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")
    plot(datetime, Voltage, type = "l")
    plot(datetime,Sub_metering_1,
         type = "l", xlab = "", ylab= "Energy sub metering")
    lines(datetime, Sub_metering_2,col = "red")
    lines(datetime, Sub_metering_3,col = "blue")
    legend("topright", col = c("black","red", "blue"), lty = 1, bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(datetime, Global_reactive_power, type = "l")
})

dev.off() 

