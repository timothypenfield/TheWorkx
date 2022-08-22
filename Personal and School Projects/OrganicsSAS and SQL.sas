libname alldata 'C:/Users/timot/Dropbox/Educational/MSBA/BAN7040 Data Mining and Machine Learning/Organic Products Case Study';

proc contents data = alldata.organics;
run;
/*********** PART ONE: Initial Descriptive Stats and Review*************/

proc means data=alldata.organics
max min nmiss n mean median;
var DemAffl DemAge PromSpend PromTime TargetAmt TargetBuy;
title1 "Basic Proc Means";
run;
proc means data=alldata.organics
P25 P50 P75 P95 mean; 
class TargetBuy;
var PromSpend;
title1 "Quartiles for Spend,by TargetBuy";
run;
proc sgplot data = alldata.organics ;
scatter x=DemAffl y=PromSpend / group=TargetBuy;
title1 "Affluence vs PromSpend,by TargetBuy";
run ;
proc sgplot data = alldata.organics_updated ;
scatter x=Age_T y=PromSpend / group=TargetBuy;
title1 "Age vs PromSpend,by TargetBuy";
run ;
proc sgplot data = alldata.organics ;
scatter x=PromTime y=PromSpend / group=TargetBuy;
title1 "Loyalty Duration vs PromSpend,by TargetBuy";
run ;
proc sgplot data = alldata.organics ;
scatter x=PromTime y=DemAge / group=TargetBuy;
title1 "Loyalty Duration vs PromSpend,by TargetBuy";
run ;
proc freq data = alldata.organics_updated ;
  tables TargetBuy*PromClass / plots = freqplot;
  run ;
proc corr data=alldata.organics;
var DemAffl
DemAge
PromSpend
PromTime
TargetBuy
TargetAmt;
title1 "Correlation: All Interval Variables";
run;
proc freq data = alldata.organics ;
  tables TargetBuy DemAge DemClusterGroup DemGender DemTVReg PromClass  / plots = freqplot;
  run ;

  /* Concerning/Missing Values Plan:
  Age: Use Median by Target Buy 
  DemGender: Throw Out "Unknowns"; with consumer research information essential for study, throwing out these 10%
  Loyalty Card Tenure--If not a PROMCLASS value, 0. Otherwise median by card type?
  Affluence Grade--Avg, by geographic region OR PROMCLASS
  Address TotalSpend for Typos in values/extreme outliers--Filter out Less than $5
  Address DemClusterGroup: explore to see if we can leave blanks, use a flag instead 

  Thoughts about next steps:
  --One Hot encode Gold/Platinum PROMCLASS
  --One Hot encode spending levels Quartiles
 
  --Total Annual Spend by Customer Type
  --Total Annual Spend by Customer Type
  
Some Takeaways so far to Remember:
  1. Of the 22223 customers in the database, 1/4 are considered an organic purchaser
  2. Wealthier Customers spend less at the store but are the primary organic purchasers
  3. Younger customers are your organic purchasers
  **********************************************************/


  /*********** PART TWO: Data Wrangling and Cleansing*************/


  /*Fixing Age: Median Age by PromClass Temp Table*/
Proc SQL;
Create Table work.age_avg as select
PromClass, TargetBuy, avg(DemAge) as AVG_age, count(TargetBuy) as N from alldata.organics
Group by PromClass, TargetBuy;
run; 
proc print data=work.age_avg;
run;
/*If Missing Age, use 
  Gold & Non Buy:    61 
  Gold &  Buy        55  
  Platinum & Non Buy 64 
  Platinum & Buy     57 
  Silver  & NonBuy   56 
  Silver & Buy       46 
  Tin & Non Buy      50 
  Tin & Buy          41 

/*Addressing Loyalty Card Tenure*/ 
Proc SQL;
Create Table work.PromTime_avg as select
PromClass, TargetBuy, avg(PromTime) as AVG_Time, median(PromTime) as Median_Time, avg(Demage) as AVG_Age,count(PromClass) as N from alldata.organics
Group by PromClass, TargetBuy;
run;
proc print data=work.PromTime_avg;
run;
/*If Missing PromTime, use 6.5 across board. It isn't that significant of a change, but here is a breakout

Breakout by sections...
  Gold & Non Buy:    6.5 
  Gold &  Buy        7 
  Platinum & Non Buy 6.5 
  Platinum & Buy     7 
  Silver  & NonBuy   7 
  Silver & Buy       6 
  Tin & Non Buy      6.5 
  Tin & Buy          6 


/*Fixing DemAffl: Age, by geographic region OR PROMCLASS*/
Proc SQL;
Create Table work.affuluence_AVG_Region as select
DemReg, avg(DemAffl) as AVG_Aff, count(DemAffl) as TotalN from alldata.organics
Group by DemReg;
run; 
proc print data=work.affuluence_AVG_Region;
run;
Proc SQL;
Create Table work.affuluence_AVG_Class as select
PromClass, avg(DemAffl) as AVG_Aff, count(DemAffl) as TotalN from alldata.organics
Group by PromClass;
run;
proc print data=work.affuluence_AVG_Class;
run;
/*No significant Affluence difference by PromClass or Region. Will just use avg DemAffl for missing
8.7118933*/



