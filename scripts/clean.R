library(readxl)

apt <- read_excel("apartments.xlsx")
names(apt)
# [1] "Timestamp"                 "Name"                     
# [3] "E-Mail ID"                 "Phone Number"             
# [5] "Sublet/Lease extension?"   "Full address"             
# [7] "Locality"                  "No. of bedrooms available"
# [9] "No. of tenants reqd."      "Floor"                    
# [11] "Rent"                      "Available from"           
# [13] "Available until"           "Looking for:"             
# [15] "Other comments " 
relevant <- apt[,c(5,7,8,9,10,11,12,13,14,15)]
