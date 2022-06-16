if (!require("lubridate")) install.packages("lubridate")
library(lubridate)

file.path <- "./household_power_consumption.txt"
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(file.path)) {
  file.downloaded <- "household_power_consumption.zip"
  download.file(file.url, file.downloaded)
  unzip(file.downloaded)
  file.remove(file.downloaded)
}

householdPower <- read.table(
  file.path,
  sep=";",
  header=TRUE,
  colClasses = c(rep("character", 2), rep("numeric", 7)),
  na.strings="?",
)
householdPower$Date <- dmy(householdPower$Date)
householdPower$Time <- hms(householdPower$Time)
householdPower <- householdPower[householdPower$Date >= "2007-02-01" & householdPower$Date <= "2007-02-02",]

plot3 <- function() {
  plot(householdPower$Date+householdPower$Time, householdPower$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
  points(householdPower$Date+householdPower$Time,householdPower$Sub_metering_2,type="l",col="red")
  points(householdPower$Date+householdPower$Time,householdPower$Sub_metering_3,type="l",col="blue")
}

png("plot3.png")
plot3()
dev.off()