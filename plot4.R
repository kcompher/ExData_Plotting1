# download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="pow.zip")
# read dataset
pow <- read.table(unz("pow.zip", "household_power_consumption.txt") , sep = ";" , header=TRUE)

# convert dates
pow$Date <- as.Date(pow$Date, format = "%d/%m/%Y")

# subset by as.date
pow2 <- subset(pow, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# format to POSIXlt
t1 <- paste(as.character(pow2$Date), as.character(pow2$Time), sep=" ")
t2 <- strptime(t1, format="%Y-%m-%d %H:%M")
pow2$Time <- t2

# transform rest to numeric
for (i in 3:9)
{
  pow2[,i] = as.numeric(as.character(pow2[,i]))
}

# plot
png("plot4.png", height=480, width=480, bg="white")
par(mfrow = c(2,2))
plot(pow2$Time, pow2$Global_active_power, ylab = "Global Active Power(kilowatts)", type="l", xlab="")
plot(pow2$Time, pow2$Voltage, ylab = "Voltage", type="l", xlab = "datetime")
plot(pow2$Time, pow2$Sub_metering_1, ylab = "Energy sub metering", type="l", xlab="")
plot.xy(xy.coords(pow2$Time, pow2$Sub_metering_2), type = "l", col = "red")
plot.xy(xy.coords(pow2$Time, pow2$Sub_metering_3), type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       col=c("black", "red", "blue"))
plot(pow2$Time, pow2$Global_reactive_power, ylab="Global_reactive_power", type="l", xlab="datetime")
dev.off()
