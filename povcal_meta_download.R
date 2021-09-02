library(dplyr)
library(povcalnetR)

# metadata
df_info <- povcalnet_info(url = "http://iresearch.worldbank.org/povcalnet") %>% 
  tibble() %>% rowwise() %>% 
  mutate(year = paste(unlist(year), sep='', collapse=', '))
write.csv(df_info,"Data/PovCal Metadata.csv", row.names=FALSE)
# country level data at $1.9
df_19 <- povcalnet(
  country = "all", povline = 1.9, year = "all", aggregate = FALSE, 
  fill_gaps = TRUE, coverage = "all", ppp = NULL,
  url = "http://iresearch.worldbank.org", format = "csv"
) %>% tibble() %>% mutate(iso_a3=countrycode)
write.csv(df_19,"Data/PovCal 1D90c.csv", row.names=FALSE)

# data date
today <- Sys.Date()
fileConn<-file("Data/Date.txt")
writeLines(c(as.character.Date(today)), fileConn)
close(fileConn)