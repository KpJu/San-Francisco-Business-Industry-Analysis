#read in data
MyData <- read.csv(file="C:\\D Drive\\Data\\sf_business_dataset.csv", header=TRUE, sep=",")
NAICS <- read.csv(file="C:\\D Drive\\Data\\NAICS.csv", header=TRUE, sep=",")

#install.packages("maps")
#install.packages("ggplot2")
#install.packages("ggmap")
#install.packages("zipcode")
library(maps)
library(ggplot2)
library(ggmap)
library(mapproj)
library(zipcode)
library(plyr)

#Keep San Fransisco Business Only
table(MyData$State)
CA <- subset(MyData, State=="CA")
#multiple types of SanFrancisco input in the dataset, join corret ones by zipcode
table(droplevels(CA)$City)
table(droplevels(CA)$Source.Zipcode)
data("zipcode")
MyData1<-merge(MyData, zipcode, by.x='Source.Zipcode', by.y='zip')
SF <- subset(MyData1, MyData1$city=="San Francisco")

#select active business
ActiveBusiness <- SF[SF$Business.End.Date=="",]
library(stringr)
sort(table(droplevels(ActiveBusiness)$Source.Zipcode))
#prepare for plot
#replace those with missing values or address instead of zipcode with joined lattitute
ActiveBusiness$lat <-str_sub(ActiveBusiness$Business.Location,regexpr('\\(', ActiveBusiness$Business.Location, FALSE)+1,regexpr(', -', ActiveBusiness$Business.Location, FALSE)-1)
ActiveBusiness$lat <- ifelse(ActiveBusiness$lat==" "|is.na(as.numeric(as.character(ActiveBusiness$lat))),ActiveBusiness$latitude,ActiveBusiness$lat)
ActiveBusiness$lat <- round(as.numeric(ActiveBusiness$lat),5)
#do the same for longitute
ActiveBusiness$lon <-str_sub(ActiveBusiness$Business.Location,regexpr(', -', ActiveBusiness$Business.Location, TRUE)+2,regexpr('\\)', ActiveBusiness$Business.Location, TRUE)-1)
ActiveBusiness$lon <- ifelse(ActiveBusiness$lon==" "|is.na(as.numeric(as.character(ActiveBusiness$lon))),ActiveBusiness$longitude,ActiveBusiness$lon)
ActiveBusiness$lon <- round(as.numeric(ActiveBusiness$lon),4)
#output table
density <- ddply(ActiveBusiness, .(lat), "nrow")
names(density)[2] <- "count"
ActiveBusiness1 <- merge(ActiveBusiness, density)
plot(density)
duplicated(ActiveBusiness1$lat)
ActiveBusiness1[duplicated(ActiveBusiness1$lat),]
ActiveBusiness1<-ActiveBusiness1[!duplicated(ActiveBusiness1$lat),]

density2 <- ddply(ActiveBusiness, .(latitude), "nrow")
names(density2)[2] <- "count2"
ActiveBusiness2 <- merge(ActiveBusiness, density2)
plot(density2)
duplicated(ActiveBusiness2$latitude)
ActiveBusiness2[duplicated(ActiveBusiness2$latitude),]
ActiveBusiness2<-ActiveBusiness2[!duplicated(ActiveBusiness2$latitude),]


map_data <- get_stamenmap(bbox = c(left = -122.5164, bottom= 37.7066, right = -122.3554, top=37.8103), maptype = c("toner-lite"), zoom=13)

map<- ggmap(map_data)
map

#plot granular map
map+
geom_point(aes(x=lon, y=lat, size=(count), colour = (count)), data=ActiveBusiness1, alpha=.5)+
scale_colour_gradient(low="grey", high="red")
#plot less granular map
map+
geom_point(aes(x=longitude, y=latitude, size=(count2), colour = (count2)), data=ActiveBusiness2, alpha=.5) +
scale_colour_gradient(low="grey", high="red")  



#2
sort(table(droplevels(ActiveBusiness)$NAICS.Code))
sort(table(droplevels()$NAICS.Code.Description))
NAICS2 <- ActiveBusiness[,c("NAICS.Code","Description")]
Popular_Business <- ddply(ActiveBusiness, .(NAICS.Code), "nrow")
Popular_Business <- merge(Popular_Business,NAICS, by.x="NAICS.Code", by.y="NAICS_Code")
Popular_Business <- Popular_Business[order(Popular_Business$nrow),]

#3
#lapply(SF$NAICS.Code, summary)
library("plyr")
library(ggplot2)
sort(table(SF$NAICS.Code))
SF$start.year = format(as.Date(SF$Business.Start.Date, format="%m/%d/%Y"),"%Y")
table(droplevels(SF)$start.year, droplevels(SF)$NAICS.Code)
table(SF$start.year)

SF <- merge(SF, NAICS, by.x="NAICS.Code", by.y="NAICS_Code")
SF1 <- subset(SF, SF$NAICS.Code != "" & SF$NAICS.Code !="8100-8139" & SF$NAICS.Code !="2200-2299"& 
              SF$NAICS.Code !="5240-5249"& SF$NAICS.Code !="8100-8399"& SF$NAICS.Code !="3100-3399"&
              SF$NAICS.Code !="5600-5699"& SF$NAICS.Code !="4200-4299"& SF$NAICS.Code !="5100-5199"&
              SF$NAICS.Code !="8110-8139")
sort(table(droplevels(SF1)$NAICS.Code))
industry <- count(SF1, vars=c("Description","start.year"))
industry$year_band <- ifelse(industry$start.year >= 1849 & industry$start.year<=1968,"1968-",
                             ifelse(industry$start.year >=2017,"2017+",industry$start.year))

industry1 <- industry[industry$start.year>=1985,]
plottable1 <- aggregate(industry1$freq, by=list(Year=industry1$year_band, NAICS=industry1$Description),FUN=sum)
ggplot(plottable1, aes(Year, x)) + 
  geom_line(aes(col = NAICS, group=NAICS)) 

#4
#Look and Closed business
SF$end.year = format(as.Date(SF$Business.End.Date, format="%m/%d/%Y"),"%Y")
table(droplevels(SF)$end.year, droplevels(SF)$NAICS.Code)
table(SF$end.year)
SF <- merge(SF, NAICS, by.x="NAICS.Code", by.y="NAICS_Code")
SF2 <- subset(SF, SF$NAICS.Code != "" & SF$NAICS.Code !="8100-8139" & SF$NAICS.Code !="2200-2299"& 
                SF$NAICS.Code !="5240-5249"& SF$NAICS.Code !="8100-8399"& SF$NAICS.Code !="3100-3399"&
                SF$NAICS.Code !="5600-5699"& SF$NAICS.Code !="4200-4299"& SF$NAICS.Code !="5100-5199"&
                SF$NAICS.Code !="8110-8139")
SF2<-SF2[complete.cases(SF2$end.year),]
sort(table(droplevels(SF2)$Description))
industry2 <- count(SF2, vars=c("Description","end.year"))
industry2$year_band <- ifelse(industry2$end.year >= 1957 & industry2$end.year<=2011,"2011-",industry2$end.year)
plottable1 <- aggregate(industry2$freq, by=list(Year=industry2$year_band, NAICS=industry2$Description),FUN=sum)
ggplot(plottable1, aes(Year, x)) + 
  geom_line(aes(col = NAICS, group=NAICS)) 


