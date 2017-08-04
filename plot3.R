library(ggplot2)

#download and unzip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "assignmentData")
unzip(zipfile = "assignmentData")


# loading data into the environment
sum <- readRDS("summarySCC_PM25.rds")
css <- readRDS("Source_Classification_Code.rds")

#Subsetting data for use
baltimore <- subset(sum, fips == "24510")
p3data <- tapply(baltimore$Emissions, list(baltimore$type, baltimore$year), sum, na.rm = TRUE)


#open the graphic device
png(filename = "plot3.png", width = 600, height = 600, units = "px")

#P3 using ggplot2 for plotting
g <- ggplot(baltimore, aes(factor(year), Emissions))
g + geom_bar(stat = "identity") + facet_wrap(~type) + ylab("Emissions of PM2.5 (tons)") + xlab("Year")

dev.off()