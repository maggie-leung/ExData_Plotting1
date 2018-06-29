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

## plot 4
## Set up the correct layout
par(mfrow = c(2, 2))

## Plot Top left graph
plot(df$Date, df$Global_active_power,  ylab = 'Global Active Power', xlab = '', type = 'l')

## Plot Top right graph
plot(df$Date, df$Voltage, ylab = 'Voltage', xlab = 'datetime', type = 'l')

## Plot Buttom left graph
with(df, {
    plot(Sub_metering_1 ~ Date, type = 'l', ylab = 'Energy sub metering', xlab = '')
    lines(Sub_metering_2 ~ Date, col = 'red')
    lines(Sub_metering_3 ~ Date, col = 'blue')
})
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd = c(1, 1, 1), col = c('black', 'red',' blue'), bty = 'n')

## Plor Buttom right graph
with(df, plot(Global_reactive_power ~ Date, type = 'l', xlab = 'datetime'))

## Create PNG file with graphic device 
dev.copy(png, 'plot1.png', width = 480, height = 480)
dev.off()
