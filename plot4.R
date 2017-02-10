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

#view 2x2
par(mfrow=c(2,2), mar=c(4,4,1,1))

#plot1
with(base
     ,plot(base$Date_time
           , base$Global_active_power
           , type="l"
           , ylab = "Global Active Power ( kilowatts)"
           , xlab = ""
     )
)


#plot2
with(base
     ,plot(base$Date_time
           , base$Voltage
           , type="l"
           , ylab = "Voltage"
           , xlab = "datetime"
     )
)


#plot3
plot(base$Date_time
      , base$Sub_metering_1
      , type="l"
      , col="azure4"
      , ylab = "Energy sub metering"
      , xlab = ""
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
       , cex = 0.4
       , box.lty=0
       , inset = 0.02
)

#plot4
with(base
     ,plot(base$Date_time
           , base$Global_reactive_power
           , type="l"
           , ylab = "Global_reactive_power"
           , xlab = "datetime"
     )
)

#print to file
dev.copy(png, file = "plot4.png")
dev.off()

