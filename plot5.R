library(ggplot2)

#download and unzip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "assignmentData")
unzip(zipfile = "assignmentData")


# loading data into the environment
sum <- readRDS("summarySCC_PM25.rds")
css <- readRDS("Source_Classification_Code.rds")


#plot5  - subsetting data
mobile <- grepl("Mobile", levels(css$EI.Sector))
mobile.matches <- levels(css$EI.Sector)[mobile]
mobile.matches.index <- css$EI.Sector %in% mobile.matches
scc <- as.character(css$SCC[mobile.matches.index])
q5data <- subset(sum, sum$SCC %in% scc & sum$fips == "24510" )

#open the graphic device
png(filename = "plot5.png", width = 600, height = 600, units = "px")

#plot q5 data
g <- ggplot(q5data, aes(factor(year), Emissions))
g + geom_bar(stat = "identity") + aes(fill = type) + xlab("Year")

dev.off()