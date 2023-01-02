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

glimpse(banana_short)


XT87<- rbind(xt81a,xt82a,xt83a,xt84a,xt85a,xt86a)
cb(XT87)

#Who is the primary decision maker of grocery purchases in your household?
xt1<- (xtabs(~ ShoppingHabit+ Store9, data= banana_short))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)
cb(xt1a)

xt2<- (xtabs(~ ShoppingHabit+ Buckets, data= banana_short))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)
cb(xt2a)

xt3<- (xtabs(~ ShoppingHabit+ HH_Fixed, data= banana_short))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)
cb(xt3a)

xt4<- (xtabs(~ ShoppingHabit+ Income, data= banana_short))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

#Which of the following do you purchase regularly? Please select all that apply.?

  xt21<- (xtabs(~ Mandarins+ Store9, data= banana_short))
  xt21a<-round(prop.table(as.matrix(xt21),2),2)
  cb(xt21a)

b<-cbind(xt24a,xt21a,xt22a,xt23a)
cb(b)

Avocados
Limes
Lemons
Apples
Oranges
Cucumbers
Pineapples
Mangoes
Pears
Bell Peppers (red. yellow. orange)
Tomatoes
Mandarins



#How frequently do you shop for grocceries?

xt20<- (xtabs(~ GroceryShopFrequency+ Store9, data= banana_short))
xt20a<-round(prop.table(as.matrix(xt20),2),2)
cb(xt20)
cb(xt20a)

xt21<- (xtabs(~ GroceryShopFrequency+ Buckets, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ GroceryShopFrequency+ HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ GroceryShopFrequency+ Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)



#How frequently do you buy bananas?

xt24<- (xtabs(~ EatPreferences+ Store9, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ BananaPurchaseFrequency+ Store4, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ BananaPurchaseFrequency+ Store4, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ BananaPurchaseFrequency+ Store4, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

#Which of the following certifications do you look for when you buy bananas? Please select all that apply.

xt5<- (xtabs(~ Cert1+ Store9, data= banana_short))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Cert2+ Store9, data= banana_short))
xt6a<-round(prop.table(as.matrix(xt6),2),2)

xt8<- (xtabs(~ Cert3+ Store9, data= banana_short))
xt8a<-round(prop.table(as.matrix(xt8),2),2)

XT9<- (xtabs(~ Cert4+ Store9, data= banana_short))
xt9a<-round(prop.table(as.matrix(XT9),2),2)

XT10<- (xtabs(~ Cert5+ Store9, data= banana_short))
xt10a<-round(prop.table(as.matrix(XT10),2),2)

XT11<- (xtabs(~ Cert6+ Store9, data= banana_short))
xt11a<-round(prop.table(as.matrix(XT11),2),2)

XT19<- rbind(xt5a,xt6a,xt8a,xt9a,xt10a,xt11a)
cb(XT19)

#What typically prevents you from purchasing more bananas in a single trip to the store? Please select all that apply..

xt5<- (xtabs(~ Prevent1+ Store9, data= banana_short))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ Prevent2+ Store9, data= banana_short))
xt6a<-round(prop.table(as.matrix(xt6),2),2)

xt8<- (xtabs(~ Prevent3+ Store9, data= banana_short))
xt8a<-round(prop.table(as.matrix(xt8),2),2)

XT9<- (xtabs(~ Prevent4+ Store9, data= banana_short))
xt9a<-round(prop.table(as.matrix(XT9),2),2)

XT10<- (xtabs(~ Prevent5+ Store9, data= banana_short))
xt10a<-round(prop.table(as.matrix(XT10),2),2)


XT19<- rbind(xt5a,xt6a,xt8a,xt9a,xt10a)
cb(XT19)


#How many bananas do you typically buy in a single trip to the store? If you purchase a bunch at a time, please estimate the number of individual bananas in the bunch.

