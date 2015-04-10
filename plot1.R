#plot 1
#preserve header names
hcptest <- read.csv("household_power_consumption.txt", header = TRUE ,sep=";",as.is=TRUE,na.strings="?", nrows=5)
mycolnames <- names(hcptest)
hcp <- read.csv("household_power_consumption.txt",col.names=mycolnames ,sep=";",as.is=TRUE,na.strings="?", skip=66500,nrows=5000)

#transforms Date and Times
hcp <- transform(hcp,Date = strptime(Date,"%e/%m/%Y"))
hcp <- transform(hcp,Date = as.Date(Date, "%e/%m/%Y"))
hcp <- transform(hcp,DateTime = strptime(paste(Date,Time),"%Y-%m-%d %T"))
hcpwork <- hcp[hcp$DateTime >= "2007-02-01 00:00:00" & hcp$DateTime <= "2007-02-02 23:59:59",]



png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12)
hist(hcpwork$Global_active_power,col="orangered2", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
