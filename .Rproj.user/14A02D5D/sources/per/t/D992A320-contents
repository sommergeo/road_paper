library(tidyverse)
library(readr)
library(sf)

# Import data
table <- read_delim("fig_coverage/road_coverage.csv", 
                    delim = ";", escape_double = FALSE, trim_ws = TRUE)

table[is.na(table$locality.x)|is.na(table$locality.y),] # Show localities without coordinates
table[is.na(table$locality.idlocality),] # Show localities without locality name

table <- table %>% drop_na(c(locality.x, locality.y))


# Aggregate assemblages per locality
table2 <- table %>% count(locality.idlocality, locality.x, locality.y)

table2[duplicated(table2$locality.idlocality),] # Show localities with duplicates, double coordinates etc.


# Make geodata
points <- st_as_sf(x = table2,                         
               coords = c("locality.x", "locality.y"),
               #crs = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0",
               crs = st_crs(4326))

# Make map
world_shape <- rnaturalearth::ne_countries(scale = 110, type = 'countries', continent = c('europe', 'africa', 'asia', 'oceania'), returnclass = 'sf')

ggplot()+
  geom_sf(data=world_shape, color = "black", fill = "gray")+
  geom_sf(data=points, aes(size=n, color=n), fill=NA)+
  coord_sf(crs = "+init=epsg:4326", xlim=c(-20, 180), ylim = c(-90, +90), expand=F)+
  scale_size_continuous(breaks=c(1,10,100,1000), labels=c(1,10,100,1000))+
  theme(panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5), 
        panel.background = element_rect(fill = "white"))



