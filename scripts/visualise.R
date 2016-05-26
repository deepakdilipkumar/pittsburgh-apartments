library(ggmap)

apt <- read.csv('cleanedaptdata.csv', head=T) #,colClasses=c("character","character","character","character","character","character","character","character","character","character","character","character","numeric","numeric"))

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

pdf(file="Apartments.pdf")
pitsmap + 
geom_point(aes(x = Longitude, y = Latitude), data = apt) +
geom_point(aes(x=lon, y=lat, color="red"), data=cmu)
dev.off()

pdf(file="By Rent.pdf")
pitsmap + 
geom_point(aes(x = Longitude, y = Latitude, size =RentPerPerson), data = apt) +
geom_point(aes(x=lon, y=lat, color="red"), data=cmu)
dev.off()

pdf(file="Locality.pdf")
pitsmap + 
geom_point(aes(x = Longitude, y = Latitude, color=Locality), data = apt) +
geom_point(aes(x=lon, y=lat, color="red"), data=cmu)
dev.off()