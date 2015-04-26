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
## 1
##
## Have total emissions from PM2.5 decreased in the United States from 
## 1999 to 2008? Using the base plotting system, make a plot showing the 
## total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
##
#######################################################################################

##install.packages("plyr")
library(plyr)

Plot_data <- ddply(NEI,~year,summarise,Total_Emissions=sum(Emissions))
png("plot1.png", width = 480, height = 480)
barplot(
        Plot_data$Total_Emissions,Plot_data$year,
        main = "Total Emissions by Year",
        xlab = "Year",
        ylab = "Emissions in Tons",
        names.arg = Plot_data$year,
        col=c("darkblue"),
        horiz = FALSE
        )
dev.off()


library(plyr)

Vehicle_SCC <- subset(SCC, grepl("On-Road", EI.Sector))
Baltimore_NEI <- subset(NEI, fips=="24510")
Plot_data <- merge(Baltimore_NEI, Vehicle_SCC, by="SCC")

Plot_data <- ddply(Plot_data, ~year, summarise, Total_Emissions=sum(Emissions))

png("plot5.png", width = 480, height = 480)
barplot(
    Plot_data$Total_Emissions,Plot_data$year,
    main = "Total Emissions by Year for on-road sources in Baltimore",
    xlab = "Year",
    ylab = "Emissions in Tons",
    names.arg = Plot_data$year,
    col=c("darkblue"),
    horiz = FALSE
)
dev.off()



