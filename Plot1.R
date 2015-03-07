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

object_size(Data)     # 150 MB

#convert the Date and Time variables to Date/Time classes
Data$Date<-dmy(Data$Date)
Data$Time<-hms(Data$Time)

# read only the data from the dates 2007-02-01 and 2007-02-02
dates<-(Data$Date == dmy("02-02-2007") | Data$Date == dmy("01-02-2007"))
Data<-Data[dates,]

#================================== MAKING PLOTS====================================================
# Open png Device
png(file="plot1.png") 

#Make a histogram of the Data$Global_active_power, with the bars in red, with a title and label in x axis
hist(Data$Global_active_power, col="red1", border="black", main = "Global Active Power",
     xlab = "Golabl Active Power (Kilowatts)") 

# Close graphic device
dev.off()
           
           
           
           