xt24<- (xtabs(~ BananaPerTrip_Fixed+ Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ BananaPerTrip_Fixed+ Store4, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ BananaPerTrip_Fixed+ Store4, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ BananaPerTrip_Fixed+ Store4, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23)



#How often do you experience each of the following when purchasing bananas? 

xt5<- (xtabs(~ F_ArentRipeEnough+ Store9, data= banana_short))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ F_TooRipe+ Store9, data= banana_short))
xt6a<-round(prop.table(as.matrix(xt6),2),2)

xt8<- (xtabs(~ F_BrownSpots+ Store9, data= banana_short))
xt8a<-round(prop.table(as.matrix(xt8),2),2)

XT9<- (xtabs(~ F_BrownStreaks+ Store9, data= banana_short))
xt9a<-round(prop.table(as.matrix(XT9),2),2)

XT10<- (xtabs(~ F_ShortLife+ Store9, data= banana_short))
xt10a<-round(prop.table(as.matrix(XT10),2),2)

XT19<- rbind(xt5a,xt6a,xt8a,xt9a,xt10a)
cb(XT19)

F_TooRipe                                                                                                                                                                     <chr> ~
F_BrownSpots                                                                                                                                                                  <chr> ~
F_BrownStreaks                                                                                                                                                                <chr> ~
F_ShortLife                                                                                                                                                                   <chr> ~



#Which of the following factors do you believe are indicators of the level of ripeness of a banana?

  xt5<- (xtabs(~ I1+ Store9, data= banana_short))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5a)

xt6<- (xtabs(~ I2+ Store9, data= banana_short))
xt6a<-round(prop.table(as.matrix(xt6),2),2)

xt8<- (xtabs(~ I3+ Store9, data= banana_short))
xt8a<-round(prop.table(as.matrix(xt8),2),2)

XT9<- (xtabs(~ I4+ Store9, data= banana_short))
xt9a<-round(prop.table(as.matrix(XT9),2),2)

XT10<- (xtabs(~ I5+ Store9, data= banana_short))
xt10a<-round(prop.table(as.matrix(XT10),2),2)

XT11<- (xtabs(~ Iz6+ Store9, data= banana_short))
xt11a<-round(prop.table(as.matrix(XT11),2),2)

XT19<- rbind(xt5,xt6,xt8,XT9,XT10,XT11)
cb(XT19)
  
  
  I1                                                                                                                                                                            <chr> ~
  I2                                                                                                                                                                            <chr> ~
  I3                                                                                                                                                                            <chr> ~
  I4                                                                                                                                                                            <chr> ~
  I5                                                                                                                                                                            <chr> ~
  Iz6  
  
#Do you like to buy your bananas.

