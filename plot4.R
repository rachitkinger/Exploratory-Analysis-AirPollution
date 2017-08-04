library(ggplot2)

#download and unzip file in working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "assignmentData")
unzip(zipfile = "assignmentData")


# loading data into the environment
sum <- readRDS("summarySCC_PM25.rds")
css <- readRDS("Source_Classification_Code.rds")


#Q4 creating data
#using grepl look for all scc's that contain the word "coal"
##(i have used EI.Sector to check this property since it mentions combustion type,
## and it also mentions whether coal is used on not)
ei <- grepl("coal", css$EI.Sector, ignore.case = TRUE)

#the above is a logical vector, use it to subset all the corresponding SCC
scc <- as.character(css$SCC[ei])

#now we have all the SCC ids that contain coal combustion. Use this to find all
# the relevant rows in sum dataset
q4data <- subset(sum, sum$SCC %in% scc)


#open the graphic device
png(filename = "plot4.png", width = 900, height = 600, units = "px")

# plot using ggplot2
g <- ggplot(q4data, aes(factor(year), Emissions))
g + geom_bar(stat = "identity") + facet_wrap(~ type)

dev.off()