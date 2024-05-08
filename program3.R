library(rvest)
url="https://books.toscrape.com/catalogue/category/books/travel_2/index.html"
html_content=read_html(url)
title_xpath='/html/body/div/div/div/div/section/div[2]/ol/li/article/h3/a'

price_xpath='/html/body/div/div/div/div/section/div[2]/ol/li/article/div[2]/p[1]'

titles=html_content%>%
  html_nodes(xpath=title_xpath)%>%
  html_text()%>%
  trimws()
prices=html_content%>%
  html_nodes(xpath=price_xpath)%>%
  html_text()%>%
  trimws()
bookdata=data.frame(Title=titles,Prices=prices)
print(bookdata)
write.csv(bookdata,"bookData.csv",row.names = FALSE)