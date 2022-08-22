libname alldata 'C:\Users\timot\Dropbox\Educational\MSBA\Independent\Serenova\Serenova_TimeSeries_Samples\';
options mprint;


%MACRO csvImport(csv=);	
	FILENAME REFFILE %tslit("C:\Users\timot\Dropbox\Educational\MSBA\Independent\Serenova\Serenova_TimeSeries_Samples\&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv(rename=adj_close=&csv) replace;
		GETNAMES=YES;
		guessingrows=15000;
	RUN;
%MEND;
%csvImport(csv=DatabyClient_raw);
proc print data=work.DatabyClient_raw (OBS=100);
where client="Telebrands"; 
run;
proc contents data=work.DatabyClient_raw;
run;
data DatabyClient_raw_fixed;
length Client_fixed $ 30;
set DatabyClient_raw;
If index(Client, 'TriStar')>0 then Client_fixed = 'TriStar Products';
ELSE if index(Client, 'Ontel')>0 then Client_fixed = 'Ontel Products Corporation';
ELSE if index(Client, 'All Star')>0 then Client_fixed = 'All Star';
ELSE if index(Client, 'AllStar')>0 then Client_fixed = 'All Star';
ELSE if index(Client, 'Telebrands')>0 then Client_fixed = 'Telebrands';
ELSE if index(Client, 'Tristar')>0 then Client_fixed = 'TriStar';
ELSE if index(Client, 'Tri Star')>0 then Client_fixed = 'TriStar';
ELSE if index(Client, 'SAS Group')>0 then Client_fixed = 'SAS Group';
ELSE IF index(Client, 'Abbott')>0 then Client_fixed = 'Abbott/Humira';
ELSE IF index(Client, 'Humira')>0 then Client_fixed = 'Abbott/Humira';
ELSE IF index(Client, 'Homeland Homewares')>0 then Client_fixed = 'Nutribullet LLC';
ELSE IF index(Client, 'Nutribullet LLC')>0 then Client_fixed = 'Nutribullet LLC';
ELSE Client_fixed = Client;
run;
proc contents data=DatabyClient_raw_fixed;
run;
proc print data=DatabyClient_raw_fixed (OBS=100);
where client contains "Tristar";
run; 
proc print data=DatabyClient_raw_fixed (OBS=100);
where client="Telebrands";
run;
proc sql;
create table work.TopDRClients
as select 
Monday_Week,Client_fixed,sum(calls) as TotalCalls, sum(Total_Time__minutes_) as TotalMinutes, sum(orders) as TotalOrders,Sum(Total_Formatted) as TotalValue
from DatabyClient_raw_fixed
group by Monday_Week,Client_fixed;
run;
proc print data=work.TopDRClients (OBS=500);
run;
proc export data=work.TopDRClients dbms=xlsx
outfile="C:\Users\timot\Dropbox\Educational\MSBA\Independent\Serenova\Serenova_TimeSeries_Samples\TopDRClients.xlsx";
run;

%csvImport(csv=ByCampaign_raw);
proc print data=ByCampaign_raw (OBS=100);
run;
data ByCampaign_raw2;
set ByCampaign_raw;
If index(Client, 'TriStar')>0 then Client_fixed = 'TriStar Products';
ELSE if index(Client, 'Ontel')>0 then Client_fixed = 'Ontel Products Corporation';
ELSE if index(Client, 'All Star')>0 then Client_fixed = 'All Star';
ELSE if index(Client, 'AllStar')>0 then Client_fixed = 'All Star';
ELSE if index(Client, 'Telebrands')>0 then Client_fixed = 'Telebrands';
ELSE if index(Client, 'Tristar')>0 then Client_fixed = 'TriStar';
ELSE if index(Client, 'Tri Star')>0 then Client_fixed = 'TriStar';
ELSE if index(Client, 'SAS Group')>0 then Client_fixed = 'SAS Group';
ELSE IF index(Client, 'Abbott')>0 then Client_fixed = 'Abbott/Humira';
ELSE IF index(Client, 'Humira')>0 then Client_fixed = 'Abbott/Humira';
else if index(Campaign, 'ASR')>0 then ASRCampaign=1;
else ASRCampaign=0;
ELSE Client_fixed = Client;
run;
proc sql;
create table work.TopDRClientsOverall
as select 
Client_fixed,sum(calls) as TotalCalls, sum(Total_Time__minutes_) as TotalMinutes, sum(orders) as TotalOrders,Sum(Total_Formatted) as TotalValue, Sum(Total_Formatted)/sum(orders) as AverageOrderValue
from DatabyClient_raw_fixed
group by Client_fixed
order by TotalCalls desc;
run;

proc print data=work.TopDRClientsOverall (OBS=500);
run;

proc fastclus data=work.TopDRClientsOverall out=Clust
maxclusters=5;
var TotalCalls TotalMinutes AverageOrderValue TotalOrders;
run;

proc export data=work.TopDRClients dbms=xlsx
outfile="C:\Users\timot\Dropbox\Educational\MSBA\Independent\Serenova\Serenova_TimeSeries_Samples\TopDRClients.xlsx";
run;
