
# Web Scraping

# Этот код на R предназначен для веб-скрейпинга пресс-релизов с сайта state.gov,
# используя библиотеки `polite`, `rvest` и `dplyr`.

library(polite)
library(rvest)
library(dplyr)

# Эти библиотеки используются для вежливого и безопасного сбора данных с веб-страниц.

url <- "https://www.state.gov/press-releases/page/"
enoti_windows <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"
# Здесь задаётся базовый URL и user-agent браузера для имитации обычного запроса.

enoti_mac <- "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"

links <- c()
titles <- c()
newstexts <- c()

# Эти переменные будут хранить ссылки на статьи, заголовки и тексты новостей.

for (i in 1:5) {
        print(i)
        url_new <- paste(url, i, sep = "")
        Sys.sleep(8)
        # Это основной цикл, который обходит первые 5 страниц пресс-релизов.
        
        page <- bow(url_new,
                    delay = 20,
                    times = 8,
                    user_agent = enoti_mac,
                    force = TRUE) %>%
                # bow() из polite помогает сделать "вежливый" запрос, не нагружая сервер.
                scrape()
        print("Госдеп пустил меня парсить")
        Sys.sleep(20)
        l <- page %>% html_elements(".collection-result a") %>% html_attr("href")
        links <- c(links, l)
        t <- page %>% html_elements(".collection-result p") %>% html_text()
        titles <- c(titles, t)
        # Здесь с помощью rvest парсятся ссылки и заголовки статей.
        for (scraper in 1:10) {
                pagenews <- bow(l[scraper],
                                delay = 20,
                                times = 8,
                                user_agent = enoti_mac,
                                force = TRUE) %>%
                        # Этот цикл переходит по каждой ссылке и загружает страницу.
                        scrape()
                newstext <- pagenews %>% 
                        html_elements(".wp-block-paragraph p") %>% 
                        html_text() %>% 
                        paste(collapse = " ")
        }
        newstexts <- c(newstexts, newstext)
        # Здесь html_elements() используется для поиска основного текста статьи.
}
                
# Проверить ссылки на новости
print(links)
# Вывести первые 5 ссылок
head(links, 5)

# Проверить заголовки новостей
print(titles)
# Вывести первые 5 заголовков
head(titles, 5)

# Проверить текст новостей
print(newstexts)
# Вывести первые 2 текста новостей
head(newstexts, 2)



# Сохранение данных в CSV
df <- data.frame(links, titles, newstexts, stringsAsFactors = FALSE)
write.csv(df, "data/scraped_news.csv", row.names = FALSE)
# Проверить содержимое файла
print(read.csv("scraped_news.csv"))











# Пример: нужно обойти радномные 20 страниц с пресс-релизами. 
# Собрать ссылки, заголовки и тексты новостей.
# и сохранить данные в CSV.

library(polite)
library(rvest)
library(dplyr)

# Базовый URL для пресс-релизов
base_url <- "https://www.state.gov"
press_url <- paste0(base_url, "/press-releases/page/")

# User-Agent (имитация обычного браузера)
user_agent <- "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"

# Списки для хранения данных
links <- c()
titles <- c()
newstexts <- c()

# Обход 20 страниц
for (i in sample(1:30, 20)) {  # Берём случайные 20 страниц из первых 30
        print(paste("Обрабатываю страницу:", i))
        url_new <- paste0(press_url, i)
        
        Sys.sleep(runif(1, 5, 10))  # Рандомная задержка между запросами
        
        page <- bow(url_new,
                    delay = 15,
                    times = 5,
                    user_agent = user_agent,
                    force = TRUE) %>%
                scrape()
        
        print("Госдеп пустил меня парсить!")
        Sys.sleep(runif(1, 10, 15))  # Ещё одна задержка
        
        # Извлекаем ссылки
        l <- page %>% html_elements(".collection-result a") %>% html_attr("href")
        l <- ifelse(grepl("^https", l), l, paste0(base_url, l))  # Добавляем базовый URL, если ссылка относительная
        
        # Извлекаем заголовки
        t <- page %>% html_elements(".collection-result h2") %>% html_text()
        
        links <- c(links, l)
        titles <- c(titles, t)
        
        # Парсим текст каждой новости
        for (news_url in l) {
                Sys.sleep(runif(1, 5, 10))
                
                pagenews <- bow(news_url,
                                delay = 15,
                                times = 5,
                                user_agent = user_agent,
                                force = TRUE) %>%
                        scrape()
                
                newstext <- pagenews %>% 
                        html_elements(".wp-block-paragraph p") %>% 
                        html_text() %>% 
                        paste(collapse = " ")
                
                newstexts <- c(newstexts, newstext)
        }
}

# Создание DataFrame
df <- data.frame(links, titles, newstexts, stringsAsFactors = FALSE)

# Сохранение в CSV
dir.create("data", showWarnings = FALSE)
write.csv(df, "data/scraped_news.csv", row.names = FALSE)

# Вывод первых 5 строк
print(head(df, 5))

# Проверка сохранённого файла
print(read.csv("data/scraped_news.csv"))




