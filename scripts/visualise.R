library(ggmap)

	apt <- read.csv('../data/cleanedaptdata.csv', head=T) #,colClasses=c("character","character","character","character","character","character","character","character","character","character","character","character","numeric","numeric"))


bf<-levels(factor(apt$Locality))[1]
apt<-apt[apt$Locality!=bf & apt$Locality!="Point Breeze North",]

latFactor <- factor(apt$Latitude)
lonFactor <- factor(apt$Longitude)
apt$Latitude <- as.numeric(levels(latFactor))[latFactor]		#Convert from character to numeric
apt$Longitude <- as.numeric(levels(lonFactor))[lonFactor]

apt$Longitude
apt$Latitude

cmu <- geocode("Carnegie Mellon University")
cmulong <- cmu[1]
cmulat <- cmu[2]

pitsmap <- qmap("Carnegie Mellon University",zoom=14,source="google",type="roadmap")

pdf(file="..//output//Apartments.pdf")
pitsmap + 
geom_point(aes(x = Longitude, y = Latitude), data = apt) +
geom_point(aes(x=lon, y=lat, color="red"), data=cmu)
dev.off()

pdf(file="..//output//By Rent.pdf")
pitsmap + 
geom_point(aes(x = Longitude, y = Latitude, size =RentPerPerson), data = apt) +
geom_point(aes(x=lon, y=lat, color="red"), data=cmu)
dev.off()

pdf(file="..//output//Locality.pdf")
pitsmap + 
geom_point(aes(x = Longitude, y = Latitude, color=Locality), data = apt) +
geom_point(aes(x=lon, y=lat, color="red"), data=cmu)
dev.off()

pdf(file="..//output//Rent Vs Locality.pdf")
vline.data<-data.frame(z=c("Oakland","Shadyside","Squirrel Hill"),vl=c(mean(apt[apt$Locality=="Oakland",]$RentPerPerson),mean(apt[apt$Locality=="Shadyside",]$RentPerPerson),mean(apt[apt$Locality=="Squirrel Hill",]$RentPerPerson)))
vline.data
ggplot(apt,aes(RentPerPerson))+
geom_histogram(binwidth=50)+
geom_vline(aes(xintercept=vl), data=vline.data)+
facet_grid(Locality~.)+
labs(x="Rent Per Person($)")
dev.off()

pdf(file="..//output//Rent w Utilities.pdf")
vline.data<-data.frame(z=c("Yes","Partial","No"),vl=c(mean(apt[apt$Utlities=="Yes",]$RentPerPerson),mean(apt[apt$Utlities=="Partial",]$RentPerPerson),mean(apt[apt$Utlities=="No",]$RentPerPerson)))
vline.data
ggplot(apt,aes(RentPerPerson))+
geom_histogram()+
geom_vline(aes(xintercept=vl), data=vline.data)+
facet_grid(Utlities~.)+
labs(x="Rent Per Person($)")
dev.off()

apt<-apt[apt$WalkingTime<100,]

pdf(file="..//output//Walking Time Vs Locality.pdf")
vline.data<-data.frame(z=c("Oakland","Shadyside","Squirrel Hill"),vl=c(mean(apt[apt$Locality=="Oakland",]$WalkingTime),mean(apt[apt$Locality=="Shadyside",]$WalkingTime),mean(apt[apt$Locality=="Squirrel Hill",]$WalkingTime)))
vline.data
ggplot(apt,aes(WalkingTime))+
geom_histogram()+
geom_vline(aes(xintercept=vl), data=vline.data)+
facet_grid(Locality~.)+
labs(x="Walking Time(minutes)")
dev.off()

pdf(file="..//output//Walking Time Vs Rent Per Person.pdf")
ggplot(aes(x=RentPerPerson,y=WalkingTime),data=apt)+
geom_point()+
geom_smooth(method="lm",se=FALSE)
dev.off()

