
library(data.table)

Sys.setlocale("LC_ALL", "English")

## setwd("~/Mis Documentos/COURSERA/DATA SCIENCE SPECIALIZATION/
##      04 EXPLORATORY DATA ANALYSIS/WEEK 1/COURSE PROJECT 1")

## Probing the types of variables:
initial <- read.table("household_power_consumption.txt", header = TRUE,
                      sep = ";", stringsAsFactors = FALSE, nrows = 100)

classes <- sapply(initial, class)
# classes
# Date                    Time                  Global_active_power 
# "character"             "character"           "numeric" 
# Global_reactive_power   Voltage               Global_intensity 
# "numeric"               "numeric"             "numeric" 
# Sub_metering_1          Sub_metering_2        Sub_metering_3 
# "numeric"               "numeric"             "numeric"

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

# POSIXct date for graphing by time:
mydata2$'Date/Time' <- as.POSIXct(mydata2$'Date/Time', format = "%d/%m/%Y %H:%M:%S", tz = "")

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = mydata2$'Date/Time', y = mydata2$Global_active_power
     , type="l", xlab = "", ylab="Global Active Power (kilowatts)")

dev.off()
