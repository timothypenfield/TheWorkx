libname alldata 'C:\Users\timot\Dropbox\Educational\MSBA\Independent\Case Efficiency';
options mprint;


%MACRO csvImport(csv=);	
	FILENAME REFFILE %tslit("C:\Users\timot\Dropbox\Educational\MSBA\Independent\Case Efficiency\&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv(rename=adj_close=&csv) replace;
		GETNAMES=YES;
		guessingrows=250;
	RUN;
%MEND;
%csvImport(csv=HourDataRaw);
%csvImport(csv=HourDataRaw_NoTim);
%csvImport(csv=CaseData);
proc contents data = work.HourDataRaw;
run;
proc print data = work.HourDataRaw_NoTim;
run;
proc contents data = work.casedata;
run;
/* Assumptions:

-No BA time is incorporated into durations.

Separated by each Case Reason....
-Time worked is in the 25 percentile (less than 1/2 cases)
-Time worked is in the 25th-75% percentile (less than 1/2 cases)
-Time worked is in the 75%-95% percentile (less than 1/2 cases)
-Extreme Cases are the most time consuming cases (95% of hours)
*/

proc sql;
create table work.total_case_time_NoTim as select
Case_Number, Case_Reason,sum(Actual_Hours) as TOTAL_HOURS_RECORDED
from work.HourDataRaw_NoTim 
Group by Account_Name__Account_Name, Case_Reason, Case_Number;
run;
proc print data=work.total_case_time_NoTim (OBS=25);
run;
/*

			Quick Case	Average Case	Hard Case	Very Hard Case
Account_Name	Case_Reason	N Obs	50th Pctl	Mean	75th Pctl	95th Pctl
Overall	ASR	462	6.5	10.372619	12.5	28.75
Overall	Fulfill	1964	0.5	1.1089358	1	3
Overall	IVR	115	2.5	4.3837391	5.75	14.25
Overall	LiveRevenue	299	1	1.8207358	2	6
Overall	Ltool	21	1.25	2.452381	3.5	4.75
Overall	Project	1	1	1	1	1
Overall	Scripts	1664	2.75	3.803113	4.75	10.75
Overall	Uploade	9	0.66	1.2855556	2.25	3.33
Overall	Webserv	78	1.75	3.3362821	3.5	11.25
Overall	ccAuth	16	1.75	4.78125	4.875	26
								
*/


proc sql;
create table alldata.casetimes as select
b.Age__Hours_ as Age,b.Account_Name,a.*,b.Closed_1_Week,b.closed_within_3_days
from work.total_case_time_NoTim a left join CaseData b
on a.Case_Number=b.Case_Number;
quit; 


proc means data=alldata.casetimes
P25 P50 mean median P75 P95; 
class Account_Name Case_Reason;
var TOTAL_HOURS_RECORDED;
title1 "Quartiles for Age and Hours by Account and Case Reason";
run;
proc means data=alldata.casetimes
P25 P50 mean median P75 P95;
class Case_Reason;
var TOTAL_HOURS_RECORDED;
title1 "Quartiles for Age and Hours by Case Reason";
run;


data alldata.casetimes_updated;
set alldata.casetimes;
IF (Case_Reason EQ "Scripts" AND TOTAL_HOURS_RECORDED >=0 and TOTAL_HOURS_RECORDED <= 1.5) THEN CasePercentile = "Quickest 25%";
else IF (Case_Reason EQ "Scripts" AND TOTAL_HOURS_RECORDED >1.5 and TOTAL_HOURS_RECORDED <=4.75) THEN CasePercentile = "Middle 50%";
else IF (Case_Reason EQ "Scripts" AND TOTAL_HOURS_RECORDED >4.75 AND TOTAL_HOURS_RECORDED <=10.75 ) THEN CasePercentile = "Above Average (75"; 
else if (Case_Reason EQ "Scripts" AND TOTAL_HOURS_RECORDED > 10.75) THEN CasePercentile = "Extreme Top 5% Cases";  

else if (Case_Reason EQ "ASR" AND TOTAL_HOURS_RECORDED >= 0 and TOTAL_HOURS_RECORDED <= 4.25) THEN CasePercentile = "Quickest 25%";
else IF (Case_Reason EQ "ASR" AND TOTAL_HOURS_RECORDED > 4.25 and TOTAL_HOURS_RECORDED <= 12.5) THEN CasePercentile = "Middle 50%";
else IF (Case_Reason EQ "ASR" AND TOTAL_HOURS_RECORDED > 12.5 and TOTAL_HOURS_RECORDED <= 28.75) THEN CasePercentile = "Above Average"; 
else if (Case_Reason EQ "ASR" AND TOTAL_HOURS_RECORDED > 28.75) THEN CasePercentile = "Extreme Top 5% Cases";   

else if (Case_Reason EQ "Fulfill" AND TOTAL_HOURS_RECORDED >= 0 and TOTAL_HOURS_RECORDED <= 0.5) THEN CasePercentile = "Quickest 25%";
else IF (Case_Reason EQ "Fulfill" AND TOTAL_HOURS_RECORDED > .50 and TOTAL_HOURS_RECORDED <= 1.1089358) THEN CasePercentile = "Middle 50%";
else IF (Case_Reason EQ "Fulfill" AND TOTAL_HOURS_RECORDED > 1.1089358 and TOTAL_HOURS_RECORDED <= 5) THEN CasePercentile = "Above Average";
else if  (Case_Reason EQ "Fulfill" AND TOTAL_HOURS_RECORDED > 5) THEN CasePercentile = "Extreme Top 5% Cases";   

else if (Case_Reason EQ "IVR" AND TOTAL_HOURS_RECORDED >= 0 and TOTAL_HOURS_RECORDED <= 1) THEN CasePercentile = "Quickest 25%";
else IF (Case_Reason EQ "IVR" AND TOTAL_HOURS_RECORDED > 1 and TOTAL_HOURS_RECORDED <= 5.75) THEN CasePercentile = "Middle 50%";
else IF (Case_Reason EQ "IVR" AND TOTAL_HOURS_RECORDED > 5.75 and TOTAL_HOURS_RECORDED <= 14.25) THEN CasePercentile = "Above Average";
else if (Case_Reason EQ "IVR" AND TOTAL_HOURS_RECORDED > 14.25) THEN CasePercentile = "Extreme Top 5% Cases";   
 
else if (Case_Reason EQ "LiveRev" AND TOTAL_HOURS_RECORDED >= 0 and TOTAL_HOURS_RECORDED <= .5) THEN CasePercentile = "Quickest 25%";
else IF (Case_Reason EQ "LiveRev" AND TOTAL_HOURS_RECORDED > .5 and TOTAL_HOURS_RECORDED <= 2) THEN CasePercentile = "Middle 50%";
else IF (Case_Reason EQ "LiveRev" AND TOTAL_HOURS_RECORDED > 2 and TOTAL_HOURS_RECORDED <= 6) THEN CasePercentile = "Above Average";
else if (Case_Reason EQ "LiveRev" AND TOTAL_HOURS_RECORDED > 6) THEN CasePercentile = "Extreme Top 5% Cases";   

else if (Case_Reason EQ "Webserv" AND TOTAL_HOURS_RECORDED >= 0 and TOTAL_HOURS_RECORDED <= 1) THEN CasePercentile = "Quickest 25%";
else IF (Case_Reason EQ "Webserv" AND TOTAL_HOURS_RECORDED > 1 and TOTAL_HOURS_RECORDED <= 3.5) THEN CasePercentile = "Middle 50%";
else IF (Case_Reason EQ "Webserv" AND TOTAL_HOURS_RECORDED > 3.5 and TOTAL_HOURS_RECORDED <= 11.25) THEN CasePercentile = "Above Average";
else if (Case_Reason EQ "Webserv" AND TOTAL_HOURS_RECORDED > 11.25) THEN CasePercentile = "Extreme Top 5% Cases";   

run; 
  run;
proc export data=alldata.casetimes_updated dbms=xls
outfile="C:\Users\timot\Dropbox\Educational\MSBA\Independent\Case Efficiency\CaseTypesUpdated.xls";
run;							
proc print data=alldata.casetimes_updated (OBS=10);
where Closed_1_Week=1;
run;
proc fastclus data=alldata.casetimes_updated out=Clust
maxclusters=7;
by Case_Reason;
var closed_within_3_days Closed_1_Week TOTAL_HOURS_RECORDED;
run;
  proc freq data=alldata.casetimes_updated;
  tables Closed_1_Week*Case_Reason  / plots = freqplot;
  title1 'Closed 1 Week, Overall'  
  run;
  proc freq data=alldata.casetimes_updated;
  tables closed_within_3_days*Case_Reason  / plots = freqplot; 
  title1 'Closed 3Days, Overall'; 

