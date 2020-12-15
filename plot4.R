# This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("G://data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("G://data/Source_Classification_Code.rds")
}


library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)



png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()