#Libraries to be used

library(pryr)           # Needed to check size ob an object
library(lubridate)      # Needed with working with Dates
library(ggplot2)        # Neede++d for plotting
library(sqldf)          # Needed to read data using sql commands

# Setting up Working Directory. The directory contains the unzipped text file we are going to use
setwd("~/Documents/Scientific Data/Exploratory Data")

#===========================LOADING DATA====================================================

# Check space in memory
object_size("household_power_consumption.txt")  # 120 B

file <- c("household_power_consumption.txt")

# Load data into R object
# Reading subset data with desired dates with SQL statement into the data frame Data
Data <- read.csv.sql(file, sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"',  header = TRUE, sep = ";")

object_size(Data)

#convert the Date and Time variables to Date/Time classes
Data$Date<-dmy(Data$Date)
Data$Time<-hms(Data$Time)

object_size(Data)   

#convert the Date and Time variables to Date/Time classes
Data$Date<-dmy(Data$Date)
Data$Time<-hms(Data$Time)


#================================== MAKING PLOTS====================================================
# Open graphic device
png(file="plot4.png") 

# time (x axis) points are shared by several subplots
time<-wday(Data$Date, label = TRUE, abbr = TRUE)


# 4 figures arranged in 2 rows and 2 columns
par(mfrow=c(2,2))


# Subplot 1 time vs Global active power (xy plot)

Global_active_power<-Data$Global_active_power

plot(Global_active_power , type="l",ylab = "Golabl Active Power ", xlab="", xaxt="n" )

axis(1, at=c(1,length(time)/2+1,length(time) ), 
     labels=c( toString(time[1]), toString(time[length(time)/2+1]), "Sat"),
     tck=-0.01)

# Subplot 2 Voltage vs time (xy plot)

Voltage<-Data$Voltage

plot(Voltage , type="l",ylab = "Voltage", xlab="datetime", xaxt="n" )

axis(1, at=c(1,length(time)/2+1,length(time) ), 
     labels=c( toString(time[1]), toString(time[length(time)/2+1]), "Sat"),
     tck=-0.01)


# Subplot 3 submetering vs time (several xy plots in the same graph)

Sub_metering_1<-Data$Sub_metering_1
Sub_metering_2<-Data$Sub_metering_2
Sub_metering_3<-Data$Sub_metering_3

plot(Sub_metering_1 , type="l",ylab = "Energy Sub metering", xlab="", col="black", xaxt="n" )
lines(Sub_metering_2, col="red1")
lines(Sub_metering_3, col="blue")

axis(1, at=c(1,length(y)/2+1,length(y) ), 
     labels=c( toString(time[1]), toString(time[length(time)/2+1]), "Sat"),               
     tck=-0.01)

legend("topright", inset=.05, bty=0,
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1, lty=1, col=c("black", "red1", "blue"),  horiz=FALSE)

# Subplot 4 Global Reactive power vs time

Global_reactive_power<-Data$Global_reactive_power


plot(Global_reactive_power , type="l",xlab="datetime",  xaxt="n" )

axis(1, at=c(1,length(time)/2+1,length(time) ), 
     labels=c( toString(time[1]), toString(time[length(time)/2+1]), "Sat"),               
     tck=-0.01)

# Close graphic device
dev.off()

