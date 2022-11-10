library(tidyverse)
library(readr)
library(scico)
library(sf)
library(ggspatial)



# Import data
road_schedule <- read_delim("fig_schedule/road_schedule.csv", 
                            delim = ";", escape_double = FALSE, col_types = cols(country_continent.continent = col_skip(), 
                                                                                 locality.idlocality = col_skip(), 
                                                                                 locality.created = col_date(format = "%d.%m.%Y"), 
                                                                                 ...5 = col_skip()), trim_ws = TRUE)

table <- road_schedule %>% group_by(locality.country) %>% summarise(created=min(locality.created)) %>% mutate(year=as.numeric(format(created, format='%Y')))

theme_pub <-  function(){
  list(theme_classic(),
       theme(text=element_text(size=8), #change font size of all text
             axis.text=element_text(size=8), #change font size of axis text
             axis.title=element_text(size=8), #change font size of axis titles
             plot.title=element_text(size=8), #change font size of plot title
             legend.text=element_text(size=8), #change font size of legend text
             legend.title=element_text(size=8)
       ))
}

# Merge ROAD with geodata
## Load geodata
world <- rnaturalearth::ne_countries(scale = 110, returnclass = 'sf') %>% st_transform(crs=st_crs(4326)) %>% st_make_valid()

## Find difference in country names
intersect(table$locality.country, world$admin)
setdiff(table$locality.country, world$admin)
world$admin

## Align countries with natural earth data (i will regret this)
table <- table %>% mutate(locality.country=recode(locality.country,
                                                  'Congo, Republic of the' = 'Swaziland',
                                                  'Eswatini' = 'Swaziland',
                                                  'Congo, Republic of the' = 'Democratic Republic of the Congo',
                                                  'Serbia'= 'Republic of Serbia',
                                                  'North Macedonia'= 'Macedonia',
                                                  'Tanzania'='United Republic of Tanzania'))

## Join 
world <- left_join(world, table, by = c("admin" = 'locality.country'))

## Prepare geodata
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

world <- world %>% st_difference(polygon)


## Map
ggplot()+
  geom_sf(data=world, aes(fill=year))

plt1<- ggplot()+
  geom_sf(data=world, aes(fill=year, color=year))+
  coord_sf(crs = '+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs',xlim=c(-7500000,8600000), ylim=c(-4500000,8000000), expand=T)+
  scale_x_continuous(breaks = seq(-180, 180, by = 30))+
  scale_y_continuous(breaks = seq(-90, 90, by = 30))+
  scale_fill_scico(
    palette = 'batlow', begin = 0.1, limits = c(2009, 2023),
    name = 'Start', breaks = seq(2009,2022),
    guide = guide_colorsteps(barwidth = 20, barheight = .5,
                             title.position = "top", title.hjust = 0.5, show.limits = TRUE)
  ) +
  scale_color_scico(
    palette = 'batlow', begin = 0.1, limits = c(2009, 2023),
    name = 'Start', breaks = seq(2009,2022),
    guide = guide_colorsteps(barwidth = 20, barheight = .5,
                             title.position = "top", title.hjust = 0.5, show.limits = TRUE)
  ) +
  annotation_scale(location = 'bl', width_hint = 0.2) +
  theme_pub()+
  theme(panel.grid.major = element_line(color = '#DDDDDD', linetype = 'solid', size = 0.2),
        #panel.background = element_rect(color = 'black', fill='#5D9CA5'),
        panel.border = element_rect(colour = "black", fill=NA, size=1),
        legend.position='bottom',
        #legend.justification = c(1, 0), legend.position = c(0.99, 0.01),
        #legend.title = element_text(colour="black", size=8),
        #legend.text = element_text(colour="black", size=8),
        #legend.background = element_rect(fill='#FFFFFF',
        #                                 size=.5, linetype="solid", 
        #                                 colour ="black"),
        #legend.key=element_blank(),
        plot.margin = margin(l=12, t=6, b=6, r=12, 'pt'))
plt1

ggsave('fig_schedule/fig_schedule_A.png', width=180, height=180, units='mm', dpi=300)

plt2 <- ggplot()+
  geom_density(data=road_schedule, aes(x=locality.created))

plt2
