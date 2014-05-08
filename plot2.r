# plot2.r

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

# Create plot2.png
png(file = "plot2.png")
with(electric.data, plot(date.time,Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()