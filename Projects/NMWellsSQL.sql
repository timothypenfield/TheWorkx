libname NMWells '/folders/myshortcuts/Dropbox/Data Consulting/RNE/Oil and Gas Data/NM State Data/';
run;
options mprint;
%MACRO csvImport(csv=);
	FILENAME REFFILE %tslit("/folders/myshortcuts/Dropbox/Data Consulting/Oil and Gas Data/NM State Data/AllWells&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=csv
		OUT=AllWells;
		GETNAMES=YES;
		guessingrows=250;
	RUN;	
%MEND;
%csvImport(csv=62418);
proc contents data=allwells;
run;
proc sql;
create table work.API_Part as 
select API, 
substr(API,1,2) as API_Prt1, 
substr(API,3,3)  as API_Prt2, 
substr(API,6,10) as API_Prt3
from allwells;
quit;
proc sql;
alter table work.API_Part
ADD Well_URL char (120);
quit;
proc sql;
update work.API_Part
Set Well_URL = catx("","https://wwwapps.emnrd.state.nm.us/ocd/ocdpermitting/Data/WellDetails.aspx?api=",API_Prt1,"-",API_Prt2,"-",API_Prt3);
quit;
proc sql;
create table allwellz as 
select a.*,b.Well_URL
from allwells a inner join  api_part b
on a.api=b.api;
quit;
proc sql;
drop table allwells, api_part;
quit;
proc datasets library=work nolist;
  change allwellz=allwells;
 run;
/*Summary Active Well Data by County*/
proc sql;
Create table NMWells.allactivesummary as 
select County, sum(days_prod_2017) as ProductionDays2017,
count('well_name') as ActiveWellCount,
Count(case when Well_Type contains "O" then Well_Type End) as ActiveOil_Wells,
Count(case when Well_Type contains "G" then Well_Type End) as ActiveGas_Wells,
Count(case when Well_Type contains "W" then Well_Type End) as ActiveWater_Wells,
Count(case when Well_Type contains "S" then Well_Type End) as ActiveSaltWater_Wells,
Count(case when Well_Type contains "I" then Well_Type End) as ActiveInjection_Wells,
Count(case when Well_Type contains "C" then Well_Type End) as ActiveCO2_Wells,
Count(case when Well_Type contains "M" then Well_Type End) as ActiveMisc_Wells
from work.AllWells
where COMPL_STATUS contains 'Active'
Group by County;
quit;
proc sort data=NMWells.allactivesummary;
	by descending ActiveWellCount;
run;
proc print data=NMWells.allactivesummary;
	var county ActiveWellCount ActiveOil_Wells ActiveGas_Wells ActiveWater_Wells ActiveSaltWater_Wells ActiveInjection_Wells ActiveCO2_Wells ActiveMisc_Wells;
	title1 "Active NM Wells, by Type and County";
run;
/*Summary Production by Operator*/
proc sql;
Create table work.OperatorProduction as 
Select operator, sum (gas_prod_2017,gas_prod_2016,gas_prod_2018) as ThreeYr_Gas_Production,
sum (oil_prod_2017,oil_prod_2016,oil_prod_2018) as ThreeYr_Oil_Production,
sum (oil_prod_2017,oil_prod_2016,oil_prod_2018,gas_prod_2017,gas_prod_2016,gas_prod_2018) as ThreeYr_OG_Production,
count('well_name') as WellCount
From work.AllWells
where operator is not null
Group by Operator;
quit; 
proc sort data=work.OperatorProduction;
	by descending ThreeYr_OG_Production;
run;
/*Top 2017 Production by Operator*/
proc sql;
Create table work.TopOperators2017 as 
Select operator, sum (days_prod_2017) as Total_Prod_Days_2017, sum (days_prod_2018) as Total_Prod_Days_2018YTD
From work.AllWells
where days_prod_2018>0 and days_prod_2017>0 and days_prod_2016>0 and operator is not null
Group by Operator;
quit; 
proc sort data=work.TopOperators2017;
	by descending Total_Prod_Days_2017;
run;
proc sql;
Create table NMWells.EnfieldOperatedAllWells as 
Select operator,API,County,Section,Township,Range,Well_Name,Well_Type,COMPL_STATUS
From work.AllWells
where operator="xxxxxxx";
quit; 
proc export data=NMWells.xxxxxOperatedAllWells
OUtfile= "/folders/myshortcuts/Dropbox/Data Consulting/Oil and Gas Data/xxxxx.xls" replace
DBMS= xls;
run;
proc sql;
Create table work.allwellsupdated AS
Select *, catx('',Township,Range,Section) as TownRgSec_AllWells
from allwells;
run;
proc sql;
drop table allwells;
run;
proc datasets library=work nolist;
  change allwellsupdated=allwells;
 run;
 proc import datafile= '/folders/myshortcuts/Dropbox/Data Consulting/RNE/Oil and Gas Data/Ownership Data/Inventory-With RF revisions  Title Info.xlsx'
	DBMS= XLSX
	OUT=work.LeaseOwnership;
	getnames=yes;
run;
Proc SQL;
Create table NMWells.ActiveWellsNearLeaseProperty
as Select 
a.County as Holding_County, 
a.TownRgSec as Holding_TownRgSec,
a.Fed_State_Lease__ as Holding_FedState_Lease, 
a.Gross_acres as Holding_acres,
a.Description as Holding_OwnershipDescr,
b.NS_CD as ActualWell_NorS,
b.EW_CD as ActualWell_WorE,
a.comments as Holding_AssignmentNotes,
a.Wells_Located_Hereon as HoldingWell_Notes, 
b.API as ActualWell_API,
b.Well_Name as ActualWell_Name ,
b.Operator as ActualWell_Operator,
b.OCD_UL as ActualWell_UnitLetter,
b.Well_Type as ActualWell_Type, 
b.TVD_Depth as ActualWell_TVDDepth, 
a.Interest__Type as Holding_InterestType, 
b.days_prod_2017 as ActualWell_2017Prod, 
b.days_prod_2018 as ActualWell_2018Prod,
b.Well_URL as ActualWell_URL
from work.LEASEOWNERSHIP a inner join work.allwells b
on a.TownRgSec=b.TownRgSec_AllWells
where b.COMPL_STATUS contains'Active' and (days_prod_2018>0 or days_prod_2017>0);
quit;


PROC means data=NMWells.ActiveWellsNearLeaseProperty
N NMISS;
var _NUMERIC_;
RUN;
data NMWells.WellInterests;
set NMWells.ActiveWellsNearLeaseProperty;
IF Holding_OwnershipDescr eq 'All' THEN ConfirmedOwnership = 1;
run;
proc export data=NMWells.WellInterests
OUtfile= "/folders/myshortcuts/Dropbox/Data Consulting/RNE/Oil and Gas Data/PossibleWells.xls" replace
DBMS= xls;
run;