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
## Download background maps
world <- rnaturalearth::ne_countries(scale = 110, returnclass = 'sf')
world_roceeh <- rnaturalearth::ne_countries(scale = 110, type = 'countries', continent = c('europe', 'africa', 'asia'), returnclass = 'sf')

## Prepare background maps
world <- world %>% st_transform(crs=st_crs(4326)) %>% st_make_valid()
world_roceeh <- world_roceeh %>% st_transform(crs=st_crs(4326)) %>% st_make_valid()

# Set target crs
target_crs <- st_crs("+proj=wink2 +lon_0=60 +lat_1=50.4597762521898 +x_0=0 +y_0=0 +R=6371000 +units=m +no_defs")

# define a long & slim polygon that overlaps the meridian line & set its CRS to match that of world
# Centered in lon 60 on this example

offset <- 180-60

polygon <- st_polygon(x = list(rbind(
  c(-0.0001 - offset, 90),
  c(0 - offset, 90),
  c(0 - offset, -90),
  c(-0.0001 - offset, -90),
  c(-0.0001 - offset, 90)
))) %>%
  st_sfc() %>%
  st_set_crs(4326)

# Remove slim polygon
world <- world %>% st_difference(polygon)
world_roceeh <- world_roceeh %>% st_difference(polygon)


ggplot()+
  geom_sf(data=world, color = "lightgrey", fill = "lightgray")+
  geom_sf(data=world_roceeh, color = "darkgray", fill = "gray")+
  geom_sf(data=points, aes(size=n, color=n), fill=NA, alpha=.5)+
  #coord_sf(crs = "+init=epsg:4326", xlim=c(-20, 180), ylim = c(-90, +90), expand=F)+
  #coord_sf(crs = "+proj=moll +lon_0=60 +x_0=0 +y_0=0 +R=6371000 +units=m +no_defs")+
  #coord_sf(crs = "+proj=wink2 +lon_0=60 +lat_1=50.4597762521898 +x_0=0 +y_0=0 +R=6371000 +units=m +no_defs")+
  #coord_sf(crs = "+proj=eck4 +lon_0=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs",xlim=c(-2400000, 180), expand=F)+
  coord_sf(crs = "+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs",xlim=c(-7500000,8600000), ylim=c(-4500000,8000000), expand=T)+
  #coord_sf(crs = "+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs", expand=F)+
  scale_x_continuous(breaks = seq(-180, 180, by = 30))+
  scale_y_continuous(breaks = seq(-90, 90, by = 30))+
  scale_size_continuous(breaks=c(1,10,100,1000), labels=c(1,10,100,1000), limits = c(0,1000))+
  theme(panel.grid.major = element_line(color = 'lightgray', linetype = "solid", size = 0.5),
        panel.grid.minor = element_line(color = 'lightgray', linetype = "solid", size = 0.5),
        panel.background = element_rect(color = 'gray', fill='lightblue'))



# Notes ----
#https://stackoverflow.com/questions/68505391/stop-maps-from-wrapping-when-reprojected-in-r