library(tidyverse)
library(readr)


# Import data
road_sources <- read_delim("fig_sources/road_sources.csv", 
                           delim = ";", escape_double = FALSE, 
                           col_types = cols(...3 = col_skip()), trim_ws = TRUE)
road_sources <- road_sources %>% filter(publication_view.publication_year != 0) # Remove publications from Jesus' birth year

theme_pub <-  function(){
  list(theme_classic(),
       theme(text=element_text(size=8), #change font size of all text
             axis.text=element_text(size=8), #change font size of axis text
             axis.title=element_text(size=8), #change font size of axis titles
             plot.title=element_text(size=8), #change font size of plot title
             legend.text=element_text(size=8), #change font size of legend text
             legend.title=element_text(size=8),
             ))
}

# Plot timeline
ggplot()+
  geom_histogram(data=road_sources, aes(x=publication_view.publication_year), binwidth = 1, fill='#4D4E6B')+
  scale_x_continuous(breaks = seq(0, 2030, by = 10), limits=c(1865,2022))+
  scale_y_continuous(breaks = c(0, 10, 50, 100, 150, 200))+
  labs(x='Year of publication', y='Count')+
  theme_pub()+
  theme(panel.grid.major.y = element_line(),
        plot.margin = margin(l=6, t=6, b=6, r=6, 'pt'))
  
ggsave('fig_sources/fig_sources.png', width=180, height=60, units='mm', dpi=300, bg='white')
