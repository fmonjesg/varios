## Librerias ##
library(tidyverse)
library(rtweet)
library(ggwordcloud)
library(tm)
library(wordcloud)
library(wordcloud2)
library(wesanderson)
library(SnowballC)
library(RColorBrewer)
library(openxlsx)

## Query ##
query20220717 <- search_tweets(q = "Educación OR MINEDUC OR SLEP OR Educación Pública OR 
                               Escuela OR Colegio OR Liceo", lang = "es",
                              include_rts = FALSE,  n = 1000) #Valparaiso y SLEP#

## Ajuste Datos ##

words <- as.character(query20220717$text)
words.corpus <- Corpus(VectorSource(words))

words.corpus <- words.corpus %>% 
  tm_map(removePunctuation) %>%
  tm_map(removeNumbers) %>% 
  tm_map(stripWhitespace) %>% 
  tm_map(tolower) %>% 
  tm_map(removeWords, stopwords("spanish"))


words.corpus <- tm_map(words.corpus, stemDocument)

word.count <- as.matrix(TermDocumentMatrix(words.corpus))

word.freq <- sort(rowSums(word.count), decreasing = TRUE)

head(word.freq)

wordcloud(words = names(word.freq), freq = word.freq, scale = c(3.5,0.25), max.words = 50,
          random.order = TRUE, colors = brewer.pal(8, "Dark2"))


