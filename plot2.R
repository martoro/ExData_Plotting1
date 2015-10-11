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
png("plot2.png", width = 480, height = 480)
plot(power_consumption$Time, power_consumption$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
