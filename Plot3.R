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
hpc_sub$sub_metering_1 <- as.numeric(levels(hpc_sub$sub_metering_1))[hpc_sub$sub_metering_1]
hpc_sub$sub_metering_2 <- as.numeric(levels(hpc_sub$sub_metering_2))[hpc_sub$sub_metering_2]
hpc_sub$sub_metering_3 <- as.numeric(levels(hpc_sub$sub_metering_3))[hpc_sub$sub_metering_3]


# creat the png file and plot
# open a png device
png(file="Plot3.png",width=480,height=480)

plot(hpc_sub$time,hpc_sub$sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(hpc_sub$time,hpc_sub$sub_metering_2,col="red")
lines(hpc_sub$time,hpc_sub$sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),c("Sub_metering_1","sub_metering_2","sub_metering_3"),lty=1)


# close the device
dev.off()
