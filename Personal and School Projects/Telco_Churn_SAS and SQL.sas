libname alldata 'C:/Users/timot/Dropbox/Educational/MSBA/BAN7040 Data Mining and Machine Learning/Telecom Churn Case Study';
proc contents data=alldata.churn2;
/*********** PART ONE: Initial Descriptive Stats and Review*************/
proc means data=alldata.churn2
nmiss max mean min median;
var _numeric_;
run;
proc freq data = alldata.churn2;
  tables AcctLength Churn CustServCalls Intl_Plan VMailPlan / plots = freqplot;
run ;
proc freq data = alldata.churn2;
  tables Intl_Plan*churn  / plots = freqplot;
  run; /* moderate impact*/
  proc freq data = alldata.churn2;
  tables CustServCalls*Intl_Plan  / plots = freqplot;
  run; /* limited impact*/
proc freq data = alldata.churn2;
  tables VMailPlan*churn  / plots = freqplot;
  run; /* limited impact*/
  proc freq data = alldata.churn2;
  tables VMailPlan*churn  / plots = freqplot;
  run; /* limited impact*/
  proc freq data = alldata.churn2;
  tables CustServCalls*VMailPlan  / plots = freqplot;
  run; /* limited impact*/
proc freq data = alldata.churn2;
  tables state*churn;
  run; /*Moderate Impact*/
proc means data=alldata.churn2
P25 P50 P75 P95 mean; 
class churn;
var CustServCalls AcctLength ;
title1 "Quartiles for CustServCalls and AcctLength,by Churn";
run;
proc means data=alldata.churn2
P25 P50 P75 P95 mean; 
class churn;
var DayMins;
title1 "Quartiles for Day Minutes,by Churn";
run;

/*Opportunities Moving Forward
1. Sum Minutes and Charges as single fields
2. Tier Out the Usage (Low/Medium/High)
3. Group by US Region?
4. Proc FastClaus account holders (account length, usage, Plan Types, Region)
*/

/*1. Sum Minutes and Charges as single fields*/
Proc SQL;
Create table alldata.churn3 as select
*, sum(DayMins,EveMins,NightMins,Intl_Mins)as TotalMinutes, sum(DayCalls,EveCalls,NightCalls,Intl_Calls)as TotalCalls, sum(DayCharge, EveCharge, NightCharge, Intl_Charge) as TotalCharges,
from alldata.churn2;
run; 
/*2. Explore Usage Tiers*/
proc fastclus data=alldata.churn3 out=work.UsageClust
maxclusters=3;
var TotalCharges;
run; 
/****Consistent and not really differentiated for minutes/calls, but charges were--connected to Intl and VMPlan*/
/*3. Variable Creation for Usage Tier, VMailFlag, Intl_Flag, and Region*/
data alldata.churn4;
set work.UsageClust;
if state in ('AK','ID','OR','WA','HI','CA','AZ','NV','MT','UT','WY','NM','CO','ND','SD') then Region='WEST';
else if state in ('TX','OK','AR','LA','KY','TN','AL','MS','GA','FL','NC','SC', 'VA') then Region='SOUTH';
else if state in ('NE','KS','IA','MO','MN','WI','MI','IL','IN','OH') then Region='MIDWEST';
else if state in ('NY','PA','WV','DE','NJ','CT','VT','MA','RI','NH','ME') then Region='EAST';

if VMailPlan eq 'yes' then VMailFlag =1;
else if VMailPlan eq 'no' then VMailFlag =0;

if Intl_Plan eq 'yes' then Intl_Flag =1;
else if Intl_Plan eq 'no' then Intl_Flag =0;

if Cluster eq 1 then BillingTier ="High";
if Cluster eq 2 then BillingTier ="Low";
if Cluster eq 3 then BillingTier ="Mid";
run;
  proc freq data = alldata.churn4;
  tables CustServCalls*BillingTier  / plots = freqplot;
  run; /* limited impact*/

proc fastclus data=alldata.churn4 out=work.MinClust
maxclusters=3;
var TotalMinutes TotalCalls TotalCharges Intl_Flag VMailFlag;
run; 
proc contents data=alldata.churn4;
proc corr data=alldata.churn4;
var Churn
CustServCalls
DayCalls
DayCharge
DayMins
EveCalls
EveCharge
EveMins
Intl_Flag
Intl_Charge
Intl_Mins
Intl_Calls
NightCharge
NightMins
NightCalls
TotalCalls
TotalCharges
TotalMinutes
VMailFlag
AcctLength;
title1 "Correlation: All Interval Variables";
run;
/*Takeaways:
CustServCalls, Intl_Flag, TotalCharges, VMailFlag, Total Minutes, DayCharge, but is it better to use the totalvariables or keep it day vs. night vs. international etc.*/
  proc freq data = alldata.churn4;
  tables region*churn  / plots = freqplot;
  run; /* limited impact*/
proc means data=alldata.churn4
P25 P50 P75 P95 mean; 
class churn;
var CustServCalls AcctLength cluster;
title1 "Quartiles for CustServCalls and AcctLength,by Churn";
run;
