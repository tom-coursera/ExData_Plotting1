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
    date_string <- data_frame[subset == TRUE, 1]
    time_string <- data_frame[subset == TRUE, 2]
    date_time_string <- paste(date_string, time_string)
    
    # convert date-time string to POSIXlt format (required for plotting)
    date_time <- strptime(date_time_string, "%d/%m/%Y %H:%M:%S")
    
    # draw the plot
    par(mfrow = c(1,1))
    plot(date_time, gap, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    
    # copy the plot to a png file and close the device
    dev.copy(png, file = "plot2.png")
    dev.off()