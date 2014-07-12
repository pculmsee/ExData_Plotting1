plot3<-function(){
        #Download file to a temporary file
        temp <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        
        #load a subset of the data to a dataframe because we are only looking
        #for 1/2/2007 and 2/2/2007
        hpcsub <- subset(read.csv(unz(temp, "household_power_consumption.txt"), sep=";", na.strings="?"),Date=="1/2/2007"|Date=="2/2/2007")
        #delete temp when we are done
        unlink(temp)
        
        #convert the Date and Time columns to date and time classes
        hpcsub$Time<-strptime(paste(hpcsub$Date, hpcsub$Time), "%d/%m/%Y %H:%M:%S")        
        hpcsub$Date<- as.Date(hpcsub$Date, "%m/%d/%Y")
        
        #open the png device
        png(filename = "plot3.png", width = 480, height = 480)
        #plot the graph
        plot(x = hpcsub$Time, y = hpcsub$Sub_metering_1, type="l", col = "black", xlab = "", ylab="Energy Sub Metering")
        lines(x = hpcsub$Time, y = hpcsub$Sub_metering_2, col = "red")
        lines(x = hpcsub$Time, y = hpcsub$Sub_metering_3, col = "blue")
        legend("topright", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        #close the device
        dev.off()
}