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
## 4
##
## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?
##
#######################################################################################

##install.packages("plyr")
library(plyr)

Coal_SCC <- subset(SCC, grepl("Coal", EI.Sector))
Plot_data <- merge(NEI, Coal_SCC, by="SCC")
Plot_data <- ddply(Plot_data, ~year, summarise, Total_Emissions=sum(Emissions))

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
