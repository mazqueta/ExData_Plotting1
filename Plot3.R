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
png(file="plot3.png") 

# X axis is time in days of the week
time<-wday(Data$Date, label = TRUE, abbr = TRUE)

# y data points are Data$Sub_metering_1/2/3
sub_metering_1<-Data$Sub_metering_1
sub_metering_2<-Data$Sub_metering_2
sub_metering_3<-Data$Sub_metering_3

# Create xy plot sub_metering1/2/3 vs time. 3 different plots are drawn in the same graph in different colors
plot(sub_metering_1 , type="l",ylab = "Energy Sub metering", xlab="", col="black", xaxt="n" )
lines(sub_metering_2, col="red1")
lines(sub_metering_3, col="blue")

#Costumize x axis
axis(1, at=c(1,length(time)/2+1,length(time) ), 
     labels=c( toString(time[1]), toString(time[length(y)/2+1]), "Sat"),               
     tck=-0.01)

#Add the legend of the plots 
legend("topright", inset=.05,
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1, lty=1, col=c("black", "red1", "blue"),  horiz=FALSE)

# Close graphic device
dev.off()


