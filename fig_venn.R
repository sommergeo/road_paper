library(tidyverse)
library(ggVennDiagram)


x <- list(
  A = read_csv("fig_venn/ListeA_technologyTypologyRawMatFunctionSymbolicFeatureMisc.csv", 
               col_names = FALSE, locale = locale(encoding = "ASCII"))$X1, 
  B = read_csv("fig_venn/ListeB_humanRemains.csv", 
               col_names = FALSE, locale = locale(encoding = "ASCII"))$X1, 
  C = read_csv("fig_venn/ListeC_plantRemains.csv", 
               col_names = FALSE, locale = locale(encoding = "ASCII"))$X1,
  D = read_csv("fig_venn/ListeD_paleofauna_animalRemains.csv", 
               col_names = FALSE, locale = locale(encoding = "ASCII"))$X1
)



# Venn diagram ----
ggVennDiagram(x, set_color = 'black', label='both', set_size=3, label_size = 2, edge_size = 0.5,
              category.names = c('Cultural remains', 'Human remains', 'Plant remains', 'Faunal remains'))+
  scale_x_continuous(expand = expansion(mult = .2))+
  scale_y_continuous(expand = expansion(mult = .2))+
  scale_fill_gradient(name='Number of\nLocalities',
                      #low="#ffd28a", high="#4d4e6b",
                      low='#FFD28A', high='#A70D1F', space = "Lab",
                      trans='log', breaks=c(1, 10,100,1000), labels=c(1,10,100,1000),
                      limits=c(1,1000))+
  scale_color_manual(values=c('black','black','black','black'))+
  theme(text=element_text(size=8), #change font size of all text
        plot.title=element_text(size=8), #change font size of plot title
        legend.text=element_text(size=8), #change font size of legend text
        legend.title=element_text(size=8))

ggsave('fig_venn/fig_venn.tiff', width=132, height=85, units='mm', dpi=300)
ggsave('fig_venn/fig_venn.png', width=132, height=85, units='mm', dpi=300, bg='white')
  




# Stats ----
data <- process_data(venn)
stat_categories <- lengths(x)  # number of sites per category
stat_total <- c(x$A, x$B, x$C, x$D) %>% unique() %>% length() # number of sites in total category
stat_single <- data@region %>% filter(id %in% c(1,2,3,4)) %>% pull(count) %>% sum()   # number of loclaities with 1 category
stat_double <- data@region %>% filter(id %in% c(12,13,14,23,24,34)) %>% pull(count) %>% sum()   # number of loclaities with 2 categories
stat_triple <- data@region %>% filter(id %in% c(123,124,134,234)) %>% pull(count) %>% sum()   # number of loclaities with 3 categories
stat_quadruple <- data@region %>% filter(id %in% c(1234)) %>% pull(count) %>% sum()   # number of loclaities with 4 categories


# Old stuff ----
venn <- Venn(x)
data <- process_data(venn)
ggplot() +
  # 1. region count layer
  geom_sf(aes(fill = count), data = venn_region(data)) +
  # 2. set edge layer
  #geom_sf(aes(color = id), data = venn_setedge(data), show.legend = FALSE) +
  geom_sf(color="black", size = .2, data = venn_setedge(data), show.legend = FALSE) +  
  # 3. set label layer
  #geom_sf_text(aes(label = name), data = venn_setlabel(data)) +
  geom_sf_text(label = c('Cultural remains', 'Human remains', 'Plant remains', 'Faunal remains'), data = venn_setlabel(data), size=3) +
  # 4. region label layer
  geom_sf_label(aes(label = count), data = venn_region(data), size=2) +
  scale_x_continuous(expand = expansion(mult = .2))+
  scale_y_continuous(expand = expansion(mult = .2))+
  scale_fill_gradient(name='Number of\nLocalities',
                      low="#deebf7", high = "#3182bd",
                      trans='log', breaks=c(1, 10,100,1000), labels=c(1,10,100,1000),
                      limits=c(1,1000))+
  theme_void()+
  theme(text=element_text(size=8), #change font size of all text
        plot.title=element_text(size=8), #change font size of plot title
        legend.text=element_text(size=8), #change font size of legend text
        legend.title=element_text(size=8))

ggsave('fig_venn/fig_venn_v2.tiff', width=120, height=80, units='mm', dpi=600)
ggsave('fig_venn/fig_venn_v2.png', width=120, height=80, units='mm', dpi=300, bg='white')

# Resources
# https://gaospecial.github.io/ggVennDiagram/articles/fully-customed