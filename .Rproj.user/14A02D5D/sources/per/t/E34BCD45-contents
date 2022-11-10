library(tidyverse)
library(readr)


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

# Plot timeline
ggplot()+
  geom_histogram(data=road_sources, aes(x=publication_view.publication_year), binwidth = 1, fill='#4D4E6B')+
  scale_x_continuous(breaks = seq(0, 2030, by = 10), limits=c(1865,2022), expand = c(0,0))+
  scale_y_continuous(breaks = c(0, 10, 50, 100, 150, 200), expand = c(0,0))+
  labs(x='Year of publication', y='Count')+
  theme_pub()+
  theme(panel.grid.major.y = element_line(),
        plot.margin = margin(l=6, t=6, b=6, r=6, 'pt'))
  
ggsave('fig_sources/fig_sources.png', width=180, height=60, units='mm', dpi=300, bg='white')

# Most cited publications
most_cited <- road_sources %>%
  count(publication_view.source_title, sort=T)



xlsx::write.xlsx(most_cited, 'fig_sources/most_cited.xlsx', sheetName = "Sheet1", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

lorenz_sections <- data.frame(
  t1 <- filter(most_cited, n==1) %>% summarise(sources=n(), titles=sum(n)) %>% mutate(sources_pc=sources/count(most_cited), titles_pc=titles/sum(most_cited$n)),
  t10 <- filter(most_cited, n>1 & n<=10) %>% summarise(sources=n(), titles=sum(n)) %>% mutate(sources_pc=sources/count(most_cited), titles_pc=titles/sum(most_cited$n)),
  t50 <- filter(most_cited, n>10 & n<=50) %>% summarise(sources=n(), titles=sum(n)) %>% mutate(sources_pc=sources/count(most_cited), titles_pc=titles/sum(most_cited$n))
)

library(gglorenz)
ggplot(data=most_cited, aes(n), color='#4D4E6B')+
  geom_abline(linetype = "dashed", color='black')+
  coord_fixed() +
  scale_x_continuous(expand = c(0,0), labels = scales::percent_format(accuracy = 1))+
  scale_y_continuous(expand = c(0,0),labels = scales::percent_format(accuracy = 1))+
  stat_lorenz(desc=F)+
  geom_curve(
    aes(x = 0.626, y = 0.305, xend = 0.726, yend = 0.205), curvature=-0.5,
    arrow = arrow(length = unit(4, 'pt'))
  )+
  geom_text(aes(x = 0.626, y = 0.305, label = "Sources\nwith 1 title"), 
            hjust = 1.1, 
            vjust = 0.5, 
            size = 2.8)+
  #geom_segment(aes(x = 0.726, y = 0.265, xend = 0.726, yend = 0.205),
  #             arrow = arrow(length = unit(4, "pt")))+
  geom_segment(aes(x = 0.855, y = 0.450, xend = 0.955, yend = 0.450),
               arrow = arrow(length = unit(4, "pt")))+
  geom_text(aes(x = 0.855, y = 0.450, label = "Sources\nwith 10 titles"), 
            hjust = 1.1, 
            vjust = 0.5, 
            size = 2.8)+
  geom_segment(aes(x = 0.890, y = 0.667, xend = 0.990, yend = 0.667),
               arrow = arrow(length = unit(4, "pt")))+
  geom_text(aes(x = 0.890, y = 0.667, label = "Sources\nwith 50 titles"), 
            hjust = 1.1, 
            vjust = 0.5, 
            size = 2.8)+
  labs(x = "Cumulative percentage of sources",
       y = "Cumulative percentage of titles")+
  theme_pub()+
  theme(plot.margin = margin(l=6, t=6, b=6, r=6, 'pt'),
        panel.border = element_rect(colour = "black", fill=NA, size=1))
  
ggsave('fig_sources/fig_sources_lorenz.png', width=90, height=90, units='mm', dpi=300, bg='white')
