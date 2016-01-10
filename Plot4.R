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
hpc_sub$voltage <- as.numeric(levels(hpc_sub$voltage))[hpc_sub$voltage]
hpc_sub$global_active_power <- as.numeric(levels(hpc_sub$global_active_power))[hpc_sub$global_active_power]
hpc_sub$global_reactive_power <- as.numeric(levels(hpc_sub$global_reactive_power))[hpc_sub$global_reactive_power]


# creat the png file and plot
# open a png device
png(file="Plot4.png",width=480,height=480)

par(mfrow=c(2,2),mar=c(4,4,2,2))
# 1-4
plot(hpc_sub$time,hpc_sub$global_active_power,type="l",xlab="",ylab="Global Activie Power")

# 2-4
plot(hpc_sub$time,hpc_sub$voltage,type="l",xlab="datetime",ylab="Voltage")

# 3-4
plot(hpc_sub$time,hpc_sub$sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(hpc_sub$time,hpc_sub$sub_metering_2,col="red")
lines(hpc_sub$time,hpc_sub$sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),c("Sub_metering_1","sub_metering_2","sub_metering_3"),lty=1)

# 4-4
plot(hpc_sub$time,hpc_sub$global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")


# close the device
dev.off()