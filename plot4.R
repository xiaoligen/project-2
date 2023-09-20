library(ggplot2) 
NEI <- readRDS("C:/Users/12150/Desktop/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/12150/Desktop/Source_Classification_Code.rds") 
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE) 
coalCombustionSCC <- SCC[coal & combustion,]$SCC 
coalCumbustionNEIVal <- NEI[NEI$SCC %in% coalCombustionSCC,] 
coalCumbustionNEITotal <- aggregate(Emissions~year, coalCumbustionNEIVal, sum) 
g <- ggplot(aes(factor(year), Emissions/10^5), data = coalCumbustionNEITotal) 
g + geom_bar(stat = "identity", fill="#FF9999", colour="black", width=0.75)+ theme_bw()+ guides(fill = FALSE)+ labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) +  
labs(title = expression("PM"[2.5]*" Emissions from Coal Combustion Sources Across US between 1999-2008")) 
ggsave(file = "C:/Users/12150/Desktop/plot4.png") 
