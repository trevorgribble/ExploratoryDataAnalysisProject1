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

## Create a new column vector combining Date & Time into one POSIXctClass variable called datetime
datetime <- strptime(paste(powerdates$Date,powerdates$Time), "%Y-%m-%d %H:%M:%S")
## Add datetime column to the full powerdates dataframe
powerdates <- cbind(powerdates, datetime)

##Begin PNG
png(file="plot2.png")

##Make sure we are only plotting one graph
par(mfrow=c(1,1))

## Plot DateTime vs Global Active power in a line graph
plot(Global_active_power ~ datetime, data=powerdates,type="l", ylab="Global Active Power (kilowatts)", xlab="", main="")
##Close the PNG
dev.off()