library(readxl)
library(ggmap)

apt <- read_excel("apartments.xlsx")
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
locs <- geocode(relevantCols[,2])
final <- data.frame(relevantCols,locs)
names(final) <- c("SubletLease","Address","Locality","Bedrooms","Tenants","Floor","Rent","RentPerPerson","Utlities","From","Until","Gender","Comments","Longitude","Latitude")
write.csv(final,"cleanedaptdata.csv")