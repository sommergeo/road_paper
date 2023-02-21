library(tidyverse)
library(readr)
library(sf)
library(ggspatial)
library(cowplot)

# Import data
table <- read_delim('fig_coverage/road_coverage.csv', 
                    delim = ';', escape_double = FALSE, trim_ws = TRUE)

table[is.na(table$locality.x)|is.na(table$locality.y),] # Show localities without coordinates
table[is.na(table$locality.idlocality),] # Show localities without locality name


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

# World map ----
## Aggregate assemblages per locality
table2 <- table %>% 
  distinct(locality.idlocality, assemblage.name, .keep_all = TRUE) %>%   # filter out duplicates due to dating
  drop_na(c(locality.x, locality.y)) %>% 
  count(locality.idlocality, locality.x, locality.y, sort=T)

## Make geodata
points <- st_as_sf(x = table2,                         
               coords = c('locality.x', 'locality.y'),
               #crs = '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0',
               crs = st_crs(4326))

## Mapping
### Download background maps
world <- rnaturalearth::ne_countries(scale = 110, returnclass = 'sf') %>% st_transform(crs=st_crs(4326)) %>% st_make_valid()

### define a long & slim polygon that overlaps the meridian line & set its CRS to match that of world
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

### Remove slim polygon
world <- world %>% st_difference(polygon)

plt1<- ggplot()+
  geom_sf(data=world, color = 'white', fill = '#FFD28A', size=0.2)+
  geom_sf(data=points, aes(size=n), fill='#A70D1F', color='grey10', shape=21)+
  #coord_sf(crs = '+init=epsg:4326', xlim=c(-20, 180), ylim = c(-90, +90), expand=F)+
  #coord_sf(crs = '+proj=moll +lon_0=60 +x_0=0 +y_0=0 +R=6371000 +units=m +no_defs')+
  #coord_sf(crs = '+proj=wink2 +lon_0=60 +lat_1=50.4597762521898 +x_0=0 +y_0=0 +R=6371000 +units=m +no_defs')+
  #coord_sf(crs = '+proj=eck4 +lon_0=60 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs',xlim=c(-2400000, 180), expand=F)+
  coord_sf(crs = '+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs',xlim=c(-7500000,8600000), ylim=c(-4500000,8000000), expand=T)+
  #coord_sf(crs = '+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs', expand=F)+
  scale_x_continuous(breaks = seq(-180, 180, by = 30))+
  scale_y_continuous(breaks = seq(-90, 90, by = 30))+
  scale_size_continuous(name='Number of\nassemblages\nper locality', breaks=c(1,10,100,1000), labels=c(1,10,100,1000), limits = c(0,1000), range = c(.1, 18))+
  #scale_fill_continuous(name='Number of assemblages', low='#A70D1F', high='#A70D1F50', limits = c(0,1000))+
  #scale_color_continuous(name='Number of assemblages', low='#FFFFFF10', high='#FFFFFF99', limits = c(0,1000))+
  annotation_scale(location = 'bl', width_hint = 0.2) +
  theme_pub()+
  theme(panel.grid.major = element_line(color = '#DDDDDD', linetype = 'solid', size = 0.2),
        panel.background = element_rect(color = 'black', fill='#5D9CA5'),
        panel.border = element_rect(colour = "black", fill=NA, size=.5),
        #legend.position='right',
        legend.justification = c(1, 0), legend.position = c(0.99, 0.01),
        legend.title = element_text(colour="black", size=8),
        legend.text = element_text(colour="black", size=8),
        legend.background = element_rect(fill='#FFFFFF',
                                         size=.5, linetype="solid", 
                                         colour ="black"),
        legend.key=element_blank(),
        plot.margin = margin(l=24, t=6, b=6, r=12, 'pt'))
plt1

ggsave('fig_coverage/fig_coverage_A.png', width=180, height=150, units='mm', dpi=300)





# Bar Chart
table3 <- table %>% 
  distinct(locality.idlocality, assemblage.name, .keep_all = TRUE) %>%   # filter out duplicates due to dating
  group_by(country_continent.continent) %>% 
  summarize(no_assemblages = n_distinct(assemblage.name, locality.idlocality), no_localities = n_distinct(locality.idlocality)) %>% 
  pivot_longer(cols=-country_continent.continent, names_to = 'variable', values_to = 'value') %>% 
  mutate(country_continent.continent = factor(country_continent.continent, levels = c('Asia', 'Africa', 'Europe')))
  
  
plt2 <- ggplot()+
  geom_bar(data=table3, stat = 'identity', aes(y=country_continent.continent, x=value, fill=variable), position=position_dodge2(reverse=T))+
  scale_fill_manual(values=c('#F07241', '#A70D1F'), name='Number of', labels=c('assemblages','localities'))+
  scale_x_continuous(limits=c(0,13500), breaks = seq(0,12000,2000), expand = c(0,0))+
  labs(x='Count', y='')+
  geom_text(data=table3, stat='identity', aes(y=country_continent.continent, x=value, group=variable, label=value), position = position_dodge2(width = .9, reverse=T), hjust=-.1, size=2.8)+
  theme_pub()+
  theme(#legend.position='bottom',
        legend.justification = c(1, 0), legend.position = c(0.98, 0.02),
        legend.title = element_text(colour="black", size=8),
        legend.text = element_text(colour="black", size=8),
        legend.background = element_rect(fill='#FFFFFF',
                                         size=.5, linetype="solid", 
                                         colour ="white"),
        legend.key=element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_line(color = '#CCCCCC', linetype = 'solid', size = 0.4),
        plot.margin = margin(l=6, t=6, b=6, r=12, 'pt'))
