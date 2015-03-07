#Libraries to be used

library(pryr)
library(lubridate)
library(ggplot2)

# Setting up Working Directory. The directory contains the unzipped text file we are going to use
setwd("~/Documents/Scientific Data/Exploratory Data")

#===========================LOADING DATA====================================================

# Check space in memory
object_size("household_power_consumption.txt")  # 120 B

# Load data into R object
Data<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                 dec = ".",na.strings = "?",
                 comment.char = "",
                 colClasses=c(rep("character",2),rep("numeric",7)))

object_size(Data)

#convert the Date and Time variables to Date/Time classes
Data$Date<-dmy(Data$Date)
Data$Time<-hms(Data$Time)

# read only the data from the dates 2007-02-01 and 2007-02-02
dates<-(Data$Date == dmy("02-02-2007") | Data$Date == dmy("01-02-2007"))
Data<-Data[dates,]

#================================== MAKING PLOTS====================================================
# Open graphic device
png(file="plot2.png") 

# X axis of data is going to be time in days of the week
time<-wday(Data$Date, label = TRUE, abbr = TRUE)

# y axis of data is going to be the Global active power
Global_active_power<-Data$Global_active_power

# Create xy plot
plot(Global_active_power , type="l",ylab = "Golabl Active Power (Kilowatts)", xlab="", xaxt="n" )

# Costumize the x axis of the plot. Therefor, we previously set xaxt="n"
axis(1, at=c(1,length(time)/2+1,length(time) ), 
     labels=c( toString(time[1]), toString(time[length(time)/2+1]), "Sat"), 
     tck=-0.01)

# Close graphic device
dev.off()



