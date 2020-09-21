#
#   Mathias Barat
#   mathias.barat@dendropolis.org
#
#   EDA-courseProject 2

#   Plot3

#   Of the four types of sources indicated by the (point, nonpoint, onroad,
#   nonroad) variable, which of these four sources
#   have seen decreases in emissions from 1999–2008 for Baltimore City?
#   Which have seen increases in emissions from 1999–2008? Use the ggplot2
#   plotting system to make a plot answer this question.
#
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

###
maryland_data <- s_scc[s_scc$fips=="24510",]

subset_maryland <- aggregate(Emissions ~ year + type, maryland_data, sum)

library(ggplot2)

png('plot3.png')
ggplot(subset_maryland , aes(year, Emissions, color = type)) +
  geom_line(size=2) +
  xlab("year")+
  ylab("Emissions of PM2.5 in Tons")+
  ggtitle("Total Emissions of PM2.5 from 1999 to 2008", subtitle = "Baltimore City, Maryland, amount repartited within the type of sources")
dev.off()
