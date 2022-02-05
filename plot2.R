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


#x11()
png(filename="./plot2.png", width = 480, height = 480, pointsize = 12)
plot(df$Date + df$Time, df$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
