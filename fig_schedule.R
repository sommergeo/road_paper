library(tidyverse)
library(readr)
library(scico)
library(sf)
library(ggspatial)
library(cowplot)




road_schedule <- read_delim("fig_schedule/road_schedule.csv", 
                            delim = ";", escape_double = FALSE, col_types = cols(locality.created = col_date(format = "%d.%m.%Y"), 
                                                                                 assemblage.created = col_date(format = "%d.%m.%Y"),
                                                                                 ...7 = col_skip()), trim_ws = TRUE)

table <- road_schedule %>% group_by(locality.country) %>% summarise(created=min(assemblage.created)) %>% mutate(year=as.numeric(format(created, format='%Y')))

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

color_gradient <- c('#ffd28a','#fdc287','#f9b387','#f2a588','#e8988a','#dc8c8b','#cd828d','#bd798d','#ab718c','#986a89','#856384','#715c7d','#5f5575','#4d4e6b') #https://colordesigner.io/gradient-generator/?mode=lch#fafa6e-2A4858


plt1<- ggplot()+
  geom_sf(data=world, aes(fill=factor(year), color=factor(year)), lwd=.01)+
  coord_sf(crs = '+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs',xlim=c(-7500000,8600000), ylim=c(-4500000,8000000), expand=T)+
  scale_x_continuous(breaks = seq(-180, 180, by = 30))+
  scale_y_continuous(breaks = seq(-90, 90, by = 30))+
  scale_color_manual(values=rev(color_gradient), na.value = '#DDDDDD', breaks=seq(2009,2022))+
  scale_fill_manual(values=rev(color_gradient), na.value = '#DDDDDD', breaks=seq(2009,2022))+
  #scale_fill_scico(
  #  palette = 'batlow', begin = 0.1, limits = c(2009, 2022),
    #name = 'Start', breaks = seq(2009,2022),
    #guide = guide_colorsteps(barwidth = 20, barheight = .5,
    #                         title.position = "top", title.hjust = 0.5, show.limits = TRUE)
  #) +
  #scale_color_scico(
  #  palette = 'batlow', begin = 0.1, limits = c(2009, 2022),
    #name = 'Start', breaks = seq(2009,2022),
    #guide = guide_colorsteps(barwidth = 20, barheight = .5,
    #                         title.position = "top", title.hjust = 0.5, show.limits = TRUE)
  #) +
  annotation_scale(location = 'bl', width_hint = 0.2) +
  theme_pub()+
  theme(panel.grid.major = element_line(color = '#DDDDDD', linetype = 'solid', size = 0.2),
        #panel.background = element_rect(color = 'black', fill='#5D9CA5'),
        panel.border = element_rect(colour = "black", fill=NA, size=.5),
        #legend.position='bottom',
        legend.position='None',
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


# Timeline ----
year_breaks <- seq(as.Date("2009-01-01"), as.Date("2023-01-01"), "years")
year_labels <- seq(as.Date("2008-01-01"), as.Date("2023-01-01"), "2 years")
quarter_breaks <- seq(as.Date("2009-01-01"), as.Date("2023-01-01"), "quarters")

plt2 <- ggplot()+
  geom_histogram(data=road_schedule, aes(x=locality.created, fill=cut(locality.created, breaks=year_breaks)), breaks=quarter_breaks)+
  #scale_fill_scico_d(palette = 'batlow', begin = 0.1) +
  scale_fill_manual(values=rev(color_gradient), breaks=year_breaks)+
  scale_x_date(breaks=year_labels, date_labels = "%Y", limits = as.Date(c('2008-01-01','2022-12-31')), expand = c(0,0))+
  scale_y_continuous(expand = c(0,0))+
  labs(x='Year', y='Number of assemblages created')+
  theme_pub()+
  theme(panel.grid.major.y = element_line(color = '#DDDDDD', linetype = 'solid', size = 0.2),
        legend.position='None',
        plot.margin = margin(l=12, t=6, b=6, r=12, 'pt'))

plt2

ggsave('fig_schedule/fig_schedule_B.png', width=180, height=180, units='mm', dpi=300)

# Combine plots ----
plt <- plot_grid(plt1, plt2, labels = c('A', 'B'), align='h', axis='tb', label_size = 10, ncol=2, rel_widths = c(1,0.74))
plt

ggsave('fig_schedule/fig_schedule.png', width=180, height=80, units='mm', dpi=300, bg='black')

# Old stuff ----
plt1<- ggplot()+
  geom_sf(data=world, aes(fill=year, color=year), lwd=.01)+
  coord_sf(crs = '+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs',xlim=c(-7500000,8600000), ylim=c(-4500000,8000000), expand=T)+
  scale_x_continuous(breaks = seq(-180, 180, by = 30))+
  scale_y_continuous(breaks = seq(-90, 90, by = 30))+
  scale_fill_scico(
    palette = 'batlow', begin = 0.1, limits = c(2009, 2022),
  name = 'Start', breaks = seq(2009,2022),
  guide = guide_colorsteps(barwidth = 20, barheight = .5,
                           title.position = "top", title.hjust = 0.5, show.limits = TRUE)
  ) +
  scale_color_scico(
    palette = 'batlow', begin = 0.1, limits = c(2009, 2022),
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
