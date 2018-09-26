library(dplyr)

## PLotting function
plot2 <- function(){
    ## Build the environment
    build_environment()
    ## Read data
    data <- read_dataset()
    ## Set the png device
    png("plot2.png")
    ## Draw the Global_active_power graph
    plot(x = data$Time, y=data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
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

