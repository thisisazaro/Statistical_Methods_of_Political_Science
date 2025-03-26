
# анализ инаугурационных речей президентов США (data_corpus_inaugural) с помощью quanteda. 

# Загрузка библиотек
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(ggplot2)
library(dplyr)

# Просмотр данных (встроенный корпус)
View(as.data.frame(data_corpus_inaugural))

# Статистика по корпусу
stats <- summary(data_corpus_inaugural)
stats

# Визуализация соотношения уникальных слов к общему количеству слов
ggplot(stats) +
        geom_line(aes(x = Text, y = Types / Tokens, group = 1)) +
        geom_smooth(aes(x = Text, y = Types / Tokens, group = 1), se = FALSE) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
        ggtitle("Разнообразие слов в инаугурационных речах") +
        xlab("Текст") +
        ylab("Types / Tokens")

# График длины речи по годам
ggplot(stats, aes(x = Year, y = Tokens)) +
        geom_line() + geom_point() +
        ggtitle("Длина инаугурационных речей по годам")

# Токенизация и очистка
tok <- tokens(data_corpus_inaugural,
              remove_punct = TRUE,
              remove_numbers = TRUE)

# Удаление стоп-слов
tok <- tokens_remove(tok, stopwords("english"))

# Приведение к нижнему регистру
tok <- tokens_tolower(tok)

# Построение матрицы признаков
temmat <- dfm(tok)
temmat

# Облако слов по корпусу
textplot_wordcloud(temmat, 
                   min_size = 1, 
                   max_size = 5, 
                   max_words = 100,
                   color = c("red", "pink", "orange"))


topfeatures(temmat, 20)  # Топ-20 самых частых слов


# Сравнение по президентам: Washington, Adams, Jefferson
corpus_subset_presidents <- corpus_subset(data_corpus_inaugural, 
                                          President %in% c("Washington", "Adams", "Jefferson"))
# Повторная очистка и DFM по подкорпусу
tok_pres <- tokens(corpus_subset_presidents,
                   remove_punct = TRUE,
                   remove_numbers = TRUE) %>%
        tokens_remove(stopwords("english")) %>%
        tokens_tolower()
dfm_pres <- dfm(tok_pres)
dfm_president <- dfm_group(dfm_pres, groups = docvars(dfm_pres, "President"))
dfm_president

docvars(dfm_pres)


# Облако слов с сравнением президентов
textplot_wordcloud(dfm_president, comparison = TRUE)
