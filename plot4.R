    # read in the data table with header TRUE, 
    # column separator as ";" 
    # and column classes as specified

    column_classes = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
    data_frame <- read.table("../household_power_consumption.txt", 
                             header = TRUE, 
                             sep = ";", 
                             colClasses = column_classes, 
                             na.strings = "?"
                             )
    
    # convert 1st column from character to date
    date <- as.Date(data_frame[,1], "%d/%m/%Y")
    subset <- date == "2007-02-01" | date == "2007-02-02"
    
    # extract only a subset from specified dates
    gap <- data_frame[subset == TRUE, 3]
    grp <- data_frame[subset == TRUE, 4]
    voltage <- data_frame[subset == TRUE, 5]
    sub_meter_1 <- data_frame[subset == TRUE, 7]
    sub_meter_2 <- data_frame[subset == TRUE, 8]
    sub_meter_3 <- data_frame[subset == TRUE, 9]
    date_string <- data_frame[subset == TRUE, 1]
    time_string <- data_frame[subset == TRUE, 2]
    date_time_string <- paste(date_string, time_string)
    
    # convert date-time string to POSIXlt format (required for plotting)
    date_time <- strptime(date_time_string, "%d/%m/%Y %H:%M:%S")
    
    jpeg(file = "plot4.png")
    par (mfrow = c(2,2), mar = c(4,5,2,1), oma = c(0,0,0,0))
    
    # draw the 1st plot to the screen
    plot(date_time, gap, type = "l", xlab = "", ylab = "Global Active Power")
    
    # draw the 2nd plot
    plot(date_time, voltage, type = "l", xlab = "datetime", ylab = names(data_frame)[5])
    
    # draw the 3rd plot
    plot(date_time, sub_meter_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
    lines(date_time, sub_meter_2, col = "red")
    lines(date_time, sub_meter_3, col = "blue")
    legend("topright", xjust = 1,
           lty = 1, lwd = 1,
           col = c("black", "red", "blue"), 
           bty = "n",
           legend = c(names(data_frame)[7], names(data_frame)[8], names(data_frame)[9])
           )
    
    # draw the 4th plot
    plot(date_time, grp, type = "l", xlab = "datetime", ylab = names(data_frame)[4])

    dev.off()