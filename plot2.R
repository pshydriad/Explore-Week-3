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
## 2
##
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.
##
#######################################################################################

##install.packages("plyr")
library(plyr)

Baltimore_NEI <- subset(NEI, fips="24510")
Plot_data <- ddply(Baltimore_NEI,~year,summarise,Total_Emissions=sum(Emissions))
png("plot2.png", width = 480, height = 480)
barplot(
    Plot_data$Total_Emissions,Plot_data$year,
    main = "Total Emissions by Year in Baltimore",
    xlab = "Year",
    ylab = "Emissions in Tons",
    names.arg = Plot_data$year,
    col=c("darkblue"),
    horiz = FALSE
)
dev.off()


png("plot4.png", width = 480, height = 480)
barplot(
    Plot_data$Total_Emissions,Plot_data$year,
    main = "Total Emissions by Year for COAL",
    xlab = "Year",
    ylab = "Emissions in Tons",
    names.arg = Plot_data$year,
    col=c("darkblue"),
    horiz = FALSE
)
dev.off()

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