xt24<- (xtabs(~ HowBought+ Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ HowBought+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ HowBought + Store9, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ HowBought+ Store9, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

b<-cbind(xt24a,xt21a)
cb(b)

#What is the primary use for your bananas?

xt24<- (xtabs(~ PrimaryUsE + Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ PrimaryUsE+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ PrimaryUsE + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ PrimaryUsE+ Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

b<-cbind(xt24a,xt21a)
cb(b)

#What are other ways that you use bananas? [Secondary Use]

xt20<- (xtabs(~ Secondary1+ Store9, data= banana_short))
xt20a<-round(prop.table(as.matrix(xt20),2),2)


xt21<- (xtabs(~ Secondary2+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)

xt22<- (xtabs(~ Secondary3 + Store9, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)

xt23<- (xtabs(~ Secondary4+ Store9, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)

xt24<- (xtabs(~ Secondary5+ Store9, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)

xt25<- (xtabs(~ Secondary6+ Store9, data= banana_short))
xt25a<-round(prop.table(as.matrix(xt25),2),2)

xt26<- (xtabs(~ Secondary7+ Store9, data= banana_short))
xt26a<-round(prop.table(as.matrix(xt26),2),2)


b<-rbind(xt20a,xt21a,xt22a,xt23a,xt24a,xt25a,xt26a)
cb(b)


#Where do you typically store your bananas?


xt24<- (xtabs(~ Storage+ Store9, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ Storage+ Buckets, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ Storage + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ Storage+ Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

#When you eat a banana, do you prefer... [Peel]


xt24<- (xtabs(~ PeelPrefrence+ Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24)

xt21<- (xtabs(~ PeelPrefrence+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ PeelPrefrence + Store4, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ PeelPrefrence+ Store4, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

b<-cbind(xt24,xt21)
cb(b)

#When you eat a banana, do you prefer... [Sweetness]

xt24<- (xtabs(~ SweetPreference+ Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24)

xt21<- (xtabs(~ SweetPreference+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

b<-cbind(xt24,xt21)
cb(b)

#When you eat a banana, do you prefer... [Firrmness]

xt24<- (xtabs(~ FirmPreference+ Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24)

xt21<- (xtabs(~ FirmPreference+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ FirmPreferences + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ FirmPreferences + Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

b<-cbind(xt24a,xt21a)
cb(b)


#When you buy bananas, how many days go by before your household eats or throws away all the bananas you purchased?

xt24<- (xtabs(~ DaystoSpoilHome  + Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ DaystoSpoilHome  + Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ DaystoSpoilHome   + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ DaystoSpoilHome  + Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)


#If you think about your perfect banana eating experience, do you prefer to eat your bananas.

xt24<- (xtabs(~ PrimaryUsE + PurchaserType, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ PrimaryUsE+ Buckets, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ PrimaryUsE + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ PrimaryUsE+ Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

b<-cbind(xt24a,xt21a,xt22a,xt23a)
cb(b)

#When bananas are beyond their ideal stage for eating fresh, what do you typically do with them? Please select all that apply


xt20<- (xtabs(~ BeyondUse1+ Store9, data= banana_short))
xt20a<-round(prop.table(as.matrix(xt20),2),2)
cb(xt24)

xt21<- (xtabs(~ BeyondUse2+ Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)

xt22<- (xtabs(~ BeyondUse3 + Store9, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)

xt23<- (xtabs(~ BeyondUse4+ Store9, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)

xt24<- (xtabs(~ BeyondUse5+ Store9, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)

b<-rbind(xt20a,xt21a,xt22a,xt23a,xt24a)
cb(b)



#Do you ever end up having to throw out bananas that go bad before you have a chance to eat them?

xt24<- (xtabs(~ ThrowOut  + Store4, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ ThrowOut  + Store9, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ ThrowOut   + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ ThrowOut  + Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

a<-cbind(xt24a,xt21a,xt22a,xt23a)
cb(a)

#Approximately what percentage of the bananas that you purchase are used in the following ways.

xtabs(Percent4~PurchaserType,aggregate(Percent4~PurchaserType,banana_short,mean))


#If these longer-lasting bananas were sold at your store, would you buy more bananas than you currently do?

xt24<- (xtabs(~ If.these.longer.lasting.bananas.were.sold.at.your.store..would.you.buy.more.bananas.than.you.currently.do. + Store9, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ If.these.longer.lasting.bananas.were.sold.at.your.store..would.you.buy.more.bananas.than.you.currently.do. + Buckets, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ If.these.longer.lasting.bananas.were.sold.at.your.store..would.you.buy.more.bananas.than.you.currently.do.  + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ If.these.longer.lasting.bananas.were.sold.at.your.store..would.you.buy.more.bananas.than.you.currently.do. + PurchaserType, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

#Would you pay more for these longer-lasting bananas?


xt24<- (xtabs(~ PayMore+ Store9, data= banana_short))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24a)

xt21<- (xtabs(~ PayMore+ Buckets, data= banana_short))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21a)

xt22<- (xtabs(~ PayMore + HH_Fixed, data= banana_short))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22a)

xt23<- (xtabs(~ PayMore+ Income, data= banana_short))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23a)