plt2

ggsave('fig_coverage/fig_coverage_B.png', width=180, height=180, units='mm', dpi=300)




# Time chart
table <- table %>% mutate(age_mean=(query_age_max+query_age_min)/2, age_range=(query_age_max-query_age_min))

plt3 <- ggplot()+
  geom_rect(aes(xmin = 20000, xmax = 3000000, ymin = 0, ymax = Inf, fill='scope'))+
  geom_histogram(data=table, aes(x=age_mean, fill=country_continent.continent))+
  scale_x_log10(breaks = c(1000, 10000, 100000, 1000000, 6000000), limits=c(1000,6000000),
                labels = c(1, 10, 100, 1000, 6000), expand = c(0,0))+  
  scale_y_continuous(breaks=seq(0,3000,500), limits=c(0,3000),expand = c(0,0))+
  annotation_logticks(sides='b')+
  labs(x='Age (ka BP)', y='Number of assemblages')+
  scale_fill_manual(name=NULL, 
                    values = c('#F07241','#A59837','#5D9CA5','#FFD28A'), 
                    labels = c('Africa','Asia','Europe','Project\ntimeframe'), 
                    guide = guide_legend(override.aes = list(alpha = 1)))+
  theme_pub()+
  theme(legend.justification = c(0, 1), legend.position = c(0.02, 0.98),
    #legend.title = element_text(colour="black", size=8),
    #legend.text = element_text(colour="black", size=8),
    legend.background = element_rect(fill='#FFFFFF00',
                                     size=.5, linetype="solid", 
                                     colour = NA),
    legend.key=element_blank(),
    legend.spacing.y = unit(1, 'pt'),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    plot.margin = margin(l=6, t=6, b=6, r=12, 'pt'))

plt3
  


ggsave('fig_coverage/fig_coverage_C.png', width=180, height=180, units='mm', dpi=300)




# Combine plots
bottom_row <- plot_grid(plt2, plt3, labels = c('B', 'C'), align='hv', axis='tblr', label_size = 10, ncol=2)
bottom_row

top_row <- plot_grid(plt1, labels=c('A'), label_size=10)

full_plot <- plot_grid(top_row, bottom_row, nrow=2, rel_heights = c(2,.8), align='h', axis='l')
full_plot

ggsave('fig_coverage/fig_coverage.png', width=190.5, height=200, units='mm', dpi=300, bg='white')
ggsave('fig_coverage/fig_coverage.tiff', width=190.5, height=200, units='mm', dpi=300, bg='white')


# Notes ----
#https://stackoverflow.com/questions/68505391/stop-maps-from-wrapping-when-reprojected-in-r
#https://r-spatial.org/r/2018/10/25/ggplot2-sf.html
#https://stackoverflow.com/questions/66879376/align-vertical-3-plots-in-2-rows-in-cowplot-package-in-r

# Old stuff ----

#geom_rect(aes(xmin = 20000, xmax = 3000000, ymin = 0, ymax = Inf, fill='scope'))+

#geom_density(data=table, aes(x=age_mean))+
#geom_jitter(data=table, aes(x=age_mean, y=age_range, color='date'), alpha=.1, shape=20, size=1)+
#scale_x_log10(breaks = c(1000, 10000, 100000, 1000000, 6000000), limits=c(100,6000000),
#              labels = c(1, 10, 100, 1000, 6000), expand = c(0,0))+
#scale_y_log10(breaks = c(1000, 10000, 100000, 1000000, 4000000), limits=c(100,6000000),
#              labels = c(1, 10, 100, 1000, 4000), expand = c(0,0))+
#annotation_logticks()+
labs(x='Age (ka BP)', y='Age range (ka)')+
  #scale_fill_manual(name=NULL,
  #                  values = '#FFD28A',
  #                  labels = c('Temporal scope'),
  #                  guide = guide_legend(override.aes = list(alpha = 1)))+
  #scale_color_manual(name=NULL,
  #                  values = '#000000',
  #                  labels = c('Date'),
  #                  guide = guide_legend(override.aes = list(alpha = 1)))+
  theme_pub()+
  theme(#legend.position='bottom',
    #legend.justification = c(0, 1), legend.position = c(0.02, 0.98),
    #legend.title = element_text(colour="black", size=8),
    #legend.text = element_text(colour="black", size=8),
    #legend.background = element_rect(fill='#FFFFFF00',
    #                                 size=.5, linetype="solid", 
    #                                 colour = NA),
    #legend.key=element_blank(),
    #legend.spacing.y = unit(1, 'pt'),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    plot.margin = margin(l=6, t=6, b=6, r=12, 'pt'))
plt3