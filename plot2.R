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

plot_2 <- function(df2){
  png("./plot2.png")
  
  plot(df2$Global_active_power, type="l",xaxt='n', ylab="Global Active Power (kilowatts)", xlab="" )
  axis(1, at=c(0,nrow(df2)/2,nrow(df2)),labels=c("Thu","Fri","Sat")) 
  
  dev.off();
}

df2 <- read_data()
plot_2(df2)