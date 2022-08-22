libname alldata 'C:/Users/timot/Dropbox/Educational/MSBA/BAN7040 Data Mining and Machine Learning/University Enrollment Case Study';
/*
proc contents data = alldata.inq05_samp;
run;
/* Potential missing observations */

proc means data=alldata.inq05_samp
max min nmiss n;
var satscore;
run;
proc means data=alldata.inq05_samp
max min nmiss n;
var satscore;
run;
proc freq data = alldata.inq05_samp ;
  tables _all_ / plots = freqplot;
  run ;

proc freq data = alldata.inq05_samp ;
  tables enroll*instate / plots = freqplot;
  run ;
proc freq data = alldata.inq05_samp ;
  tables init_span / plots = freqplot;
run ;
proc sql;
create table work.average_distance as select
instate,avg(distance) as AVG_DISTANCE
from alldata.inq05_samp
Group by instate;
run;
proc sql;
create table work.avg_income as select
instate,avg(avg_income)as Avg_Income
from alldata.inq05_samp
Group by instate;
run;
proc sql;
create table alldata.inq05_updated
as select a.*,b.AVG_DISTANCE as AVG_DIST_STATESTATUS, c.Avg_Income as AVG_INC_STATESTATUS
from alldata.inq05_samp a,work.average_distance b, work.avg_income c
where a.instate=b.instate=c.instate;
quit;
data alldata.inq05_updated;
modify alldata.inq05_updated;
if distance eq '' then distance=AVG_DIST_STATESTATUS;
if avg_income eq '' then avg_income=AVG_INC_STATESTATUS;
if init_span <0 then init_span= 19;
by enroll ascending; 
run;
data alldata.inq05_updated;
modify alldata.inq05_updated;
drop AVG_DIST_STATESTATUS, AVG_INC_STATESTATUS;
run; 
proc means data=alldata.inq05_updated
median max min;
var init_span;
run;
proc corr data = alldata.inq05_updated;
  var  Enroll CAMPUS_VISIT CONTACT_DATE1                                                                                                                                                        
REFERRAL_CNTCTS                                                 
SELF_INIT_CNTCTS                                                
SOLICITED_CNTCTS                                                
TOTAL_CONTACTS                                                  
TRAVEL_INIT_CNTCTS                                              
avg_income                                                      
distance                                                        
hscrat                                                          
init_span                                                       
int1rat                                                         
int2rat                                                         
interest                                                        
premiere                                                        
satscore                                                        
sex                                                             
stuemail                                                        
telecq                                                          
;
 title1 "Correlation: All Interval Variables";
run;

proc freq data = alldata.inq05_updated ;
  tables interest / plots = freqplot;
run ;
proc means data=alldata.inq05_updated
P25 P50 P75 P95; 
class enroll;
var satscore;
run;
proc fastclus data=alldata.inq05_updated out=work.ContactClust
maxclusters=2;
var CAMPUS_Visit SOLICITED_CNTCTS TOTAL_CONTACTS distance hscrat init_span int1rat int2rat mailq premiere;
by enroll NOTSORTED ;
run;

proc fastclus data=alldata.inq05_updated out=work.DiversityClust
maxclusters=2;
var INTEREST SATscore HSCRAT AVG_INCOME distance INT1RAT STUEMAIL;
by enroll NOTSORTED ;
run;
