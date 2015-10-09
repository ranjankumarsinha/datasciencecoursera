
if (!file.exists("Exploratory Data Analysis")) {
  dir.create("Exploratory Data Analysis")
}  


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./Exploratory Data Analysis/household_power_consumption.zip", method = "curl")


# set working directory & list file
setwd("./Exploratory Data Analysis")
list.files("./")

# Unzip file
unzip("household_power_consumption.zip")

# Read CSV file using read.table
my_df <- read.table("household_power_consumption.txt",sep=";", header=TRUE)

#convert Date type of data frame
my_df$Date <- as.Date(my_df$Date,"%d/%m/%Y")
my_df$Time <- as.POSIXct(paste(my_df$Date, my_df$Time), format="%Y-%m-%d %H:%M:%S")
my_df$Global_active_power <- as.numeric(my_df$Global_active_power)
my_df$Global_reactive_power <- as.numeric(my_df$Global_reactive_power)
my_df$Voltage <- as.numeric(my_df$Voltage)
my_df$Global_intensity <- as.numeric(my_df$Global_intensity)
my_df$Sub_metering_1 <- as.numeric(my_df$Sub_metering_1)
my_df$Sub_metering_2 <- as.numeric(my_df$Sub_metering_2)
my_df$Sub_metering_3 <- as.numeric(my_df$Sub_metering_3)

# data frame required for plots
energy_df <- subset(my_df,Date == "2007-02-01" | Date == "2007-02-02")

# Plot3 as png 
png(file="plot3.png")
# Initializing a plot with type ="n"
plot(energy_df$Time,energy_df$Sub_metering_1,xlab="",ylab = "Energy sub metering",type = "n")
# Draw energy sub metering using proper column
lines(energy_df$Time,energy_df$Sub_metering_1,pch=NA_integer_,col="black")
lines(energy_df$Time,energy_df$Sub_metering_2,pch=NA_integer_,col="red")
lines(energy_df$Time,energy_df$Sub_metering_3,pch=NA_integer_,col="blue")
# define legend
legend("topright",lty="solid",col=c("black","red","blue"),cex=0.7,legend = c("sub_metering_1","sub_metering_2","sub_metering_3"))
#close png device
dev.off() 