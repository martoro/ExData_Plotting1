library(dplyr)

# Download file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power-consumption.zip", method = "curl")

# Unzip.
unzip("power-consumption.zip")

# Filter appropriate subset.
power_consumption <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
power_consumption <- filter(power_consumption, Date == "1/2/2007" | Date == "2/2/2007")

# Convert variables to appropriate class.
power_consumption[[2]] <- strptime(paste(power_consumption$Date, power_consumption$Time), 
                                   format = "%d/%m/%Y %H:%M:%S")
power_consumption[[1]] <- as.Date(power_consumption[[1]], format = "%d/%m/%Y")
for (i in 3:8) {
  power_consumption[[i]] <- as.numeric(power_consumption[[i]])
}

# Produce the plot.
#
# Use attach to save typing with the plots.
attach(power_consumption)
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# First sub-drawing.
plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Second sub-drawing.
plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Third sub-drawing.
plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(Time, Sub_metering_1, type = "l", col = "black")
points(Time, Sub_metering_2, type = "l", col = "red")
points(Time, Sub_metering_3, type = "l", col = "blue")
legend("topright", bty = "n", lty = "solid", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Fourth sub-drawing.
plot(Time, Global_reactive_power, type = "l", xlab = "datetime")

dev.off()
