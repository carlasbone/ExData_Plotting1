#plot 4
#preserve header names
hcptest <- read.csv("household_power_consumption.txt", header = TRUE ,sep=";",as.is=TRUE,na.strings="?", nrows=5)
mycolnames <- names(hcptest)
hcp <- read.csv("household_power_consumption.txt",col.names=mycolnames ,sep=";",as.is=TRUE,na.strings="?", skip=66500,nrows=5000)

#transforms Date and Times
hcp <- transform(hcp,Date = strptime(Date,"%e/%m/%Y"))
hcp <- transform(hcp,Date = as.Date(Date, "%e/%m/%Y"))
hcp <- transform(hcp,DateTime = strptime(paste(Date,Time),"%Y-%m-%d %T"))
hcpwork <- hcp[hcp$DateTime >= "2007-02-01 00:00:00" & hcp$DateTime <= "2007-02-02 23:59:59",]
# set range for y axis for energy sub metering graph
yrange<-range(c(hcpwork$Sub_metering_1,hcpwork$Sub_metering_2,hcpwork$Sub_metering_3))

#open png device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12)

par(mfcol=c(2,2), mar=c(5,4,2,2))   #set rows, cols
with(hcpwork,{
  plot(Global_active_power ~ DateTime, type="l", xlab="", ylab="Global Active Power")  
  with(hcpwork,{
      plot(DateTime,Sub_metering_1, type="l",ylim=yrange,ylab="",xlab="")
      par(new=T)
      plot(DateTime,Sub_metering_2, type="l",ylim=yrange,col="red",ylab="",xlab="")
      par(new=T)
      plot(DateTime,Sub_metering_3, type="l",ylim=yrange,col="blue", ylab="Energy sub metering",xlab="")
      legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lwd=2,lty=c(1,1,1),bty = "n")
  })
  plot(Voltage ~ DateTime, type="l", xlab="datetime", ylab="Voltage")  
  plot(Global_reactive_power ~ DateTime, type="l", xlab="datetime", ylab="global_reactive_power")  
})

dev.off()
