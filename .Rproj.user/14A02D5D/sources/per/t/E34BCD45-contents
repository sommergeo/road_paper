library(tidyverse)
library(readr)
library(gglorenz)
library(cowplot)


# Import data
road_sources <- read_delim("fig_sources/road_sources.csv", 
                           delim = ";", escape_double = FALSE, 
                           col_types = cols(...4 = col_skip()), trim_ws = TRUE)
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



# Most cited publications
most_cited <- road_sources %>%
  count(publication_view.source_title, sort=T) %>% 
  mutate(perc=n/sum(n), cumsum = cumsum(n), cumsum_perc=cumsum/sum(n), rank=row_number(), rank_perc=rank/length(rank))

road_sources %>% count(publication_view.publication_year, sort=T)



xlsx::write.xlsx(most_cited, 'fig_sources/most_cited.xlsx', sheetName = "Sheet1", 
                 col.names = TRUE, row.names = TRUE, append = FALSE)

# Plot timeline
plt1 <- ggplot()+
  geom_histogram(data=road_sources, aes(x=publication_view.publication_year), binwidth = 1, fill='#4D4E6B')+
  scale_x_continuous(breaks = seq(0, 2030, by = 20), limits=c(1865,2023), expand = c(0,0))+
  scale_y_continuous(breaks = c(0, 10, 50, 100, 150, 200), expand = c(0,0))+
  labs(x='Year of publication', y='Count')+
  theme_pub()+
  theme(panel.grid.major.y = element_line(color = '#CCCCCC', linetype = 'solid', size = 0.4),
        plot.margin = margin(l=6, t=6, b=6, r=6, 'pt'))
plt1
  
ggsave('fig_sources/fig_sources_A.png', width=180, height=90, units='mm', dpi=300, bg='white')



# Plot Lorenz curve
plt2 <- ggplot(data=most_cited, aes(n), color='#4D4E6B')+
  geom_abline(linetype = "solid", color='#CCCCCC')+
  coord_fixed() +
  scale_x_continuous(expand = c(0,0), labels = scales::percent_format(accuracy = 1))+
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(accuracy = 1))+
  stat_lorenz(desc=F, color='#4D4E6B')+
  geom_curve(
    aes(x=0.9-rank_perc[375], y=1.1-cumsum_perc[397], xend=1-rank_perc[397], yend=1-cumsum_perc[397]), curvature=-0.5,
    arrow = arrow(length = unit(4, 'pt'))
  )+
  geom_label(aes(x=0.9-rank_perc[375],  y=1.1-cumsum_perc[397], label = 'Single titles comprise\n20% (n=1027) of titles'), 
            hjust = 1.1, 
            vjust = 0.5, 
            size = 2.8, fill='white', label.size=NA)+
  geom_segment(aes(x=0.9-rank_perc[10], y=1-cumsum_perc[10], xend=1-rank_perc[10], yend=1-cumsum_perc[10]),
               arrow = arrow(length = unit(4, "pt")))+
  geom_label(aes(x=0.9-rank_perc[10],y=1-cumsum_perc[10], label = "10 journals account for\n29% (n=1476) of titles"), 
            hjust = 1, 
            vjust = 0.5, 
            size = 2.8, fill='white', label.size=NA)+
  labs(x = "Cumulative percentage of sources",
       y = "Cumulative percentage of titles")+
  theme_pub()+
  theme(plot.margin = margin(l=6, t=6, b=6, r=6, 'pt'),
        panel.border = element_rect(colour = "black", fill=NA))
plt2

ggsave('fig_sources/fig_sources_B.png', width=90, height=90, units='mm', dpi=300, bg='white')




# Combine plots
plt <- plot_grid(plt1, plt2, labels = c('A', 'B'), align='h', axis='tb', label_size = 10, ncol=2, rel_widths = c(100,80))
plt

ggsave('fig_sources/fig_sources.png', width=190.5, height=75, units='mm', dpi=300, bg='white')
ggsave('fig_sources/fig_sources.tiff', width=190.5, height=75, units='mm', dpi=300, bg='white')



# Stats ----
nrow(road_sources)  # number of titles
nrow(most_cited)  # number of sources
median(road_sources$publication_view.publication_year)  # median
most_cited$cumsum_perc[10]  # % of titles in top 10 journals
most_cited %>% filter(rank<=10) %>% summarise(sum(n)) # number of titles in top 10 journals
most_cited %>% filter(n==1) %>% summarise(1-min(cumsum_perc)) %>% pull()  # % of single titles
most_cited %>% filter(n==1) %>% summarise(sum(n))  # number of single titles


