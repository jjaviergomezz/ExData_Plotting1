
library(data.table)

Sys.setlocale("LC_ALL", "English")

## setwd("~/Mis Documentos/COURSERA/DATA SCIENCE SPECIALIZATION/
##      04 EXPLORATORY DATA ANALYSIS/WEEK 1/COURSE PROJECT 1")

## Probing the types of variables:
initial <- read.table("household_power_consumption.txt", header = TRUE,
                      sep = ";", stringsAsFactors = FALSE, nrows = 100)

classes <- sapply(initial, class)
## classes
## Date                    Time                  Global_active_power 
## "character"             "character"           "numeric" 
## Global_reactive_power   Voltage               Global_intensity 
## "numeric"               "numeric"             "numeric" 
## Sub_metering_1          Sub_metering_2        Sub_metering_3 
## "numeric"               "numeric"             "numeric"

tabAll <- data.table::fread("household_power_consumption.txt", header = TRUE,
                            sep = ";", colClasses = classes,
                            stringsAsFactors = FALSE, na.strings="?")

# tabAllClasses <- sapply(tabAll, class)
# tabAllClasses
# Date                          Time                    Global_active_power 
# "character"                   "character"             "numeric" 
# Global_reactive_power         Voltage                 Global_intensity 
# "numeric"                     "numeric"               "numeric" 
# Sub_metering_1                Sub_metering_2          Sub_metering_3 
# "numeric"                     "numeric"               "numeric" 

## Subsetting the data frame:
mydata <- subset(tabAll, Date == "1/2/2007" | Date == "2/2/2007")

## Adding a Date/Time column:
library(tidyr)
mydata2 <- unite(mydata, Date/Time, 1:2, sep = " ")

## Making a POSIXct date capable of being filtered and graphed by time of day
mydata2$'Date/Time' <- as.POSIXct(mydata2$'Date/Time', "%d/%m/%Y %H:%M:%S", tz = "")

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

## Subplot 1:
plot(mydata2$'Date/Time', mydata2$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

## Subplot 2:
plot(mydata2$'Date/Time',mydata2$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Subplot 3:
plot(mydata2$'Date/Time', mydata2$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")
lines(mydata2$'Date/Time', mydata2$Sub_metering_2, col="red")
lines(mydata2$'Date/Time', mydata2$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

## Subplot 4:
plot(mydata2$'Date/Time', mydata2$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global Reactive Power")


dev.off()
