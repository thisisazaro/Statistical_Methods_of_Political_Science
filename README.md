# **Statistical Methods of Political Science**

This repository contains materials and code for the **Statistical Methods of Political Science** course. The course focuses on applying statistical and computational techniques to analyze political data, covering topics such as data collection, visualization, modeling, and machine learning.

## **Lesson 1: Web Scraping**
The first lesson introduces **web scraping**, a method for collecting data from websites. We use `R` and the libraries `rvest` and `polite` to extract structured information from web pages. The lesson covers:
- Basics of HTML structure and CSS selectors.
- Fetching data using polite requests to avoid blocking.
- Extracting news articles from government websites.
- Handling and storing scraped data in structured formats (CSV, DataFrame).

### **Files in this repository**
- `web_scraping.R` – R script for extracting press releases.
- `scraped_news.csv` – Sample dataset of collected articles.
- `README.md` – Overview of the course and lesson materials.

Stay tuned for future lessons on data analysis, regression models, and machine learning in political science! 🚀

## **Lesson 2: Text Analysis of Presidential Speeches**

In this lesson, we explore quantitative text analysis using a corpus of U.S. presidential inaugural addresses. 
The goal is to apply methods from computational social science to extract insights from political speeches.
We use the `quanteda` package in R to preprocess, analyze, and visualize textual data. 

### **The lesson covers:**
- Corpus creation and inspection using `data_corpus_inaugural`.
- Text preprocessing: tokenization, lowercasing, stopword removal, punctuation and number stripping.
- Construction of a Document-Feature Matrix (DFM) to represent speech content numerically.
- Frequency and diversity analysis: calculating type-token ratios across presidents.

### **Visualization techniques, including:**
- Word clouds for overall speech content.
- Comparative word clouds grouped by presidents (e.g., Washington, Adams, Jefferson).
- Time series plots showing lexical richness over time.

(Optional) Grouped analysis by political party to assess differences in rhetoric.

This lesson demonstrates how text-as-data approaches can be used in political science to study rhetorical strategies, topic prevalence, and language evolution in political communication.