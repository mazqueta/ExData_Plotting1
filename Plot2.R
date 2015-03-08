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



