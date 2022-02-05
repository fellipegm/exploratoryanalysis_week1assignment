# Clean variables
rm(list=ls())

# Set working directory to script directory
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

# Open dataset 2,075,259 rows and 9 collumns ~ 1,1 Gb of data (assuming doubles). Its fine
df <- read.table(
        unz("./exdata_data_household_power_consumption.zip", 
            "household_power_consumption.txt"), 
        header=TRUE, sep=";",
        colClasses = c("character", "character", rep("numeric", 7)),
        na.strings = "?")


library(dplyr)
df <- tibble(df)


library(lubridate)
df$Date <- dmy(df$Date)
df$Time <- hms(df$Time)

df <- df %>%
        filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02"))


png(filename="./plot4.png", width = 480, height = 480, pointsize = 12)
par(mfrow = c(2,2))
plot(df$Date + df$Time, df$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")
plot(df$Date + df$Time, df$Voltage, type = "l",
     ylab = "Voltage", xlab = "")

plot(df$Date + df$Time, df$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(df$Date + df$Time, df$Sub_metering_2, col = "red")
lines(df$Date + df$Time, df$Sub_metering_3, col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1), 
       x.intersp = 0.1, xjust = 1, y.intersp = 1.3,
       bty = "n")

plot(df$Date + df$Time, df$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "")

dev.off()
