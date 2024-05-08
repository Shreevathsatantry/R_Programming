library(rvest)
library(httr)

url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_and_their_capitals_in_native_languages"
response <- tryCatch(GET(url), error = function(e) e)

if (!inherits(response, "error")) {
  print("Successfully connected to the website\n")
  html_content <- read_html(response$content, encoding = "UTF-8")
  
  countries <- html_content %>%
    html_nodes(xpath = '//*[@id="mw-content-text"]/div[1]/table[2]//tr/td[1]//a') %>%
    html_text(trim = TRUE)
  
  capitals <- html_content %>%
    html_nodes(xpath = '//*[@id="mw-content-text"]/div[1]/table[2]//tr/td[2]//a') %>%
    html_text(trim = TRUE)
  
  clean_countries <- gsub("\\[.*?\\]", "", countries)
  clean_countries <- gsub("Â", "", clean_countries)
  clean_countries <- gsub("&nbsp;", "", clean_countries)
  
  clean_capitals <- gsub("\\[.*?\\]", "", capitals)
  clean_capitals <- gsub("Â", "", clean_capitals)
  clean_capitals <- gsub("&nbsp;", "", clean_capitals)
  
  # Ensure both vectors have the same length
  min_length <- min(length(clean_countries), length(clean_capitals))
} else {
  print("Failed to connect to the website")
}

# Trim vectors to the same length
clean_countries <- clean_countries[1:min_length]
clean_capitals <- clean_capitals[1:min_length]

result <- data.frame(Country = clean_countries, Capitals = clean_capitals)
print(result)
