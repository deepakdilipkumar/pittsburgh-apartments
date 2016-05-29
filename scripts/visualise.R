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
vline.data=data.frame(z=c(mean(apt[apt$Locality=="Oakland",]$RentPerPerson),mean(apt[apt$Locality=="Shadyside",]$RentPerPerson),mean(apt[apt$Locality=="Squirrel Hill",]$RentPerPerson)),vs=c(0,0,0),am=c(0,1,2))
ggplot(apt,aes(RentPerPerson))+
geom_histogram(binwidth=50)+facet_grid(Locality~.)+
labs(x="Rent Per Person($)")+
geom_vline(aes(xintercept=z), vline.data)
dev.off()