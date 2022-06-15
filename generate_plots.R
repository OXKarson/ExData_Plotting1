if (!require("lubridate")) install.packages("lubridate")
library(lubridate)

householdPower <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", 
   sep=";", 
   header=TRUE, 
   colClasses = c(rep("character", 2), rep("numeric", 7)),
   na.strings="?",
)
householdPower$Date <- dmy(householdPower$Date)
householdPower$Time <- hms(householdPower$Time)
householdPower <- householdPower[householdPower$Date >= "2007-02-01" & householdPower$Date <= "2007-02-02",]

hist(householdPower$Global_active_power, breaks = 25, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.copy(png,'plot1.png')
dev.off()

plot(householdPower$Date+householdPower$Time, householdPower$Global_active_power, type="l", xlab = "", ylab = "GLobal Active Power (kilowatts)")
dev.copy(png,'plot2.png')
dev.off()

plot(householdPower$Date+householdPower$Time, householdPower$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
points(householdPower$Date+householdPower$Time,householdPower$Sub_metering_2,type="l",col="red")
points(householdPower$Date+householdPower$Time,householdPower$Sub_metering_3,type="l",col="blue")
dev.copy(png,'plot3.png')
dev.off()