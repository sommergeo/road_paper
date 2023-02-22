library(tidyverse)
library(readr)

# Import data
table1 <- read_delim("fig_coverage_temporal/table_archaeological_layer_age.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                      skip = 1) %>% 
  mutate(age_range=pmax(positive_standard_deviation, negative_standard_deviation)) %>% 
  select(age_mean=age, age_range, dating_method)

table2 <- read_delim("fig_coverage_temporal/table_assemblage_age.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                      skip = 1) %>% 
  mutate(age_range=pmax(positive_standard_deviation, negative_standard_deviation)) %>% 
  select(age_mean=age, age_range, dating_method)

table3 <- read_delim("fig_coverage_temporal/table_geological_layer_age.csv", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                      skip = 1) %>% 
  mutate(age_range=pmax(positive_standard_deviation, negative_standard_deviation)) %>% 
  select(age_mean=age, age_range, dating_method)

table <- rbind(table1, table2, table3)
table <- table %>% mutate(dating_method=recode(dating_method,
                                                    '14C (radiocarbon) dating'='14C',
                                                    'OSL (optically stimulated thermoluminescence) dating' = 'OSL',
                                                    'U series (uranium-thorium) dating'='U series',
                                                    'ESR (electron spin resonance) dating' = 'ESR',
                                                    'TL (thermoluminescence) dating'='TL',
                                                    'ESR (electron spin resonance) dating, U series (uranium-thorium) dating' = 'Multiple methods',
                                                    'Ar/Ar (argon-argon) dating'='Ar series',
                                                    'IRSL (infrared stimulated luminescence) dating'='Infrared',
                                                    'AAR (amino acid racemization) dating'='Other',
                                                    'IRSL post-IR (post-infrared infrared stimulated luminescence) dating'='Infrared',
                                                    'U series (uranium-lead) dating'='U series',
                                                    'K/Ar (potassium-argon) dating'='Ar series',
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
                                                    'IR-RF (infrared radiofluorescence) dating'='Infrared',
                                                    'ITL (isothermal thermoluminescence) dating'='TL',
                                                    'oxygen isotope stratigraphy'='Other',
                                                    'fission track dating'='Other',
                                                    'OSL (optically stimulated thermoluminescence) dating, IRSL (infrared stimulated luminescence) dating, TL (thermoluminescence) dating'='Multiple methods',
                                                    'magnetic susceptibility'='Other',
                                                    'OSL (optically stimulated thermoluminescence) dating, TL (thermoluminescence) dating'= 'Multiple methods',
                                                    'Al/Be (aluminum-beryllium) dating, cosmogenic nuclide dating'='Multiple methods',
                                                    'obsidian hydration dating'='Other',
                                                    'TL (thermoluminescence) dating, IRSL (infrared stimulated luminescence) dating'='Multiple methods',
                                                    'Ar/Ar (argon-argon) dating, geology' = 'Ar series',
                                                    'geology, magnetostratigraphy'='Other',
                                                    'IRSL (infrared stimulated luminescence) dating, OSL (optically stimulated thermoluminescence) dating'='Multiple methods',
                                                    'Rb/Sr (rubidium-strontium) dating'='Other',
                                                    'tephrostratigraphy'='Other'))
                                                        
table$dating_method <- table$dating_method %>% replace_na('Unknown')
nrow(table) # total number of 'temporal information'

table <- table %>% 
  filter(!dating_method %in% c('Multiple methods', 'Other', 'Unknown'))
table <- table %>% 
  filter(!age_range==1000000) %>% 
  mutate(dating_method = factor(dating_method, levels=table %>% count(dating_method, sort=T) %>% pull(dating_method)))  # Reorder factor by size


table %>% count(dating_method, sort=T)
nrow(table)

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

color_discrete <- c('#a70d1f','#a59837','#f07241','#383846','#e7d448','#4d4e6b','#2e5440','#5d9ca5')
label_discrete <- paste0(levels(table$dating_method),' (n=',table %>% count(dating_method, sort=T) %>% pull(n),')')  # Combine names with n

# Plot ----
library("scales")
reverselog_trans <- function(base = exp(1)) {
  trans <- function(x) -log(x, base)
  inv <- function(x) base^(-x)
  trans_new(paste0("reverselog-", format(base)), trans, inv, 
            log_breaks(base = base), 
            domain = c(1e-100, Inf))
}


plt1 <- ggplot()+
  coord_fixed()+
  geom_rect(aes(xmin = 20000, xmax = 3000000, ymin = 0, ymax = Inf, fill='scope'))+
  geom_point(data=table, aes(x=age_mean, y=age_range, color=dating_method), alpha=1, shape=20, size=1)+
  scale_x_continuous(breaks = c(6000000, 1000000, 100000, 10000, 1000,100), limits=c(6000000,100),
                                   labels = c(6000, 1000, 100, 10, 1,.1), expand = c(0,0), trans=reverselog_trans(10))+
  
  #scale_x_log10(breaks = c(1000, 10000, 100000, 1000000, 6000000), limits=c(100,6000000),
  #              labels = c(1, 10, 100, 1000, 6000), expand = c(0,0))+
  scale_y_log10(breaks = c(100, 1000, 10000, 100000, 1000000, 3000000), limits=c(10,3000000),
                labels = c(.1, 1, 10, 100, 1000, 3000), expand = c(0,0))+
  annotation_logticks()+
  labs(x='Mean age (ka BP)', y='Age uncertainty (ka)')+
  scale_fill_manual(name=NULL,
                    values = '#FFD28A',
                    labels = c('Project timeframe'),
                    guide = guide_legend(override.aes = list(alpha = 1)))+
  scale_color_manual(name='Dating method', values=color_discrete, labels=label_discrete)+
  theme_pub()+
  theme(legend.position='right',
    legend.spacing.y = unit(0, 'pt'),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    plot.margin = margin(l=6, t=6, b=6, r=12, 'pt'))+
  guides(color = guide_legend(ncol = 1, byrow = TRUE))

plt1
ggsave('fig_coverage_temporal/fig_coverage_temporal.png', width=132, height=90, units='mm', dpi=300, bg='white')
ggsave('fig_coverage_temporal/fig_coverage_temporal.tiff', width=132, height=90, units='mm', dpi=300, bg='white')
ggsave('fig_coverage_temporal/fig_coverage_temporal.pdf', width=132, height=90, units='mm', bg='white')

#https://colordesigner.io/gradient-generator