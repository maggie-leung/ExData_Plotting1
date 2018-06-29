## Read data and load to variable 
file_path <- 'household_power_consumption.txt'

ori_data <- read.table(file_path, header = TRUE, sep = ';', na.strings = '?')
ori_data$Date <- as.character(ori_data$Date)

df <- subset(ori_data, ori_data$Date == '1/2/2007'| ori_data$Date == '2/2/2007')
rm(ori_data)

## Set Date Time and proper format for it
df$Date <- as.Date(df$Date, '%d/%m/%Y')
date_time <- paste(df$Date, df$Time)
date_time <- as.data.frame(as.POSIXct(date_time))

## Remove Original Date and Time column, add a new column with the formatted date time
df <- df[, 3:9]
df<- cbind(date_time, df)
col_name <- names(df)
col_name[1] <- 'Date'
colnames(df) <- col_name
rm(date_time)

## plot 2
plot(df$Global_active_power ~ df$Date, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')

## Create PNG file with graphic device 
dev.copy(png, 'plot1.png', width = 480, height = 480)
dev.off()
