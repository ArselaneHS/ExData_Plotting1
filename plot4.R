# Loading the data set into R.
library(lubridate)

names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data<-read.table("household_power_consumption.txt",header=TRUE,na.strings="?",sep=";",col.names=names)
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Time<-strptime(data$Time,format="%H:%M:%S")

bool<-data$Date=="2007-02-01"| data$Date=="2007-02-02"
data<-data[bool,]

#Making the plots
par(mfrow=c(2,2))

## plot 1
plot(data$Time,data$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)",col="black")

##plot 2
plot(data$Time,data$Voltage,type="l",xlab="datetime",ylab="Voltage")

##plot 3
plot(data$Time,data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
points(data$Time,data$Sub_metering_1,type="l",col="black")
points(data$Time,data$Sub_metering_2,type="l",col="red")
points(data$Time,data$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black","red","blue"),lty=1)

##plot 4
plot(data$Time,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global reactive Power",col="black")

# Copying the plot to a png file
dev.copy(png,"figure/plot4.png")
dev.off()