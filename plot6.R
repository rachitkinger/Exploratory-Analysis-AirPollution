library(ggplot2)

#download and unzip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "assignmentData")
unzip(zipfile = "assignmentData")


# loading data into the environment
sum <- readRDS("summarySCC_PM25.rds")
css <- readRDS("Source_Classification_Code.rds")

#q6: subsetting data
mobile <- grepl("Mobile", levels(css$EI.Sector))
mobile.matches <- levels(css$EI.Sector)[mobile]
mobile.matches.index <- css$EI.Sector %in% mobile.matches
scc <- as.character(css$SCC[mobile.matches.index])
q6data <- subset(sum, sum$SCC %in% scc & (sum$fips == "24510" | sum$fips == "06037" ))
labs <- c(`06037` = "LA County", `24510` = "Baltimore")

#open the graphic device
png(filename = "plot6.png", width = 600, height = 600, units = "px")

g <- ggplot(q6data, aes(factor(year), Emissions))
g + geom_bar(stat = "identity", aes(fill = type)) + facet_grid(.~fips, labeller = labeller(fips = labs)) + labs(xlab = "Year", ylab = "Emissions of PM2.5 (tons)")

dev.off()