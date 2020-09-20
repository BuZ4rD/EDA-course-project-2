#
# Mathias Barat
# mathias.barat@dendropolis.org
#
# EDA-courseProject 2
# Plot1
#   Have total emissions from PM2.5 decreased in the United States 
#   from 1999 to 2008? Using the base plotting system,
#   make a plot showing the total PM2.5 emission from all sources
#   for each of the years 1999, 2002, 2005, and 2008.
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

subset_s_scc <- aggregate(Emissions ~ year, data = s_scc, sum)

colfunc <- colorRampPalette(c("red", "orange"))
png('plot1.png')
barplot(subset_s_scc$Emissions, subset_s_scc$year,
        ylab = "Emissions of PM2.5 in Tons", 
        main = "Total Emissions of PM2.5 from 1999 to 2008", 
        names.arg = subset_s_scc$year,
        col = colfunc(4))
dev.off()
