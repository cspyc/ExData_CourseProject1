# read the dataset into the "hpc"
url <- paste(getwd(),"/household_power_consumption.txt",sep="")
hpc <- read.table(url,header=TRUE,sep=";")

# convert the column names of "hpc" to lowcase
names(hpc) <- tolower(names(hpc))

# convert the column "date" to Date class
hpc$date <- as.Date(hpc$date,"%d/%m/%Y")


# subset the data that from the dates 2007-02-01 and 2007-02-02 from the dataset 
hpc_sub <- subset(hpc,hpc$date=="2007-02-01" | hpc$date == "2007-02-02")

hpc_sub$time <- strptime(paste(hpc_sub$date,hpc_sub$time),"%Y-%m-%d %H:%M:%S") 

# convert factor to numeric
hpc_sub$global_active_power <- as.numeric(levels(hpc_sub$global_active_power))[hpc_sub$global_active_power]

# load the "dplyr" package and "lubridate" package
library(dplyr)
library(lubridate)
hpc_sub <- mutate(hpc_sub,weekdays=weekdays(hpc_sub$date,abbreviate=TRUE))

# creat the png file and plot
# open a png device
png(file="Plot2.png",width=480,height=480)

plot(hpc_sub$time,hpc_sub$global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")


# close the device
dev.off()