/*Explore Extreme Outliers with TotalSpend*/
proc means data=alldata.organics
P25 P50 P75 P95 mean; 
class TargetBuy;
var PromSpend;
title1 "Quartiles for Spend,by TargetBuy";
run;

proc sql;
create table work.spend_low_outliers as 
select ID, TargetBuy, PromSpend
from alldata.organics 
having PromSpend LT 5;
Title1 Low End Outliers;
run; 
/*Minimum Spend of $5 filter should be used--at least buy a small value item in store. Nearly 6500 records have $.01 spend which is not valuable or feasible for us to use. Without understanding the way data was collected, safest to throw out */


proc means data=alldata.organics
P25 P50 P75 P95 mean; 
class DemClusterGroup TargetBuy;
var PromSpend DemAge;
title1 "Quartiles for Spend,by DemClusterGroup and TargetBuy";
run;
/*Inconclusive, but will do more exploring about how to transform/flag the neighborhood data with corrected spend data/* 



/*Thoughts stemming from Variable Fixes
-Huge Effort to Get New Members 6 years ago--What event occurred? Organic Buyers came on board about 6 months sooner than TargetBuy=0*/

/*Clean Data Sets*/

Proc SQL; 
Create table alldata.organics_updated as select
id, DemAffl, DemAge,DemClusterGroup, DemGender, DemReg, DemTVReg, PromClass, PromSpend, PromTime, TargetBuy, TargetAmt
from alldata.organics
where DemGender NE "U" AND DemGender is not NULL and PromSpend GT 5 and DemReg is not NULL;
run; 
proc means data=alldata.organics_updated
P25 P50 P75 P95 mean; 
class TargetBuy;
var PromSpend;
title1 "Quartiles for Updated Spend,by TargetBuy";
run;

/*Reviewing the PromSpend */
proc means data=alldata.organics_updated
P25 P50 P75 P95 mean; 
var PromSpend;
class targetbuy;
title1 "Quartiles for Updated Spend";
run;
proc fastclas

/*Reviewing the DemClusterGroup */
proc means data=alldata.organics_updated
P25 P50 P75 P95 mean; 
class DemClusterGroup;
var PromSpend DemAge DemAffl TargetAmt;
title1 "Quartiles for Spend,by DemClusterGroup";
run;

proc freq data = alldata.organics_updated;
  tables TargetBuy*DemClusterGroup / plots = freqplot;
  run ;
/*Reviewing the DemClusterGroup--leaving as is for now*/

proc sql;
alter table alldata.organics_updated
ADD PROMCLASS_HI num (1),Spend_Quartile num (1), Age_t num(3) format=BEST12., PromTime_t num (3) format=BEST12.;
quit;

proc sql;
update alldata.organics_updated
set DemAffl =8.71 where DemAffl is NULL;
run; 
data alldata.organics_updated;
modify alldata.organics_updated;
IF (PromClass EQ "Platinum" or PromClass EQ "Gold") THEN PROMCLASS_HI = 1;
else PROMCLASS_HI=0;

IF (PromClass EQ "Gold" and DemAge= "") and TargetBuy=0 THEN Age_t = 61;
ELSE IF (PromClass EQ "Gold" and DemAge = "") and TargetBuy=1 THEN Age_t = 55;
ELSE IF (PromClass EQ "Platinum" and DemAge = "") and TargetBuy=0 THEN Age_t = 64;
ELSE IF (PromClass EQ "Platinum" and DemAge = "") and TargetBuy=1 THEN Age_t = 57;
ELSE IF (PromClass EQ "Silver" and DemAge= "") and TargetBuy=0 THEN Age_t = 56;
ELSE IF (PromClass EQ "Silver" and DemAge= "") and TargetBuy=1 THEN Age_t = 46;
ELSE IF (PromClass EQ "Tin" and DemAge= "") and TargetBuy=0 THEN Age_t = 50;
ELSE IF (PromClass EQ "Tin" and DemAge= "") and TargetBuy=1 THEN Age_t = 41;
Else if DemAge> 0 then Age_t= DemAge;

 
IF PromSpend =< 1500 THEN Spend_Quartile =1 ;
ELSE IF PromSpend > 1500 and PromSpend =< 4884.25 THEN Spend_Quartile = 2;
ELSE IF PromSpend > 4884.25 and PromSpend =< 7000 THEN Spend_Quartile = 3;
ELSE IF PromSpend > 7000 THEN Spend_Quartile = 3;


IF PromTime= "" THEN PromTime_t = 6.5;
ELSE IF PromTime>0 THEN PromTime_t = PromTime;
run;

proc print data=alldata.organics_updated(obs=10);
var _ALL_;
title1 "Updated Data Source, 10 Obs";
run;

   
