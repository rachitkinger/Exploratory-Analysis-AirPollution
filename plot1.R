library(ggplot2)

#download and unzip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "assignmentData")
unzip(zipfile = "assignmentData")


# loading data into the environment
sum <- readRDS("summarySCC_PM25.rds")
css <- readRDS("Source_Classification_Code.rds")

#Q1 creating data for use
p1data <- tapply(sum$Emissions, sum$year, sum, na.ram = TRUE)

#set the frame & open the device
png(filename = "plot1.png", width = 480, height = 600, units = "px")
par(mfrow = c(2,1)) 
#Plot1 using line plot
plot(p1data, ylab = "Total PM25 Emissions (tons)", xlab = "Year", type = "l", xaxt = "n")
axis(1, at = (1:4), labels = names(p1data))
#Plot1 using barplot
barplot(p1data, ylab = "Total PM2.5 Emissions (tons)", ylim = c(0, 8e+06), col = "pink")

dev.off()