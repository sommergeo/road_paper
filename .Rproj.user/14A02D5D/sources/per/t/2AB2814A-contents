library(tidyverse)
library(readr)

# Import data
table1 <- read_delim("fig_coverage_temporal/road_coverage_arch_layer_age.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                      skip = 1) %>% 
  mutate(age_range=pmax(positive_standard_deviation, negative_standard_deviation)) %>% 
  select(age_mean=age, age_range, dating_method)

table2 <- read_delim("fig_coverage_temporal/road_coverage_assemblage_layer_age.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                      skip = 1) %>% 
  mutate(age_range=pmax(positive_standard_deviation, negative_standard_deviation)) %>% 
  select(age_mean=age, age_range, dating_method)

table3 <- read_delim("fig_coverage_temporal/road_coverage_geo_layer_age.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                      skip = 1) %>% 
  mutate(age_range=pmax(positive_standard_deviation, negative_standard_deviation)) %>% 
  select(age_mean=age, age_range, dating_method)

table <- rbind(table1, table2, table3)
table <- table %>% mutate(dating_method=recode(dating_method,
                                                    '14C (radiocarbon) dating'='14C',
                                                    'OSL (optically stimulated thermoluminescence) dating' = 'OSL',
                                                    'U series (uranium-thorium) dating'='U series (Th/U, U/U, Pb/U)',
                                                    'ESR (electron spin resonance) dating' = 'ESR',
                                                    'TL (thermoluminescence) dating'='TL, ITL',
                                                    'ESR (electron spin resonance) dating, U series (uranium-thorium) dating' = 'Multiple methods',
                                                    'Ar/Ar (argon-argon) dating'='Ar/Ar, K/Ar',
                                                    'IRSL (infrared stimulated luminescence) dating'='IRSL, IRSL post-IR, IR-RF',
                                                    'AAR (amino acid racemization) dating'='Other',
                                                    'IRSL post-IR (post-infrared infrared stimulated luminescence) dating'='IRSL, IRSL post-IR, IR-RF',
                                                    'U series (uranium-lead) dating'='U series (Th/U, U/U, Pb/U)',
                                                    'K/Ar (potassium-argon) dating'='Ar/Ar, K/Ar',
                                                    'unknown'='Unknown',
                                                    'Al/Be (aluminum-beryllium) dating'='Cosmogenic nuclide',
                                                    'cosmogenic nuclide dating'='Cosmogenic nuclide',
                                                    'biostratigraphy'='Other',
                                                    'IRSL (infrared stimulated luminescence) dating, TL (thermoluminescence) dating'= 'Multiple methods',
                                                    'oxygen isotope stratigraphy, magnetic susceptibility'='Other',
                                                    'ESR (electron spin resonance) dating, U series (uranium-lead) dating, U series (uranium-thorium) dating'='Multiple methods',
                                                    'magnetostratigraphy'='Other',
                                                    '14C (radiocarbon) dating, ESR (electron spin resonance) dating'='Multiple methods',
                                                    'geology'='Other',
                                                    'IR-RF (infrared radiofluorescence) dating'='IRSL, IRSL post-IR, IR-RF',
                                                    'ITL (isothermal thermoluminescence) dating'='TL, ITL',
                                                    'oxygen isotope stratigraphy'='Other',
                                                    'fission track dating'='Other',
                                                    'OSL (optically stimulated thermoluminescence) dating, IRSL (infrared stimulated luminescence) dating, TL (thermoluminescence) dating'='Multiple methods',
                                                    'magnetic susceptibility'='Other',
                                                    'OSL (optically stimulated thermoluminescence) dating, TL (thermoluminescence) dating'= 'Multiple methods',
                                                    'Al/Be (aluminum-beryllium) dating, cosmogenic nuclide dating'='Multiple methods',
                                                    'obsidian hydration dating'='Other',
                                                    'TL (thermoluminescence) dating, IRSL (infrared stimulated luminescence) dating'='Multiple methods',
                                                    'Ar/Ar (argon-argon) dating, geology' = 'Ar/Ar, K/Ar',
                                                    'geology, magnetostratigraphy'='Other',
                                                    'IRSL (infrared stimulated luminescence) dating, OSL (optically stimulated thermoluminescence) dating'='Multiple methods',
                                                    'Rb/Sr (rubidium-strontium) dating'='Other',
                                                    'tephrostratigraphy'='Other'))
                                                        
table$dating_method <- table$dating_method %>% replace_na('Unknown')

table <- table %>% mutate(dating_method = factor(dating_method, levels=c('14C','OSL','U series (Th/U, U/U, Pb/U)','ESR','TL, ITL',
                                                                           'Ar/Ar, K/Ar','IRSL, IRSL post-IR, IR-RF',
                                                                           'Cosmogenic nuclide','Multiple methods','Other','Unknown')))



table %>% count(dating_method, sort=T)


## Theme
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

color_discrete <- c('#a70d1f','#a59837','#f07241','#383846','#e7d448','#4d4e6b','#2e5440','#5d9ca5','black','gray40','gray60')

# Plot ----

plt1 <- ggplot()+
  #coord_fixed()+
  geom_rect(aes(xmin = 20000, xmax = 3000000, ymin = 0, ymax = Inf, fill='scope'))+
  geom_point(data=table, aes(x=age_mean, y=age_range, color=dating_method), alpha=1, shape=20, size=1)+
  scale_x_log10(breaks = c(1000, 10000, 100000, 1000000, 6000000), limits=c(100,6000000),
                labels = c(1, 10, 100, 1000, 6000), expand = c(0,0))+
  scale_y_log10(breaks = c(1000, 10000, 100000, 1000000, 4000000), limits=c(10,6000000),
                labels = c(1, 10, 100, 1000, 4000), expand = c(0,0))+
  annotation_logticks()+
  labs(x='Mean age (ka BP)', y='Age uncertainty (ka)')+
  scale_fill_manual(name=NULL,
                    values = '#dddddd',
                    labels = c('Temporal scope'),
                    guide = guide_legend(override.aes = list(alpha = 1)))+
  scale_color_manual(name='Dating method', values=color_discrete)+
  theme_pub()+
  theme(legend.position='right',
    #legend.background = element_rect(fill='#FFFFFF00',
    #                                 size=.5, linetype="solid", 
    #                                 colour = NA),
    #legend.key=element_blank(),
    legend.spacing.y = unit(0, 'pt'),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    plot.margin = margin(l=6, t=6, b=6, r=12, 'pt'))+
  guides(color = guide_legend(ncol = 1, byrow = TRUE))

plt1
ggsave('fig_coverage_temporal/fig_coverage_temporal.png', width=180, height=110, units='mm', dpi=300)
