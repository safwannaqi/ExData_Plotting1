if (!file.exists("household_power_consumption.txt")) {
    stop("Please place the unzipped data file [household_power_consumption.txt] in the working directory.")
}

# reading the data file into a data frame
datafile <- "household_power_consumption.txt"
DT <- read.table(datafile, header = TRUE, sep = ";", 
                 na.strings = "?") # missing values are coded as '?'

# converting data types for easier handling
DT$Time <- strptime(paste(DT$Date, DT$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")


# subsetting data
DT2Days <- subset(DT, DT$Date > as.Date("2007-01-31") & DT$Date < as.Date("2007-02-03"))

# setting global parameters
par(mfrow = c(1,1), cex = 1)

# plotting line graphs
plot(DT2Days$Time ,DT2Days$Sub_metering_1, col = "black", type = "l", xlab = NA, ylab = "Energy sub metering")
lines(DT2Days$Time ,DT2Days$Sub_metering_2, col = "red", type = "l")
lines(DT2Days$Time ,DT2Days$Sub_metering_3, col = "blue", type = "l")

# adding legend
legend("topright", col = c("black", "red", "blue"), lwd = 2.5, lty = c(1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# copying plot to PNG file
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()
