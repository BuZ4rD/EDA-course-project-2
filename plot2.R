#
#   Mathias Barat
#   mathias.barat@dendropolis.org
#
#   EDA-courseProject 2

#   Plot2

#   Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#   (fips == "24510") from 1999 to 2008?
#   Use the base plotting system to make a plot answering this question.
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

subset_s_scc <- aggregate(Emissions ~ year, data = maryland_data, sum)

colfunc <- colorRampPalette(c("red", "orange"))
png('plot2.png')
barplot(subset_s_scc$Emissions, subset_s_scc$year,
        ylab = "Emissions of PM2.5 in Tons", 
        main = "Total Emissions of PM2.5 from 1999 to 2008",
        sub = "Baltimore City, Maryland",
        names.arg = subset_s_scc$year,
        col = colfunc(4))
dev.off()
