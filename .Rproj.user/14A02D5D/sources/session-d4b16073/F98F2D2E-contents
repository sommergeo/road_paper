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
venn <- Venn(x)
data <- process_data(venn)
stat_categories <- lengths(x)  # number of sites per category

x$A %>% length() # archaeological sites
x$B %>% length() # human sites
x$C %>% length() # plant sites
x$D %>% length() # faunal sites

stat_total <- c(x$A, x$B, x$C, x$D) %>% unique() %>% length() # number of sites in total category
stat_single <- data@region %>% filter(id %in% c(1,2,3,4)) %>% pull(count) %>% sum()   # number of loclaities with 1 category
stat_double <- data@region %>% filter(id %in% c(12,13,14,23,24,34)) %>% pull(count) %>% sum()   # number of loclaities with 2 categories
stat_triple <- data@region %>% filter(id %in% c(123,124,134,234)) %>% pull(count) %>% sum()   # number of loclaities with 3 categories
stat_quadruple <- data@region %>% filter(id %in% c(1234)) %>% pull(count) %>% sum()   # number of loclaities with 4 categories
stat_double+stat_triple+stat_quadruple  # More than 1 discipline
(stat_double+stat_triple+stat_quadruple)/stat_total # More than 1 discipline


# Resources
# https://gaospecial.github.io/ggVennDiagram/articles/fully-customed