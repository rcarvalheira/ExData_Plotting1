#load packages
library(data.table)
library(dplyr)
library(lubridate)
library(ggplot2)
library(datasets)

#Setting working directory
setwd("/Users/Rafael/Documents/GitHub/ExData_Plotting1")



#load file and leave only the right dates
base <- fread("household_power_consumption.txt")
base[,Date := dmy(Date)]
base <- base[Date == "2007-02-01" | Date == "2007-02-02"]
base[,c(3:9) := lapply(base[,3:9], as.numeric),]

#joing hour and day
base[,Date_time := ymd_hms(paste(Date,Time))]

#graphics
with(base
     ,plot(Date_time
           , Sub_metering_1
           , type="l"
           , col="azure4"
           , ylab = "Energy sub metering"
           , xlab = ""
     )
)
lines(base$Date_time
       ,base$Sub_metering_2
       ,col="red")
lines(base$Date_time
       ,base$Sub_metering_3
       ,col="blue")
legend("topright"
       , c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col=c("azure4","red","blue")
       , lty=1
       , cex = 0.75
       )
dev.copy(png, file = "plot3.png")
dev.off()
