#
#   Mathias Barat
#   mathias.barat@dendropolis.org
#
#   EDA-courseProject 2

#   Plot5

#   How have emissions from motor vehicle sources changed from 1999–2008
#   in Baltimore City?
############################################################


### Import and unzip file

if(!file.exists("data/exdata_data_NEI_data.zip")){
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
                ,destfile = "data/exdata_data_NEI_data.zip")
}
unzip("data/exdata_data_NEI_data.zip", exdir = "data")


### Open as datatable the data:

scc <- readRDS("data/Source_Classification_Code.rds")
head(scc)
s_scc <- readRDS("data/summarySCC_PM25.rds")
head(s_scc)

# Merge the 2 dataFrames
m_scc <- merge(s_scc, scc, by= 'SCC')

###
library(dplyr)
library(ggplot2)

# Filter Balt and Motor Sources
subset_balt_motor <- m_scc[m_scc$fips=="24510" & m_scc$type=="ON-ROAD",]


# Aggregate to sum all the emissions
subset_balt_motor_agg <- aggregate(Emissions ~ year , subset_balt_motor, sum)


# Plot

png('plot5.png')
ggplot(subset_balt_motor_agg , aes(factor(year), Emissions)) +
  geom_bar(stat='identity') +
  xlab("year")+
  ylab("Emissions of PM2.5 in Tons")+
  ggtitle("Total Motor Vehicles related Emissions of PM2.5 from 1999 to 2008", subtitle = "Baltimore City, Maryland")
dev.off()

