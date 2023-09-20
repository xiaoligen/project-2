library(plyr)   
my_data <- readRDS("C:/Users/12150/Desktop/summarySCC_PM25.rds") 
polluteSum <- ddply(my_data, "year", summarise, Emissions = sum(Emissions)) 
png(file = "C:/Users/12150/Desktop/plot1.png", height = 480, width = 480) 
plot(polluteSum, type ='l', lty = 5, xlab = "Year", yaxt = "n", ylab = expression('Emissions ' ~ PM[2.5] ~ '(million tons)'), 
      main = expression("Unites States " ~ PM[2.5]) ) 
axis(2, at = seq(4000000, 7000000, 1000000), labels = seq(4,7,1), las = 2 )  
dev.off() 

