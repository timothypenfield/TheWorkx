---
  title: "[Analysis Project Name]"
author: "Tim Enfield"
date: "6/12/22"
output: html_document
---
  


install.packages("MVA")
library(MVA)
install.packages("dplyr")
library(dplyr)
install.packages("scatterplot3d")
library(scatterplot3d)
library(readxl)
install.packages("tidyverse")
install.packages("pollster")
library(pollster)
install.packages("knitr")
library(knitr)
install.packages("ggplot")
install.packages("funModeling")
library(funModeling)
install.packages("skimr")
library(skimr)
install.packages("janitor")
library(janitor)
install.packages("corrr")
library(corrr)
install.packages("corrplot")
library(corrplot)
install.packages("tables")
library(tables)
install.packages("tigerstats")
library(tigerstats)

cb <- function(df, sep="\t", dec=",", max.size=(200*1000)){
  # Copy a data.frame to clipboard
  write.table(df, paste0("clipboard-", formatC(max.size, format="f", digits=0)), sep=sep, row.names=TRUE, dec=dec)
}

glimpse(FSSCFilter)

#At your company, are you responsible for the design and implementation of the food safety management system, at corporate or operations level?



xt6<- (xtabs(~ Decisions+ country, data= FSSCFilterFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt1a)

xt2<- (xtabs(~ Decisions+ country, data= FSSCFilterFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Decisions+ country, data= FSSCFilterFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ Decisions+ StoreCert3, data= FSSCFilterFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt1<- (xtabs(~ Decisions+ country, data= FSSCFilterFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt5<- (xtabs(~ Decisions+ country, data= FSSCFilterFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)


x2<- cbind(xt6a,xt2a,xt3a,xt4a,xt1a, xt5a)
cb(x2)


#What is the number of production sites/ retail shops / restaurants of your organization

xt1<- (xtabs(~ SiteCount+ country, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)


xt2<- (xtabs(~ SiteCount+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ SiteCount+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ SiteCount+ StoreCert3, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ SiteCount+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

#Which geographic markets are you targeting, both domestic and international?

xt1<- (xtabs(~ Places1+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ Places2+ Region, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Places3+ Region, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ Places4+ Region, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ Places5+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Places6+ Region, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)

xt7<- (xtabs(~ Places7+ Region, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)

xt8<- (xtabs(~ Places8+ Region, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)

xt9<- (xtabs(~ Places9+ Region, data= FSSCFilter))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt5a)

xt10<- (xtabs(~ Places10+ Region, data= FSSCFilter))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt5a)

xt11<- (xtabs(~ Places11+ Region, data= FSSCFilter))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt5a)

xt12<- (xtabs(~ Places12+ Region, data= FSSCFilter))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a,xt8a,xt9a,xt10a,xt11a,xt12a)
cb(x2)




#To what extent are you familiar with these food safety standards/schemes? 

xt1<- (xtabs(~ Familiar1 + Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ Familiar2 + Region, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Familiar3 + Region, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ Familiar4 + Region, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ Familiar5 + Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Familiar6 + Region, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt5a)

xt7<- (xtabs(~ Familiar7 + Region, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

xt8<- (xtabs(~ Familiar8 + Region, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt5a)

xt9<- (xtabs(~ Familiar9 + Region, data= FSSCFilter))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt5a)

xt10<- (xtabs(~ Familiar10 + Region, data= FSSCFilter))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a,xt8a,xt9a,xt10a)
cb(x2)



#Are the sites/stores within your organization certified to a third-party food safety scheme/standard?


xt1<- (xtabs(~ StoresCert+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ StoresCert+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ StoresCert+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ StoresCert+ StoreCert3, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ StoresCert+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- cbind(xt1a,xt2a,xt3a,xt4a,xt5a)
cb(x2)

#Which ones the sites/stores within your organization certified to a third-party food safety scheme/standard?


xt1<- (xtabs(~ StoreCert1+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ StoreCert2+ Region, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ StoreCert3+ Region, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ StoreCert4+ Region, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ StoreCert5+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ StoreCert6+ Region, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt5a)

xt7<- (xtabs(~ StoreCert7+ Region, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

xt8<- (xtabs(~ StoreCert8+ Region, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt5a)

xt9<- (xtabs(~ StoreCert9+ Region, data= FSSCFilter))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt5a)

xt10<- (xtabs(~ StoreCert10+ Region, data= FSSCFilter))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt10)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a,xt8a,xt9a,xt10a)
cb(x2)


#Which is your preferred food safety scheme/standard?

xt1<- (xtabs(~ Prefer+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ Prefer+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Prefer+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ Prefer+ StoreCert3, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ Prefer+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- cbind(xt1a,xt2a,xt3a,xt4a,xt5a)
cb(x2)

#Are your country certified to a third-party food safety scheme safety scheme/standard?

  xt1<- (xtabs(~ SupplierCert+ Region, data= FSSCFilter))
  xt1a<-round(prop.table(as.matrix(xt1),2),2)
  cb(xt1a)

xt2<- (xtabs(~ SupplierCert+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ SupplierCert+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ SupplierCert+ StoreCert3, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ SupplierCert+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- cbind(xt1,xt2,xt3,xt4,xt5)
cb(x2)


#Do you require specific scheme(s)/standard(s) from your country?

xt1<- (xtabs(~ SupplierRequired+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ SupplierRequired+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ SupplierRequired+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ SupplierRequired+ StoreCert3, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ SupplierRequired+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- cbind(xt1,xt2,xt3,xt4,xt5)
cb(x2)



#Which of the following scheme(s)/standard(s) do you require of your country?

xt1<- (xtabs(~ SupplierCert1+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ SupplierCert2+ Region, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ SupplierCert3+ Region, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ SupplierCert4+ Region, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ SupplierCert5+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ SupplierCert6+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt7<- (xtabs(~ SupplierCert7+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt8<- (xtabs(~ SupplierCert8+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt9<- (xtabs(~ SupplierCert9+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt10<- (xtabs(~ SupplierCert10+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)


x2<- rbind(xt1,xt2,xt3,xt4,xt5,xt6,xt7,xt8,xt9,xt10)
cb(x2)




#On a scale from 1-5 (1 - very poor, 3 = neutral, 5 = excellent), how would you describe your overall attitude towards the following food safety scheme(s)/standard(s)?  [T2B]


xt1<- (xtabs(~ CertAttitude1+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ CertAttitude2+ Region, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ CertAttitude3+ Region, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ CertAttitude4+ Region, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ CertAttitude5+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a)
cb(x2)



#Do you usually develop criteria before settling for a food safety standard/scheme?

xt1<- (xtabs(~ CertCriteria+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ CertCriteria+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ CertCriteria+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ CertCriteria+ StoreCert3, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ CertCriteria+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- cbind(xt1,xt2,xt3,xt4,xt5)
cb(x2)



#Which information sources do you use to choose your certification scheme(s)/ standard(s) for certifying your food safety management system? [T2B]

xt1<- (xtabs(~ Info1+ Region, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ Info2+ Region, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Info3+ Region, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ Info4+ Region, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ Info5+ Region, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Info6+ Region, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6a)

xt7<- (xtabs(~ Info7+ Region, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

xt8<- (xtabs(~ Info8+ Region, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt5a)

x2<- rbind(xt1,xt2,xt3,xt4,xt5,xt6,xt7,xt8)
cb(x2)




#On a scale from 1-5 (1 - very poor, 3 = neutral, 5 = excellent), how would you say characteristics fit with the Foundation FSSCFilter, which is the owner of FSSCFilter 22000? [T2B]


xt1<- (xtabs(~ CharactFit1+ country, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ CharactFit2+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ CharactFit3+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ CharactFit4+ country, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ CharactFit5+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ CharactFit6+ country, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt5a)

xt7<- (xtabs(~ CharactFit7+ country, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a)
cb(x2)

#OOn a scale from 1-5 (1 - very poor, 3 = neutral, 5 = excellent), How would you say values fit with the FSSCFilter foundation? [T2B]

xt1<- (xtabs(~ ValueFit1+ country, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ ValueFit2+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ ValueFit3+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ ValueFit4+ country, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ ValueFit5+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a)
cb(x2)


#On a scale from 1-5 (1 - strongly disagree, 3 = neutral, 5 = strongly agree), How would you say you agree or disagree with the following statements? [T2B]

xt1<- (xtabs(~ Agree1+ country, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ Agree2+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Agree3+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ Agree4+ country, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ Agree5+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Agree6+ country, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt5a)

xt7<- (xtabs(~ Agree7+ country, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

xt8<- (xtabs(~ Agree8+ country, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt5a)

xt9<- (xtabs(~ Agree9+ country, data= FSSCFilter))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a,xt8a,xt9a)
cb(x2)



#On a scale from 1-5 (1 - very poor, 3 = neutral, 5 = excellent), How would you say characteristics fit with the FSSCFilter foundation? [T2B]

xt1<- (xtabs(~ FSSCFilter1+ country, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ FSSCFilter2+ country, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ FSSCFilter3+ country, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ FSSCFilter4+ country, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ FSSCFilter5+ country, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ FSSCFilter6+ country, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt5a)

xt7<- (xtabs(~ FSSCFilter7+ country, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

xt8<- (xtabs(~ FSSCFilter8+ country, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt5a)

xt9<- (xtabs(~ FSSCFilter9+ country, data= FSSCFilter))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt5a)

xt10<- (xtabs(~ FSSCFilter10+ country, data= FSSCFilter))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt5a)

xt11<- (xtabs(~ FSSCFilter11+ country, data= FSSCFilter))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt5a)

xt12<- (xtabs(~ FSSCFilter12+ country, data= FSSCFilter))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt5a)

xt13<- (xtabs(~ FSSCFilter13+ country, data= FSSCFilter))
xt13a<-round(prop.table(as.matrix(xt13),2),2)
cb(xt5a)

xt14<- (xtabs(~ FSSCFilter14+ country, data= FSSCFilter))
xt14a<-round(prop.table(as.matrix(xt14),2),2)
cb(xt5a)

xt15<- (xtabs(~ FSSCFilter15+ country, data= FSSCFilter))
xt15a<-round(prop.table(as.matrix(xt15),2),2)
cb(xt5a)

xt16<- (xtabs(~ FSSCFilter16+ country, data= FSSCFilter))
xt16a<-round(prop.table(as.matrix(xt16),2),2)
cb(xt5a)

xt17<- (xtabs(~ FSSCFilter17+ country, data= FSSCFilter))
xt17a<-round(prop.table(as.matrix(xt17),2),2)
cb(xt5a)

xt18<- (xtabs(~ FSSCFilter18+ country, data= FSSCFilter))
xt18a<-round(prop.table(as.matrix(xt18),2),2)
cb(xt5a)

xt19<- (xtabs(~ FSSCFilter19+ country, data= FSSCFilter))
xt19a<-round(prop.table(as.matrix(xt19),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a,xt8a,xt9a,xt10a,xt11a,xt12a,xt13a,xt14a,xt15a,xt16a,xt17a,xt18a,xt19a)
cb(x2)




#On a scale from 1-5 (1 - Not important at all, 3 = neutral, 5 = Very Important), indicate how important characteristics are for you when choosing a food safety certification scheme or standard? [T2B]


xt1<- (xtabs(~ Important1+ Exp, data= FSSCFilter))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1a)

xt2<- (xtabs(~ Important2+ Exp, data= FSSCFilter))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2a)

xt3<- (xtabs(~ Important3+ Exp, data= FSSCFilter))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3a)

xt4<- (xtabs(~ Important4+ Exp, data= FSSCFilter))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt5<- (xtabs(~ Important5+ Exp, data= FSSCFilter))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Important6+ Exp, data= FSSCFilter))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt5a)

xt7<- (xtabs(~ Important7+ Exp, data= FSSCFilter))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt5a)

xt8<- (xtabs(~ Important8+ Exp, data= FSSCFilter))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt5a)

xt9<- (xtabs(~ Important9+ Exp, data= FSSCFilter))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt5a)

xt10<- (xtabs(~ Important10+ Exp, data= FSSCFilter))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt5a)

xt11<- (xtabs(~ Important11+ Exp, data= FSSCFilter))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt5a)

xt12<- (xtabs(~ Important12+ Exp, data= FSSCFilter))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt5a)

xt13<- (xtabs(~ Important13+ Exp, data= FSSCFilter))
xt13a<-round(prop.table(as.matrix(xt13),2),2)
cb(xt5a)

xt14<- (xtabs(~ Important14+ Exp, data= FSSCFilter))
xt14a<-round(prop.table(as.matrix(xt14),2),2)
cb(xt5a)

xt15<- (xtabs(~ Important15+ Exp, data= FSSCFilter))
xt15a<-round(prop.table(as.matrix(xt15),2),2)
cb(xt5a)

xt16<- (xtabs(~ Important16+ Exp, data= FSSCFilter))
xt16a<-round(prop.table(as.matrix(xt16),2),2)
cb(xt5a)

xt17<- (xtabs(~ Important17+ Exp, data= FSSCFilter))
xt17a<-round(prop.table(as.matrix(xt17),2),2)
cb(xt5a)

xt18<- (xtabs(~ Important18+ Exp, data= FSSCFilter))
xt18a<-round(prop.table(as.matrix(xt18),2),2)
cb(xt5a)

xt19<- (xtabs(~ Important19+ Exp, data= FSSCFilter))
xt19a<-round(prop.table(as.matrix(xt19),2),2)
cb(xt5a)

x2<- rbind(xt1a,xt2a,xt3a,xt4a,xt5a,xt6a,xt7a,xt8a,xt9a,xt10a,xt11a,xt12a,xt13a,xt14a,xt15a,xt16a,xt17a,xt18a,xt19a)
cb(x2)



#
