read_data <- function(){
  df <- read.table(file="./household_power_consumption.txt",na.strings = "?",sep = ";", header=TRUE)
  
  #convert to time - 17:24:00  
  df$Time <- strptime(df$Time,"%H:%M:%S")
  df$Time <- as.POSIXct(strptime(df$Time,"%H:%M:%S"))
  
  #convert to dates - 16/12/2006  
  df$Date <- as.Date(df$Date,"%d/%m/%Y")
  
  #print class for columns
  lapply(df, class) 
  
  #subset 2007-02-01 and 2007-02-02
  #df2 <- df [df$Date >= as.Date("2007-02-01") & df$Date <= as.Date("2007-02-02"),]
  df2 <- df [df$Date == as.Date("2007-02-01") | df$Date == as.Date("2007-02-02"),]
  return(df2)
}

plot_4 <- function(df2){
  png("./plot4.png")
  
  par(mfrow = c(2,2))
  plot(df2$Global_active_power, type="l",xaxt='n', ylab="Global Active Power (kilowatts)", xlab="")
  axis(1, at=c(0,nrow(df2)/2,nrow(df2)),labels=c("Thu","Fri","Sat"))
  
  plot(df2$Voltage, type="l",xaxt='n', ylab="Voltage", xlab="datetime")
  axis(1, at=c(0,nrow(df2)/2,nrow(df2)) ,labels=c("Thu","Fri","Sat"))
  
  with(df2, plot(Sub_metering_1, type="l",xaxt='n', ylab="Energy sub metering", xlab=""))
  with(df2, points(Sub_metering_2, type="l",xaxt='n', col="red"))
  with(df2, points(Sub_metering_3, type="l",xaxt='n', col="blue"))
  axis(1, at=c(0,nrow(df2)/2,nrow(df2)),labels=c("Thu","Fri","Sat"))
  legend("topright", lty = c(1, 1, 1), pch = c(NA, NA, NA), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  title(xlab="")
  
  plot(df2$Global_reactive_power, type="l",xaxt='n', ylab="Global_reactive_power", xlab="datetime")
  axis(1, at=c(0,nrow(df2)/2,nrow(df2)) ,labels=c("Thu","Fri","Sat"))
  
  dev.off()
}

df2 <- read_data()
plot_4(df2)