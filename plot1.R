library(dplyr)
library(tidyr)
library(lubridate)

loadData <- function() {
  #
  # Note: you'll need to set your working directory to the directory that contains the following text file
  #
  full_consumption <- read.delim("household_power_consumption.txt", sep=";")
  ## Convert the date first to make it easier to subset the table
  full_consumption$Date <- dmy(full_consumption$Date)
  ## Pull our subset out and then release the full set
  feb_consumption <- full_consumption %>% filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
  rm(full_consumption)
  # Now, let's make a real date + time field and drop the date and time columns
  feb_consumption$DateTime <- ymd_hms(paste(feb_consumption$Date,feb_consumption$Time))
  feb_consumption <- subset(feb_consumption,select=-c(Date,Time))
  # Clean up all the character values so they're numeric
  feb_consumption$Global_active_power <- as.numeric(feb_consumption$Global_active_power)
  feb_consumption$Global_reactive_power <- as.numeric(feb_consumption$Global_reactive_power)
  feb_consumption$Voltage <- as.numeric(feb_consumption$Voltage)
  feb_consumption$Global_intensity <- as.numeric(feb_consumption$Global_intensity)
  feb_consumption$Sub_metering_1 <- as.numeric(feb_consumption$Sub_metering_1)
  feb_consumption$Sub_metering_2 <- as.numeric(feb_consumption$Sub_metering_2)

  invisible(feb_consumption)
}


feb_data <- loadData()
png(filename= "./plot1.png", width=480, height=480)
hist(feb_data$Global_active_power,main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()