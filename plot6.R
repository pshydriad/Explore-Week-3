## ----------EXPLORATORY DATA ANALYSIS -------------
## --                              
## --   Week Three Assignment
## --   Open Exploration of pollution dataset.
## --                              
## ------------------------------------------------- 


## Read in the data files.  
## Note, the first file is quite large and will take a while to load.
NEI <- readRDS("RDS/summarySCC_PM25.rds")
SCC <- readRDS("RDS/Source_Classification_Code.rds")


#######################################################################################
##
## 6
##
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
## greater changes over time in motor vehicle emissions?
##
#######################################################################################

##install.packages("ggplot2")
library(ggplot2)
##install.packages("plyr")
library(plyr)
##install.packages("quantmod")
library(quantmod)


Vehicle_SCC <- subset(SCC, grepl("On-Road", EI.Sector))
Baltimore_NEI <- subset(NEI, fips=="24510")
LA_NEI <- subset(NEI, fips=="06037")
Plot_data <- rbind(Baltimore_NEI, LA_NEI)

Plot_data <- ddply(Plot_data, c("year","fips"), summarise, Total_Emissions=sum(Emissions))

Plot_data <- ddply(Plot_data, "fips", transform,  DeltaCol = Delt(Total_Emissions))


png("plot6.png", width = 480, height = 480)
ggplot(data=Plot_data, aes(x=year, y=Delt.1.arithmetic, group=fips, colour=fips)) +
    ggtitle("PERIOD TO PERIOD CHANGE in Total Emissions from Vehicles Baltimore & LA over time") +
    geom_line() +
    geom_point()
dev.off()