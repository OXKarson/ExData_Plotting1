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

plot4 <- function() {
  plot(householdPower$Date+householdPower$Time, householdPower$Global_reactive_power, type="l", xlab = "datetime", ylab = "GLobal_reactive_power")
}

png("plot4.png")
par(mfrow=c(2,2))
plot1()
plot2()
plot3()
plot4()
dev.off()