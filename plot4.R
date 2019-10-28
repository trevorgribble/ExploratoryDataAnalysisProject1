## Read in the entire Power Dataset
power <- read.csv("household_power_consumption.txt",sep=";")
## Convert Dates from factor to date class
power[,"Date"]<-as.Date(power$Date,"%d/%m/%Y")
## Subset the Dates of Feb 1 & 2, 2007
powerdates <- subset(power, ((power$Date=="2007-02-01")|(power$Date=="2007-02-02")))

## delete the initial power dataframe to save space
rm(power)

## Convert the Global Active Power variable from factor to numeric
powerdates[,"Global_active_power"] <- as.numeric(as.character(powerdates$Global_active_power))

## Convert the Global Reactive Power variable from factor to numeric
powerdates[,"Global_reactive_power"] <- as.numeric(as.character(powerdates$Global_reactive_power))

## Convert the Voltage variable from factor to numeric
powerdates[,"Voltage"] <- as.numeric(as.character(powerdates$Voltage))

## Convert the Sub Metering variables 1&2 from factor to numeric
powerdates[,"Sub_metering_1"] <- as.numeric(as.character(powerdates$Sub_metering_1))
powerdates[,"Sub_metering_2"] <- as.numeric(as.character(powerdates$Sub_metering_2))

## Create a new column vector combining Date & Time into one POSIXctClass variable called datetime
datetime <- strptime(paste(powerdates$Date,powerdates$Time), "%Y-%m-%d %H:%M:%S")
## Add datetime column to the full powerdates dataframe
powerdates <- cbind(powerdates, datetime)

##Begin PNG
png(file="plot4.png")

##Set up the 2 x 2 palette for the graphs
par(mfcol=c(2,2))

## Graph in (1,1)
## Plot DateTime vs Global Active power in a line graph
plot(Global_active_power ~ datetime, data=powerdates,type="l", ylab="Global Active Power", xlab="", main="")

## Graph in (2,1)
## Begin plotting Sub Metering 1 vs datetime, setting labels and titles and color black
plot(powerdates$datetime,powerdates$Sub_metering_1,type="l",col="black", ylab="Energy sub metering", xlab="", main="")
## Add lines for variables Sub Metering 2 & 3 with appropriate colors
lines(powerdates$datetime,powerdates$Sub_metering_2,type="l",col="red")
lines(powerdates$datetime,powerdates$Sub_metering_3,type="l",col="blue")
## Add Legend
legend("topright", lwd=1, lty=1, bty="n", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Graph in (1,2)
## Plot DateTime vs Voltage in a line graph
plot(Voltage ~ datetime, data=powerdates,type="l", main="")

## Graph in (2,2)
## Plot DateTime vs Global Active power in a line graph
plot(Global_reactive_power ~ datetime, data=powerdates,type="l", main="")

##Close the PNG
dev.off()