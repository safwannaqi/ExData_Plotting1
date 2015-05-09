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

# plotting line graph
plot(DT2Days$Time ,DT2Days$Global_active_power, type = "l", 
     xlab = NA, ylab = "Global Active Power (kilowatts)")

# copying plot to PNG file
dev.copy(png, file = "plot2.png")
dev.off()
