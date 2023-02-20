library(tidyverse)
library(readr)
library(sf)
library(ggspatial)
library(cowplot)

# Import data
## Localities with astrats
table <- read_delim("fig_archaeology/road_archaeology.csv", 
                    delim = ";", escape_double = FALSE, trim_ws = TRUE) %>% select(-...7)

table <- table  %>%
  mutate(period=archaeological_stratigraphy.cultural_period) %>% 
  filter(period %in% c('ESA','MSA','LSA','Lower Paleolithic','Middle Paleolithic','Upper Paleolithic')) %>% 
  mutate(period=recode(period, 'ESA' = 'Early Stone Age', 'MSA'='Middle Stone Age', 'LSA'='Later Stone Age')) %>% 
  mutate(period = factor(period, levels=c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age'))) %>% 
  na.omit(c(locality.x, locality.y))


## Other stuff
theme_pub <-  function(){
  list(theme_classic(),
       theme(text=element_text(size=8), #change font size of all text
             axis.text=element_text(size=8), #change font size of axis text
             axis.title=element_text(size=8), #change font size of axis titles
             plot.title=element_text(size=8), #change font size of plot title
             legend.text=element_text(size=8), #change font size of legend text
             legend.title=element_text(size=8),
             panel.grid.major.x = element_line(color = '#DDDDDD', linetype = 'solid', size = 0.2),
             axis.ticks = element_blank(),
             axis.line.x = element_blank()
       ))
}


# Maps
## Split table
table1 <- table %>% filter(period %in% c('Later Stone Age','Upper Paleolithic')) 
point1 <- st_as_sf(x = table1, coords = c('locality.x', 'locality.y'), crs = st_crs(4326))

table2 <- table %>% filter(period %in% c('Middle Stone Age','Middle Paleolithic'))
point2 <- st_as_sf(x = table2, coords = c('locality.x', 'locality.y'), crs = st_crs(4326))

table3 <- table %>% filter(period %in% c('Early Stone Age','Lower Paleolithic'))
point3 <- st_as_sf(x = table3, coords = c('locality.x', 'locality.y'), crs = st_crs(4326))

## Map template
theme_map <-  function(){
  list(scale_fill_manual(name='Cultural period', 
                         breaks = c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age'),
                         values = c('#F07241','#A70D1F','#A59837','#2E5440','#5D9CA5','#4D4E6B'), 
                         labels = c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age')),
       coord_sf(crs = '+proj=natearth2 +lon_0=60 +x_0=0 +y_0=0 +R=6371008.7714 +units=m +no_defs +type=crs',xlim=c(-7500000,8600000), ylim=c(-4500000,8000000), expand=T),
       scale_x_continuous(breaks = seq(-180, 180, by = 30)),
       scale_y_continuous(breaks = seq(-90, 90, by = 30)),
       annotation_scale(location = 'br', width_hint = 0.2),
       theme_classic(),
       theme(text=element_text(size=8), #change font size of all text
             axis.text=element_text(size=8), #change font size of axis text
             axis.title=element_text(size=8), #change font size of axis titles
             plot.title=element_text(size=8), #change font size of plot title
             legend.text=element_text(size=8), #change font size of legend text
             legend.title=element_text(size=8),
             panel.grid.major = element_line(color = '#DDDDDD', linetype = 'solid', size = 0.2),
             panel.background = element_rect(color = 'black', fill='#5D9CA5'),
             panel.border = element_rect(colour = "black", fill=NA, size=.5),
             legend.position='none',
             #legend.justification = c(1, 0), legend.position = c(0.99, 0.01),
             #legend.background = element_rect(fill='#FFFFFF',
             #                                 size=.5, linetype="solid", 
             #                                 colour ="black"),
             #legend.key=element_blank(),
             #plot.margin = margin(l=6, t=6, b=6, r=6, 'pt')
       ))
}

## Map data
world <- rnaturalearth::ne_countries(scale = 110, returnclass = 'sf') %>% st_transform(crs=st_crs(4326)) %>% st_make_valid()

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


# Figure A (Map)
plt1<- ggplot()+
  geom_sf(data=world, color = 'white', fill = '#FFD28A', size=0.2)+
  geom_sf(data=point1, aes(fill=period), color='grey10', shape=21)+
  theme_map()
plt1

ggsave('fig_archaeology/fig_archaeology_A.png', width=100, height=70, units='mm', dpi=300)

# Figure B (Map)
plt2<- ggplot()+
  geom_sf(data=world, color = 'white', fill = '#FFD28A', size=0.2)+
  geom_sf(data=point2, aes(fill=period), color='grey10', shape=21)+
  theme_map()
plt2

ggsave('fig_archaeology/fig_archaeology_B.png', width=100, height=70, units='mm', dpi=300)

# Figure C (Map)
plt3<- ggplot()+
  geom_sf(data=world, color = 'white', fill = '#FFD28A', size=0.2)+
  geom_sf(data=point3, aes(fill=period), color='grey10', shape=21)+
  theme_map()
plt3

ggsave('fig_archaeology/fig_archaeology_C.png', width=100, height=70, units='mm', dpi=300)

#Figure D
table_period <- table  %>%
  count(period) %>% 
  mutate(column = c(3,3,1,2,2,1))


plt4<- ggplot(data=table_period)+
  scale_fill_manual(name='Number of localities', 
                    breaks = c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age'),
                    values = c('#F07241','#A70D1F','#A59837','#2E5440','#5D9CA5','#4D4E6B'), 
                    labels = c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age'))+
  geom_col(aes(x=n, y=fct_rev(fct_infreq(period)), fill=period))+
  geom_text(aes(label=n, x=n, y=fct_rev(fct_infreq(period))), hjust=-.1, size=2.8)+
  labs(x='Number of localities', y='Cultural Period')+
  scale_x_continuous(limits=c(0,650), expand = c(0,0))+
  scale_y_discrete(labels = function(x) str_wrap(x, width = 19))+
  theme_pub()+
  theme(legend.position='none',
        plot.margin = margin(l=1, t=11, b=7, r=6, 'pt'))

plt4

ggsave('fig_archaeology/fig_archaeology_D.png', width=100, height=70, units='mm', dpi=300)

# Combine plots
plt <- plot_grid(plt1,plt2,plt3,plt4, 
                 labels=c('A','B','C','D'), label_size=10, ncol=2, greedy=F,
                 align='h', axis='tb', rel_widths=c(90,90))

plt
ggsave('fig_archaeology/fig_archaeology.png', width=190.5, height=160, units='mm', dpi=300, bg='white')
ggsave('fig_archaeology/fig_archaeology.tiff', width=190.5, height=160, units='mm', dpi=300, bg='white')





# Culutres table
## LUT for astrat consolidation
dict <- readxl::read_excel("fig_archaeology/arch_strat_consol.xlsx", 
                           sheet = "arch_strat_ROAD", skip = 1) %>% select(idarchstrat, consol26='new_a_strat for simple search list 2', consol40='new_a_strat for simple search list 1')

## tidy table
table_cultures <- read_delim("fig_archaeology/road_archaeology.csv", 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE) %>% select(-...7)  %>%
  mutate(astrat.consol=plyr::mapvalues(archaeological_stratigraphy.idarchstrat, from=dict$idarchstrat, to=dict$consol40)) %>% 
  count(astrat.consol) %>% 
  filter(!astrat.consol %in% c('do not use', 'Other Early Stone Age','Other Late Stone Age','Other Middle Paleolithic','Other Middle Stone Age','Other Upper Paleolithic','Lower Paleolithic')) %>% 
  filter(n>=10)

plt5 <- ggplot(data=table_cultures)+
  geom_col(aes(x=n, y=reorder(astrat.consol, n)), fill='#383846')+
  geom_text(aes(label=n, x=n, y=reorder(astrat.consol, n)), hjust=-.1, size=2.8)+
  labs(x='Number of localities', y='')+
  scale_x_continuous(limits=c(0,270), expand = c(0,0))+
  #scale_y_discrete(labels = function(x) str_wrap(x, width = 19))+
  theme_pub()
  
  
plot(plt5)  
ggsave('fig_archaeology/fig_archaeology_cultures.png', width=132, height=90, units='mm', dpi=300, bg='white')
ggsave('fig_archaeology/fig_archaeology_cultures.tiff', width=132, height=90, units='mm', dpi=300, bg='white')













theme_bars <-  function(){
  list(scale_fill_manual(name='Number of localities', 
                         breaks = c('UP','LSA','MP','MSA','LP','ESA'),
                         values = c('#F07241','#A70D1F','#A59837','#2E5440','#5D9CA5','#4D4E6B'), 
                         labels = c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age')),
       geom_bar(aes(fill=period, y=fct_rev(fct_infreq(astrat.consol)))),
       geom_text(stat='count', aes(label=..count.., y=fct_rev(fct_infreq(astrat.consol))), hjust=-.1, size=2.8),
       labs(x='Count', y='Technocomplex'),
       scale_x_continuous(limits=c(0,300), expand = c(0,0)),
       scale_y_discrete(labels = function(x) str_wrap(x, width = 19)),
       theme_classic(),
       theme(#legend.position='bottom',
         legend.justification = c(1, 0), legend.position = c(0.99, 0.01),
         text=element_text(size=8), #change font size of all text
         axis.text.x=element_text(size=8), #change font size of axis text
         axis.text.y=element_text(size=8, color='black'), #change font size of axis text
         axis.title.x=element_text(size=8), #change font size of axis titles
         axis.title.y=element_blank(), #change font size of axis titles
         plot.title=element_text(size=8), #change font size of plot title
         legend.text=element_text(size=8), #change font size of legend text
         legend.title=element_text(size=8)
       ))
}

theme_periods <-  function(){
  list(scale_fill_manual(name='Number of localities', 
                         breaks = c('UP','LSA','MP','MSA','LP','ESA'),
                         values = c('#F07241','#A70D1F','#A59837','#2E5440','#5D9CA5','#4D4E6B'), 
                         labels = c('Upper Paleolithic','Later Stone Age','Middle Paleolithic','Middle Stone Age','Lower Paleolithic','Early Stone Age')),
       geom_bar(aes(fill=period, y=fct_rev(fct_infreq(period)))),
       geom_text(stat='count', aes(label=..count.., y=fct_rev(fct_infreq(period))), hjust=-.1, size=2.8),
       labs(x='Count', y='Technocomplex'),
       scale_x_continuous(limits=c(0,300), expand = c(0,0)),
       scale_y_discrete(labels = function(x) str_wrap(x, width = 19)),
       theme_classic(),
       theme(#legend.position='bottom',
         legend.justification = c(1, 0), legend.position = c(0.99, 0.01),
         text=element_text(size=8), #change font size of all text
         axis.text.x=element_text(size=8), #change font size of axis text
         axis.text.y=element_text(size=8, color='black'), #change font size of axis text
         axis.title.x=element_text(size=8), #change font size of axis titles
         axis.title.y=element_blank(), #change font size of axis titles
         plot.title=element_text(size=8), #change font size of plot title
         legend.text=element_text(size=8), #change font size of legend text
         legend.title=element_text(size=8)
       ))
}


## LUT for astrat consolidation
dict <- readxl::read_excel("fig_archaeology/arch_strat_consol.xlsx", 
                           sheet = "arch_strat_ROAD", skip = 1) %>% select(idarchstrat, consol26='new_a_strat for simple search list 2', consol40='new_a_strat for simple search list 1')

## tidy table
table_what <- table  %>%
  separate(archaeological_stratigraphy.technocomplex, into=c('period',NA), sep='/', remove=F) %>% 
  filter(period %in% c('ESA','MSA','LSA','LP','MP','UP')) %>% 
  mutate(astrat.consol=plyr::mapvalues(archaeological_stratigraphy.idarchstrat, from=dict$idarchstrat, to=dict$consol26)) %>% 
  filter(!astrat.consol=='do not use') %>% 
  drop_na(c(locality.x, locality.y))


## Figure D
plt22<- ggplot(data=table2)+
  theme_pub()+
  theme(plot.margin = margin(l=0, t=6, b=6, r=12, 'pt'))

plt22

ggsave('fig_archaeology/fig_archaeology_D.png', width=90, height=90, units='mm', dpi=300)


## Figure F
plt32<- ggplot(data=table3)+
  theme_pub()+
  theme(plot.margin = margin(l=13, t=6, b=6, r=12, 'pt'))

plt32

ggsave('fig_archaeology/fig_archaeology_F.png', width=90, height=90, units='mm', dpi=300)


# Combine plots ----
plt <- plot_grid(plt11,plt12,plt21,plt22,plt31,plt32, 
                 labels=c('A','B','C','D','E','F'), label_size=10, ncol=2, greedy=F,
                 align='vh', axis='rtb', rel_widths=c(90,90))

plt
ggsave('fig_archaeology/fig_archaeology.png', width=180, height=210, units='mm', dpi=300, bg='white')
