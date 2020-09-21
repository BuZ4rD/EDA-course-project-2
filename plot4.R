#
#   Mathias Barat
#   mathias.barat@dendropolis.org
#
#   EDA-courseProject 2

#   Plot4

#   Across the United States, how have emissions from coal combustion-related
#   sources changed from 1999–2008?
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

# Filter Coal
subset_coal <- filter(m_scc, grepl('coal', Short.Name, ignore.case=TRUE))

# Aggregate to sum all the emissions
subset_coal_agg <- aggregate(Emissions ~ year , subset_coal, sum)


# Plot

png('plot4.png')
ggplot(subset_coal_agg , aes(factor(year), Emissions), color = colfunc(4)) +
  geom_bar(stat='identity') +
  xlab("year")+
  ylab("Emissions of PM2.5 in Tons")+
  ggtitle("Total Coal related Emissions of PM2.5 from 1999 to 2008", subtitle = "For the whole USA")
dev.off()

