    # read in the data table with header TRUE, 
    # column separator as ";" 
    # column classes as specified below
    # and null strings as "?"

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
    
    # draw a histogram of column 3 (Global Active Power)
    par (mfrow = c(1,1))
    hist(data_frame[subset == TRUE, 3], 
         col = "red", 
         main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)"
         )
    
    # copy the plot to a png file and close the device
    dev.copy(png, file = "plot1.png")
    dev.off()
