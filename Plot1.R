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
# Open png Device
png(file="plot1.png") 

#Make a histogram of the Data$Global_active_power, with the bars in red, with a title and label in x axis
hist(Data$Global_active_power, col="red1", border="black", main = "Global Active Power",
     xlab = "Golabl Active Power (Kilowatts)") 

# Close graphic device
dev.off()
           
           
           
           