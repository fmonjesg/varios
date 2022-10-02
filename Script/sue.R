library(tidyverse)
library(readxl)
library(gridExtra)

EERR_2021 <- read_excel("EERR_2021.xlsx")


EERR_2021 %>% 
  group_by(DESC_TIPO_CUENTA) %>% 
  summarise(length(DESC_TIPO_CUENTA))

EERR_2021 <-  EERR_2021 %>% 
  filter(DESC_TIPO_CUENTA == "INGRESO" | DESC_TIPO_CUENTA== "GASTO")

EERR_2021 %>% 
  filter(RBD == 15657) %>% 
  group_by(DESC_TIPO_CUENTA, SUBVENCION_ALIAS) %>% 
  summarise(sum(MONTO_DECLARADO)) %>% 
  ggplot(aes(x = DESC_TIPO_CUENTA, y = `sum(MONTO_DECLARADO)`, fill = DESC_TIPO_CUENTA)) + 
  geom_bar()

sue <- EERR_2021 %>% 
  filter(RBD == 15657) %>% 
  group_by(DESC_TIPO_CUENTA, SUBVENCION_ALIAS) %>% 
  summarise(sum(MONTO_DECLARADO))

general <- sue  %>% 
  filter(SUBVENCION_ALIAS == "GENERAL") %>% 
  ggplot(aes(x = DESC_TIPO_CUENTA, y = `sum(MONTO_DECLARADO)`/1000, fill = DESC_TIPO_CUENTA)) + 
  geom_bar(stat = "identity") +
  labs(y = "Monto Declarado en M$", title = "Subvención General", x = "") +
  theme(legend.position = "none") + 
  geom_text(aes(label = `sum(MONTO_DECLARADO)`/1000))

mantenimiento <- sue  %>% 
  filter(SUBVENCION_ALIAS == "MANTENIMIENTO") %>% 
  ggplot(aes(x = DESC_TIPO_CUENTA, y = `sum(MONTO_DECLARADO)`/1000, fill = DESC_TIPO_CUENTA)) + 
  geom_bar(stat = "identity") +
  labs(y = "", title = "Mantenimiento", x = "") +
  theme(legend.position = "none") + 
  geom_text(aes(label = `sum(MONTO_DECLARADO)`/1000))

proretencion <- sue  %>% 
  filter(SUBVENCION_ALIAS == "PRORETENCION") %>% 
  ggplot(aes(x = DESC_TIPO_CUENTA, y = `sum(MONTO_DECLARADO)`/1000, fill = DESC_TIPO_CUENTA)) + 
  geom_bar(stat = "identity") +
  labs(y = "", title = "Proretención", x = "") +
  theme(legend.position = "none") + 
  geom_text(aes(label = `sum(MONTO_DECLARADO)`/1000))

grid.arrange(general, mantenimiento, proretencion, ncol = 3)
