library(dplyr)
library(tidyr)
data1=read.csv("C:/Users/shree/Documents/R final programming/sales.csv")
data2=read.csv("C:/Users/shree/Documents/R final programming/salary.csv")
merged_data=merge(data1,data2,by="ID")
print(merged_data)
aggregate_data=merged_data%>%
  group_by(Gender)%>%
summarise(total_salary=sum(Salary),avg_age=mean(Age),count=n())
print(aggregate_data)
#filter data
filterdata=merged_data%>%
  filter(Age>25)
print(filterdata)
transformed_data=merged_data%>%
  mutate(doubled_salary=Salary*2,seniority=ifelse(Age>28,"Senior","Junior"))
print(transformed_data)