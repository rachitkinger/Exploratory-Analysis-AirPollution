#download and unzip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "assignmentData")
unzip(zipfile = "assignmentData")


# loading data into the environment
sum <- readRDS("summarySCC_PM25.rds")
css <- readRDS("Source_Classification_Code.rds")

#Q2 subset the data for use
baltimore <- subset(sum, fips == "24510")
p2data <- tapply(baltimore$Emissions, baltimore$year, sum, na.rm = TRUE)

#set the frame & open the device
png(filename = "plot2.png", width = 480, height = 600, units = "px")
par(mfrow = c(1,1))

#P2 plotting the results
barplot(p2data, ylab = "Total PM2.5 Emissions (tons)", 
        col = "steelblue", main = "Baltimore City Emissions")

#close device
dev.off()