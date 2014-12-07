# download data
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

# plot & export
plot(pow2$Time, pow2$Global_active_power, ylab="Global Active Power (kilowatts)", type="l", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480, bg="white")
dev.off()
