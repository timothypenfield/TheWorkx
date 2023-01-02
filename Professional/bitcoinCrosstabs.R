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
install.packages("readxl")
library("readxl")
install.packages("data.table")
library(data.table)


``
#Setup#
bitcoin <- read_excel(file.choose())


cb <- function(df, sep="\t", dec=",", max.size=(200*1000)){
  # Copy a data.frame to clipboard
  write.table(df, paste0("clipboard-", formatC(max.size, format="f", digits=0)), sep=sep, row.names=TRUE, dec=dec)
}
summary(bitcoin)
View(bitcoin)

#AgeBuckets

bitcoin$agebuckets <- cut(x = bitcoin$age, breaks = c(0, 29, 39, 49, 59, 65))





#Basic Cross Tabs

freq(bitcoin$gender)
x1<- (xtabs(~ gender+ country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1a)



xt1a<-freq(bitcoin$schooling)
cb(xt1a)
x1<- (xtabs(~ schooling+ country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1a)



x1<- (xtabs(~ employment+ country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1a)

freq(bitcoin$employment)

x1<- (xtabs(~ industry+ country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1a)


x1<- (xtabs(~ hhi+ country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1a)

x1<- (xtabs(~ agebuckets+ country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1a)

freq(bitcoin$agebuckets)


~~~~~~~~~~~~~~~~


xt1<- (xtabs(~ phoneapps1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ phoneapps2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ phoneapps3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ phoneapps4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)


x7<- rbind(xt1,xt2,xt3)
cb(x7)


freq(bitcoin$phone3)

~~~~~~~~~~~~~~

  
xt4<- (xtabs(~ bankappfreq + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)  

~~~~~~~~~~~~~~~~~~~~~~~~~

xt4<- (xtabs(~ bitcoinknowledge + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  
  xt1<- (xtabs(~ heard1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ heard2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ heard3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ heard4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ heard5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ heard6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ heard7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


x99<- rbind(xt1,xt2,xt3,xt4,xt5,xt6)
cb(x99)

~~~~~~~~~~~~~~~~~
  
xt4<- (xtabs(~ everpurchased + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4a)

xt4<- (xtabs(~ everpurchased + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~~~~~~~~
  
xt4<- (xtabs(~ likelysoon + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~~~~~~~~
  
xt4<- (xtabs(~ smallorlargeamount + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
xt1<- (xtabs(~ RecentPurchase1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ RecentPurchase2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ RecentPurchase3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ RecentPurchase4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ RecentPurchase5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ RecentPurchase6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ RecentPurchase7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


x99<- rbind(xt1,xt2,xt3,xt4,xt5,xt6)
cb(x99)


~~~~~~~~~~~~~~~~~~~~~


xt4<- (xtabs(~ savingsperc + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)



xt4<- (xtabs(~ foreigncurrencyexc + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~~~~~~~~~~~~~~

  
xt4<- (xtabs(~ othercrypto + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~~

  xt1<- (xtabs(~ manage1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ manage2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ manage3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ manage4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ manage5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ manage6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ manage7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


xt8<- (xtabs(~ manage8 + country, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)


xt9<- (xtabs(~ manage9 + country, data= bitcoin))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt9)


xt10<- (xtabs(~ manage10 + country, data= bitcoin))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt10)


xt11<- (xtabs(~ manage11 + country, data= bitcoin))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt11)


xt12<- (xtabs(~ manage12 + country, data= bitcoin))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt12)


xt13<- (xtabs(~ manage13 + country, data= bitcoin))
xt13a<-round(prop.table(as.matrix(xt13),2),2)
cb(xt13)


xt14<- (xtabs(~ manage14 + country, data= bitcoin))
xt14a<-round(prop.table(as.matrix(xt14),2),2)
cb(xt14)


xt15<- (xtabs(~ manage15 + country, data= bitcoin))
xt15a<-round(prop.table(as.matrix(xt15),2),2)
cb(xt15)


xt16<- (xtabs(~ manage16 + country, data= bitcoin))
xt16a<-round(prop.table(as.matrix(xt16),2),2)
cb(xt16)


xt17<- (xtabs(~ manage17 + country, data= bitcoin))
xt17a<-round(prop.table(as.matrix(xt17),2),2)
cb(xt17)

xt18<- (xtabs(~ manage18 + country, data= bitcoin))
xt18a<-round(prop.table(as.matrix(xt18),2),2)
cb(xt18)

xt19<- (xtabs(~ manage19 + country, data= bitcoin))
xt19a<-round(prop.table(as.matrix(xt19),2),2)
cb(xt19)

xt20<- (xtabs(~ manage20 + country, data= bitcoin))
xt20a<-round(prop.table(as.matrix(xt20),2),2)
cb(xt20)

x99<- rbind(xt4)
cb(x99)

~~~~~~~~~~~~~~

xt4<- (xtabs(~ save + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)


xt1<- (xtabs(~ savefor1 + savehow6, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ savefor2 + savehow6, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ savefor3 + savehow6, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ savefor4 + savehow6, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ savefor5 + savehow6, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ savefor6 + savehow6, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ savefor7 + savehow6, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

xt8<- (xtabs(~ savefor8 + savehow6, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)

x99<- rbind(xt1,xt2,xt3,xt4,xt5,xt6,xt7)
cb(x99)

~~~~~~~~~~~~~~
  

xt1<- (xtabs(~ savehow1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ savehow3 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ savehow3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ savehow4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ savehow5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ savehow6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

x99<- rbind(xt1,xt2,xt3,xt4,xt5)
cb(x99)


~~~~~~~~~~~~~~
  
  xt4<- (xtabs(~ ownbitcoin + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~
  
  
  xt1<- (xtabs(~ multiplewallets1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ multiplewallets2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ multiplewallets3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ multiplewallets4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ multiplewallets5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ multiplewallets6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

x99<- rbind(xt1,xt2,xt3,xt4,xt5)
cb(x99)


~~~~~~~~~~~~~~

  freq
    
      xt1<- (xtabs(~ storebit1 + security8, data= bitcoin))
    xt1a<-round(prop.table(as.matrix(xt1),2),2)
    cb(xt1)
    
    xt2<- (xtabs(~ storebit2 + security8, data= bitcoin))
    xt2a<-round(prop.table(as.matrix(xt2),2),2)
    cb(xt2)
    
    xt3<- (xtabs(~ storebit3 + security8, data= bitcoin))
    xt3a<-round(prop.table(as.matrix(xt3),2),2)
    cb(xt3)
    
    xt4<- (xtabs(~ storebit4 + security8, data= bitcoin))
    xt4a<-round(prop.table(as.matrix(xt4),2),2)
    cb(xt4)
    
    x99<- rbind(xt1,xt2,xt3,xt4)
    cb(x99)
      

~~~~~~~~~~~~~~

  
  xt1<- (xtabs(~ downsize1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ downsize2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ downsize3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ downsize4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ downsize5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ downsize6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ downsize7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

x99<- rbind(xt1,xt2,xt3,xt4,xt5,xt6)
cb(x99)

~~~~~~~~~~~~~~~~

xt4<- (xtabs(~ stableknown + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt4<- (xtabs(~ stableuse + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

~~~~~~~~~~~~~~~
  

  
  xt1<- (xtabs(~ stablereason1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ stablereason2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ stablereason3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)


xt4<- (xtabs(~ stablereason4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)


x99<- rbind(xt1,xt2,xt3)
cb(x99)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  xt1<- (xtabs(~ problemcontact1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ problemcontact2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ problemcontact3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)


xt4<- (xtabs(~ problemcontact4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)


xt5<- (xtabs(~ problemcontact5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)


x99<- rbind(xt1,xt2,xt3,xt4)
cb(x99)


~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ infocomfort1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ infocomfort2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ infocomfort3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)


x99<- rbind(xt1,xt2,xt3)
cb(x99)
~~~~~~~~~~~~~~~~~~~~~~
  
  
  xt1<- (xtabs(~ feefreq + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt1<- (xtabs(~ fee + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)


~~~~~~~~~~~~~~~~~~~~~~~~~~~

xt1<- (xtabs(~ payextra1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ payextra2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ payextra3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ payextra4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ payextra5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ payextra6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)


x99<- rbind(xt1,xt2,xt3,xt4,xt5)
cb(x99)
~~~~~~~~~~~~~~~~~~~~~~

  xt6<- (xtabs(~ Die + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)  


~~~~~~~~~~~  
  
  
  xt6<- (xtabs(~ lostaccess + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6a)  

xt6<- (xtabs(~ howlost + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)  


xt6<- (xtabs(~ Regain + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)  

xt6<- (xtabs(~ Regain_how + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)  



xt6<- (xtabs(~ lost + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)  



xt6<- (xtabs(~ Friends + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6) 


xt6<- (xtabs(~ seedphrase + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6) 

~~~~~~~~~~~~~~~~~~~~
  
xt1<- (xtabs(~ Use1 + storebit4, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ Use2 + storebit4, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ Use3 + sastorebit4, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ Use4 + storebit4, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ Use5 + storebit4, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ Use6 + storebit4, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

  


x99<- rbind(xt1,xt2)
cb(x99)


~~~~~~~~~~~~~~~~~~~~
  
xt1<- (xtabs(~ imagine1 + Use7, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ imagine2 + Use7, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ imagine3 + Use7, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ imagine4 + Use7, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ imagine5 + Use7, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

x99<- rbind(xt1,xt2,xt3,xt4)
cb(x99)


  ~~~~~~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ pwmanage1 + howlost, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ pwmanage2 + howlost, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ pwmanage3 + howlost, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ pwmanage4 + howlost, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ pwmanage5 + howlost, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ pwmanage6 + howlost, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ pwmanage7 + howlost, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

xt8<- (xtabs(~ pwmanage8 + howlost, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)

x99<- rbind(xt1,xt2,xt3)
cb(x99)
  

~~~~~~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ security1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ security2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ security3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ security4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ security5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ security6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ security7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

xt8<- (xtabs(~ security8 + country, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)

x99<- rbind(xt1,xt2,xt3,xt4,xt5,xt6)
cb(x99)

~~~~~~~~~~~~~~~
  
  
xt6<- (xtabs(~ happy + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6a)  



~~~~~~~~~~~~~~~~~~~~
  
  
  ~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ send1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ send2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ send3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ send4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ send5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ send6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ send7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


xt8<- (xtabs(~ send8 + country, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)


xt9<- (xtabs(~ send9 + country, data= bitcoin))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt9)


xt10<- (xtabs(~ send10 + country, data= bitcoin))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt10)


xt11<- (xtabs(~ send11 + country, data= bitcoin))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt11)


xt12<- (xtabs(~ send12 + country, data= bitcoin))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt12)


xt13<- (xtabs(~ send13 + country, data= bitcoin))
xt13a<-round(prop.table(as.matrix(xt13),2),2)
cb(xt13)


xt14<- (xtabs(~ send14 + country, data= bitcoin))
xt14a<-round(prop.table(as.matrix(xt14),2),2)
cb(xt14)


xt15<- (xtabs(~ send15 + country, data= bitcoin))
xt15a<-round(prop.table(as.matrix(xt15),2),2)
cb(xt15)


xt16<- (xtabs(~ send16 + country, data= bitcoin))
xt16a<-round(prop.table(as.matrix(xt16),2),2)
cb(xt16)


xt17<- (xtabs(~ send17 + country, data= bitcoin))
xt17a<-round(prop.table(as.matrix(xt17),2),2)
cb(xt17)

xt18<- (xtabs(~ send18 + country, data= bitcoin))
xt18a<-round(prop.table(as.matrix(xt18),2),2)
cb(xt18)

xt19<- (xtabs(~ send19 + country, data= bitcoin))
xt19a<-round(prop.table(as.matrix(xt19),2),2)
cb(xt19)

xt20<- (xtabs(~ send20 + country, data= bitcoin))
xt20a<-round(prop.table(as.matrix(xt20),2),2)
cb(xt20)


xt21<- (xtabs(~ send21 + country, data= bitcoin))
xt21a<-round(prop.table(as.matrix(xt21),2),2)
cb(xt21)


xt22<- (xtabs(~ send22 + country, data= bitcoin))
xt22a<-round(prop.table(as.matrix(xt22),2),2)
cb(xt22)


xt23<- (xtabs(~ send23 + country, data= bitcoin))
xt23a<-round(prop.table(as.matrix(xt23),2),2)
cb(xt23)


xt24<- (xtabs(~ send24 + country, data= bitcoin))
xt24a<-round(prop.table(as.matrix(xt24),2),2)
cb(xt24)


xt25<- (xtabs(~ send25 + country, data= bitcoin))
xt25a<-round(prop.table(as.matrix(xt25),2),2)
cb(xt25)

x99<- rbind(xt4)
cb(x99)


~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ pay1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ pay2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ pay3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ pay4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ pay5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ pay6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ pay7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


xt8<- (xtabs(~ pay8 + country, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)


xt9<- (xtabs(~ pay9 + country, data= bitcoin))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt9)


xt10<- (xtabs(~ pay10 + country, data= bitcoin))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt10)


xt11<- (xtabs(~ pay11 + country, data= bitcoin))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt11)


xt12<- (xtabs(~ pay12 + country, data= bitcoin))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt12)


xt13<- (xtabs(~ pay13 + country, data= bitcoin))
xt13a<-round(prop.table(as.matrix(xt13),2),2)
cb(xt13)


xt14<- (xtabs(~ pay14 + country, data= bitcoin))
xt14a<-round(prop.table(as.matrix(xt14),2),2)
cb(xt14)


xt15<- (xtabs(~ pay15 + country, data= bitcoin))
xt15a<-round(prop.table(as.matrix(xt15),2),2)
cb(xt15)


xt16<- (xtabs(~ pay16 + country, data= bitcoin))
xt16a<-round(prop.table(as.matrix(xt16),2),2)
cb(xt16)


x99<- rbind(xt1,xt2,xt3,xt4)
cb(x99)

~~~~~~~~~~~~~~~
  
xt1<- (xtabs(~ exchreason1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ exchreason2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ exchreason3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ exchreason4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ exchreason5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ exchreason6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ exchreason7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


x99<- rbind(xt1,xt2,xt3,xt4,xt5, xt6)
cb(x99)


~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ potentialchange1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ potentialchange2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ potentialchange3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ potentialchange4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ potentialchange5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ potentialchange6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ potentialchange7 + country, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

xt8<- (xtabs(~ potentialchange8 + country, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)

xt9<- (xtabs(~ potentialchange9 + country, data= bitcoin))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt9)

x99<- rbind(xt1,xt2,xt3,xt4,xt5,xt6,xt7,xt8)
cb(x99)

~~~~~~~~~~~~~~~~~~~~
  

  xt1<- (xtabs(~ hardwarewhen1 + country, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ hardwarewhen2 + country, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ hardwarewhen3 + country, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ hardwarewhen4 + country, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ hardwarewhen5 + country, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ hardwarewhen6 + country, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

x99<- rbind(xt1,xt2,xt3,xt4,xt5)
cb(x99)


~~~~~~~~~~~~~~
  
xt1<- (xtabs(~ everpurchased + ownbitcoin, data= bitcoin))
xt1a<-round(prop.table(as.matrix(x1),2),2)
cb(xt1)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  
  
  xt1<- (xtabs(~ manage1 + ownbitcoin, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ manage2 + ownbitcoin, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ manage3 + ownbitcoin, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ manage4 + ownbitcoin, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ manage5 + ownbitcoin, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ manage6 + ownbitcoin, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ manage7 + ownbitcoin, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)


xt8<- (xtabs(~ manage8 + ownbitcoin, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)


xt9<- (xtabs(~ manage9 + ownbitcoin, data= bitcoin))
xt9a<-round(prop.table(as.matrix(xt9),2),2)
cb(xt9)


xt10<- (xtabs(~ manage10 + ownbitcoin, data= bitcoin))
xt10a<-round(prop.table(as.matrix(xt10),2),2)
cb(xt10)


xt11<- (xtabs(~ manage11 + ownbitcoin, data= bitcoin))
xt11a<-round(prop.table(as.matrix(xt11),2),2)
cb(xt11)


xt12<- (xtabs(~ manage12 + ownbitcoin, data= bitcoin))
xt12a<-round(prop.table(as.matrix(xt12),2),2)
cb(xt12)


xt13<- (xtabs(~ manage13 + ownbitcoin, data= bitcoin))
xt13a<-round(prop.table(as.matrix(xt13),2),2)
cb(xt13)


xt14<- (xtabs(~ manage14 + ownbitcoin, data= bitcoin))
xt14a<-round(prop.table(as.matrix(xt14),2),2)
cb(xt14)


xt15<- (xtabs(~ manage15 + ownbitcoin, data= bitcoin))
xt15a<-round(prop.table(as.matrix(xt15),2),2)
cb(xt15)


xt16<- (xtabs(~ manage16 + ownbitcoin, data= bitcoin))
xt16a<-round(prop.table(as.matrix(xt16),2),2)
cb(xt16)


xt17<- (xtabs(~ manage17 + ownbitcoin, data= bitcoin))
xt17a<-round(prop.table(as.matrix(xt17),2),2)
cb(xt17)

xt18<- (xtabs(~ manage18 + ownbitcoin, data= bitcoin))
xt18a<-round(prop.table(as.matrix(xt18),2),2)
cb(xt18)

xt19<- (xtabs(~ manage19 + ownbitcoin, data= bitcoin))
xt19a<-round(prop.table(as.matrix(xt19),2),2)
cb(xt19)

xt20<- (xtabs(~ manage20 + ownbitcoin, data= bitcoin))
xt20a<-round(prop.table(as.matrix(xt20),2),2)
cb(xt20)

x99<- rbind(xt4)
cb(x99)  




~~~~~~~~~~~~~~~~~~~~
  
  xt1<- (xtabs(~ pwmanage1 + howlost, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ pwmanage2 + howlost, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ pwmanage3 + howlost, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ pwmanage4 + howlost, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ pwmanage5 + howlost, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ pwmanage6 + howlost, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ pwmanage7 + howlost, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

xt8<- (xtabs(~ pwmanage8 + howlost, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)

freq(bitcoin$howlost)


x99<- rbind(xt4)
cb(x99)

~~~~~~~~~~~~~~~~~~~~
  
xt1<- (xtabs(~ pwmanage1 + howlost, data= bitcoin))
xt1a<-round(prop.table(as.matrix(xt1),2),2)
cb(xt1)

xt2<- (xtabs(~ pwmanage2 + howlost, data= bitcoin))
xt2a<-round(prop.table(as.matrix(xt2),2),2)
cb(xt2)

xt3<- (xtabs(~ pwmanage3 + howlost, data= bitcoin))
xt3a<-round(prop.table(as.matrix(xt3),2),2)
cb(xt3)

xt4<- (xtabs(~ pwmanage4 + howlost, data= bitcoin))
xt4a<-round(prop.table(as.matrix(xt4),2),2)
cb(xt4)

xt5<- (xtabs(~ pwmanage5 + howlost, data= bitcoin))
xt5a<-round(prop.table(as.matrix(xt5),2),2)
cb(xt5)

xt6<- (xtabs(~ pwmanage6 + howlost, data= bitcoin))
xt6a<-round(prop.table(as.matrix(xt6),2),2)
cb(xt6)

xt7<- (xtabs(~ pwmanage7 + howlost, data= bitcoin))
xt7a<-round(prop.table(as.matrix(xt7),2),2)
cb(xt7)

xt8<- (xtabs(~ pwmanage8 + howlost, data= bitcoin))
xt8a<-round(prop.table(as.matrix(xt8),2),2)
cb(xt8)
