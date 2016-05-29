library(readxl)
library(ggmap)

apt <- read_excel("..//data//apartments.xlsx")
names(apt)
# [1] "Timestamp"                 "Name"                     
# [3] "E-Mail ID"                 "Phone Number"             
# [5] "Sublet/Lease extension?"   "Full address"             
# [7] "Locality"                  "No. of bedrooms available"
# [9] "No. of tenants reqd."      "Floor"                    
#[11] "Rent"                      "RentPerPerson"            
#[13] "Utlities"                  "Available from"           
#[15] "Available until"           "Looking for:"             
#[17] "Other comments " 
relevantCols <- apt[1:69,c(5,6,7,8,9,10,11,12,13,14,15,16,17)]
#locs <- geocode(relevantCols[,2])
dist={}
time={}
locs={}
cmuloc=as.numeric(geocode("Carnegie Mellon University"))
for (addr in relevantCols[,2]){
	loc=geocode(addr)
	locs=c(locs,loc)
	distance=mapdist(as.numeric(loc), cmuloc, mode="walking")
	dist=c(dist,distance[4])
	time=c(time,distance[7])
}
final <- data.frame(relevantCols,locs,dist,time)
names(final) <- c("SubletLease","Address","Locality","Bedrooms","Tenants","Floor","Rent","RentPerPerson","Utlities","From","Until","Gender","Comments","Longitude","Latitude","Distance","WalkingTime")
write.csv(final,"..//data//cleanedaptdata.csv")