#plot1
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y")
head(t)
a <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
head(a)
hist(a$Global_active_power,xlab = "Global Active Power (kilowatts)",ylab = "Frequency", main = "Gobal Active Power",col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

#plot2
Week <- paste(a$Date, a$Time)
head(Week)
dateTime <- setNames(Week, "Week")
a <- a[ ,!(names(a) %in% c("Date","Time"))]
head(a)
a <- cbind(Week, a)
a$Week <- as.POSIXct(Week)
plot(a$Global_active_power~a$Week,type="l",xlab = "",ylab="Gobal Active Power (kilowatts)")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#plot3
head(a)
with(a, {plot(Sub_metering_1~Week, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Week,col='Red')
  lines(Sub_metering_3~Week,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()

#plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(a, {
  plot(Global_active_power~Week, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Week, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Week, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Week,col='Red')
  lines(Sub_metering_3~Week,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Week, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
