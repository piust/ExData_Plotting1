library(dplyr)

## PLotting function
plot4 <- function(){
    ## Build the environment
    build_environment()
    ## Read data
    data <- read_dataset()
    ## Set the png device
    png("plot4.png")
    ## Prepare to draw graphs in a 2+2 grid
    par(mfcol=c(2,2))
    ## Draw the Global_active_power histagram
    plot(x = data$Time, y=data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    ## Draw the Energy sub metering graphs    
    plot(x = data$Time, y=data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col="black")
    with(data, lines(x=Time, y=Sub_metering_2, col="red"))
    with(data, lines(x=Time, y=Sub_metering_3, col="blue"))
    ## Add the legend
    legend("topright",lwd=c(2.5,2.5), bty = "n", col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    ## Draw the Voltage graph
    plot(x = data$Time, y=data$Voltage, type = "l", xlab="datetime", ylab = "Voltage")
    ## Draw the Global reactive power graph
    plot(x = data$Time, y=data$Global_reactive_power, type = "l", xlab="datetime", ylab = "Global_reactive_power")
    ## Close the device
    dev.off()
}

## This function downloads and unzips the file needed by the project
build_environment <- function(){
    ## Directory to store the data
    data_dir <- "data"
    ## The actual date
    date <- Sys.Date()
    ## The URL containing the data
    download_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    ## The file containing the data
    data_file <- file.path(data_dir,"household_power_consumption.txt")
    ## The name og the zip file
    zip_file <- file.path(data_dir,paste0("project_",date,".zip"))
    ## Creation of the working environment
    if(!file.exists(data_dir)){dir.create(data_dir)}
    if(!file.exists(zip_file)){
        download.file(download_url, zip_file)
        unzip(zip_file,exdir = data_dir)    
    }
}

## This function reads the dataset and filter by the requested date range. 
## Il casts the Date variable to Date class and the Time variable to Time class
read_dataset <- function(){
    ## Read the dataset
    data <- read.delim("data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
    ## Convert the Time column to Time class
    data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
    ## Convert the Date column to Date class
    data$Date <- as.Date(data$Date, format="%d/%m/%Y")
    ## Filter the rows by date
    data <- data[data$Date <= "2007-02-02" & data$Date >= "2007-02-01",]
}

