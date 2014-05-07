    # read in the data table with header TRUE, column separator as ";" and column classes as specified

    column_classes = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
    data_frame <- read.table("../household_power_consumption.txt", 
                             header = TRUE, 
                             sep = ";", 
                             colClasses = column_classes, 
                             na.strings = "?"
                             )
    
    # convert 1st column from character to date
    date <- as.Date(data_frame[,1], "%d/%m/%Y")
    
    # extract only a subset from specified dates
    gap <- data_frame[date == "2007-02-01" | date == "2007-02-02", 3]
    sub_meter_1 <- data_frame[date == "2007-02-01" | date == "2007-02-02", 7]
    sub_meter_2 <- data_frame[date == "2007-02-01" | date == "2007-02-02", 8]
    sub_meter_3 <- data_frame[date == "2007-02-01" | date == "2007-02-02", 9]
    date_string <- data_frame[date == "2007-02-01" | date == "2007-02-02", 1]
    time_string <- data_frame[date == "2007-02-01" | date == "2007-02-02", 2]
    date_time_string <- paste(date_string, time_string)
    
    # convert date-time string to POSIXlt format (required for plotting)
    date_time <- strptime(date_time_string, "%d/%m/%Y %H:%M:%S")
    
    par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
    
    # draw the plot to the screen
    par(mar = c(4,4,1,0))
    plot(date_time, sub_meter_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
    lines(date_time, sub_meter_2, col = "red")
    lines(date_time, sub_meter_3, col = "blue")
    
    # add legend
    legend("topright", 
           lty = 1, lwd = 1,
           col = c("black", "red", "blue"), 
           legend = c(names(data_frame)[7], names(data_frame)[8], names(data_frame)[9])
           )
    
    # draw the plot
    plot(date_time, gap, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    
    # copy the plot to a png file and close the device
    dev.copy(png, file = "plot4.png")
    dev.off()