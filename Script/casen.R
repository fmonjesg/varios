library(tidyverse)
library(survey)
library(srvyr)
library(haven)
library(flextable)

casen <- read_dta("Desktop/Casen 2017.dta")



casen %>% 
  filter(comuna == 13113) %>% 
  frq(sexo, weights = expc)

casen %>% 
  filter(comuna == 13113) %>% 
  descr(sexo, weights = expc)


casen %>% 
  filter(comuna == 13113) %>% 
  flat_table(region, sexo, weights = expc)

casen %>% 
  filter(comuna == 13113, dau == 10)  %>% 
  descr(ytot, weights = expc)
  
casen %>% 
  filter(comuna == 13113)  %>% 
  descr(s12, weights = expc)

casen %>% 
  filter(comuna == 13113) %>% 
  flat_table(s12, sexo, weights = expc)
