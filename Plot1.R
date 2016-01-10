# read the dataset into the variable "hpc"
# read the dataset into the "hpc"
url <- paste(getwd(),"/household_power_consumption.txt",sep="")
hpc <- read.table(url,header=TRUE,sep=";")

# convert the column names of "hpc" to lowcase
names(hpc) <- tolower(names(hpc))

# convert the column "date" to Date class
hpc$date <- as.Date(hpc$date,"%d/%m/%Y")

# subset the data that from the dates 2007-02-01 and 2007-02-02 from the dataset 
hpc_sub <- subset(hpc,hpc$date=="2007-02-01" | hpc$date == "2007-02-02")

# create the PNG file
# convert factor to numeric
hpc_sub$global_active_power <- as.numeric(levels(hpc_sub$global_active_power))[hpc_sub$global_active_power]

# open a png device
png(file="Plot1.png",width=480,height=480)

# create the histogram
hist(hpc_sub$global_active_power,main = "Global Active Power",
xlab="Global Active Power(kilowatts)",col="red",labels=c(0,2,4,6))

# close the device
dev.off()
