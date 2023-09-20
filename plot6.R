library(ggplot2)
NEI <- readRDS("C:/Users/12150/Desktop/summarySCC_PM25.rds") 
SRC <- readRDS("C:/Users/12150/Desktop/Source_Classification_Code.rds") 
VEH <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T) 
SRC.VEH <- subset(SRC, SRC$EI.Sector %in% VEH, select=SCC) 
BC.LA <- subset(NEI, fips == "24510"|fips == "06037") 
NEI.VEH <- subset(BC.LA, BC.LA$SCC %in%  SRC.VEH$SCC) 
pd <- aggregate(NEI.VEH[c("Emissions")], list(fips = NEI.VEH$fips, year = NEI.VEH$year), sum) 
pd$city <- rep(NA, nrow(pd)) 
pd[pd$fips == "06037", ][, "city"] <- "Los Angles County" 
pd[pd$fips == "24510", ][, "city"] <- "Baltimore City" 
png('C:/Users/12150/Desktop/plot6.png', width=480, height=480) 
p <- ggplot(pd, aes(x=year, y=Emissions, colour=city)) + geom_point(alpha=.3) + geom_smooth(alpha=.2, size=1, method="loess") + 
    ggtitle("Vehicle Emissions in Baltimore vs. LA") 
print(p) 
dev.off() 