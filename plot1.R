#load packages
library(data.table)
library(dplyr)
library(lubridate)
library(ggplot2)

#Setting working directory
setwd("/Users/Rafael/Documents/GitHub/ExData_Plotting1")



#load file and leave only the right dates
base <- fread("household_power_consumption.txt")
base[,Date := dmy(Date)]
base <- base[Date == "2007-02-01" | Date == "2007-02-02"]
base[,c(3:9) := lapply(base[,3:9], as.numeric),]


#graphics
with(base
     ,hist(Global_active_power
           ,col = "red"
           ,main = "Global Active Power"
           ,xlab = "Global Active Power (kilowatts)")
)
dev.copy(png, file = "plot1.png")
dev.off()
