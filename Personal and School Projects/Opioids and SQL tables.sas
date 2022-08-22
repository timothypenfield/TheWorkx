options mprint;
%MACRO csvImport(csv=);
	
	FILENAME REFFILE %tslit("/folders/myshortcuts/BAN7002/Week_3/Data/&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv;
		GETNAMES=YES;
		guessingrows=250;
	RUN;	
%MEND;
%csvImport(csv=NC_Physician);
%csvImport(csv=NC_Physician_Education);
%csvImport(csv=NC_Physician_scripts);
%csvImport(csv=NC_Zip);
%csvImport(csv=opioid_LIST);
libname W3 '/folders/myshortcuts/BAN7002/Week_3/Data';
proc datasets library=work nolist;
  change OPIOID_LIST=O;
  change NC_Physician=P;
  change NC_Physician_Education=PE;
  change NC_Physician_Scripts=PSCRIPT;
  change NC_ZIP=Z;
run;
Proc sql;
CREATE TABLE W3.Physician_MASTER As 
Select A.*, B.*
From P a inner join PE b 
ON A.NPI=B.NPI;
Quit;
PROC SQL;
CREATE TABLE W3.PhysicianMASTER AS
SELECT a.*, b.*,put(a.zip_code,5.) as zip_5
FROM W3.Physician_MASTER a INNER JOIN work.z b
ON (substr(put(a.zip_code,9.),1,5)=put(b.zip_code,5.));
QUIT;
PROC SQL;
DROP TABLE W3.Physician_MASTER;  
Quit;
proc sql;
alter table o
ADD OPIOID_FLAG num (1);
quit;
proc sql;
update o
Set OPIOID_FLAG=1;
QUIT;
PROC SQL;
CREATE TABLE W3.PSCRIPT_O AS
SELECT a.*,b.opioid_flag 
FROM Pscript a FULL JOIN O b
ON a.Drug_Name=b.drug_name;
QUIT;
Proc SQL;
	update w3.pscript_o
	Set OPIOID_FLAG=0
	where OPIOID_FLAG is NULL;
quit; 
PROC SQL;
Create table w3.RES_01 AS  
	SELECT 
		OPIOID_FLAG,count(drug_name) as _count
	FROM 
		w3.Pscript_O
	GROUP BY OPIOID_FLAG;
QUIT;
 proc sgplot data=w3.RES_01;
 	title1 "Opiate / Not Opiate";
 	vbar OPIOID_FLAG/ response=_count;
run;
PROC SQL;
	Create table temp AS  
	Select A.gender, B.OPIOID_FLAG, B.Drug_Name
	From W3.PhysicianMASTER a left join w3.PScript_O b
	ON A.NPI=B.NPI;
QUIT;
PROC SQL;
	Create table w3.Res_02 AS  
	Select gender,
	Sum(case when opioid_flag eq 1 then opioid_flag else 0 end) as opiate_count,
	Count(case when opioid_flag eq 0 then opioid_flag else 0 end) as non_opiate_count,
	Sum(case when opioid_flag eq 1 then opioid_flag else 0 end)/(count (opioid_flag)) as Opiate_pct
	From work.temp
	Group by gender;
QUIT;
 proc sgplot data=w3.RES_02;
 	title1 "Opiate Count by Gender";
 	vbar gender/ response=opiate_count;
run;
 proc sgplot data=w3.RES_02;
 	title1 "Opiate Percentage by Gender";
 	vbar gender/ response=Opiate_pct;
run;
PROC SQL;
create table w3.RES_03 
	as
	select drug_name,
	Sum (case when opioid_flag eq 1 then total_claim_count else 0 end) as Opiate_Claim_Count,
	Sum (case when opioid_flag eq 1 then total_day_supply else 0 end) as Opiate_Daily_Supply,
	Sum (case when opioid_flag eq 1 then total_drug_cost else 0 end) as Opiate_Total_Cost
	from w3.pscript_O
	Group by drug_name
	Having sum(case when opioid_flag eq 1 then total_day_supply else 0 end) GT 200000; 
Quit;
 proc sgplot data=w3.RES_03(OBS=10);
	vbar drug_name / response = Opiate_Claim_Count categoryorder=respdesc;
	TITLE 'Top Opiates by Total Claim Amount';
run;
 proc sgplot data=w3.RES_03(OBS=10);
	vbar drug_name / response = Opiate_Daily_Supply categoryorder=respdesc;
	TITLE 'Top Opiates by Total Claim Amount';
run;
 proc sgplot data=w3.RES_03(OBS=10);
	vbar drug_name / response = opiate_total_cost categoryorder=respdesc;
	TITLE 'Top Opiates by Total Drug Cost';
run;
PROC SQL;
create table w3.RES_04
	as
	select a.npi,a.First_Name,a.Last_Name, a.city_Name,a.organization_legal_name,a.provider_type, 
sum(case when b.opioid_flag eq 1 then b.total_day_supply else 0 end) as opiate_total_supply_day,
	sum(case when b.opioid_flag eq 0 then b.total_day_supply else 0 end) as	not_opiate_total_supply_day,
sum(case when b.opioid_flag eq 1 then b.total_day_supply else 0 end) / sum(case when b.opioid_flag eq 0 then b.total_day_supply else 0 end) as opiate_supply_ratio
	from W3.PHYSICIANMASTER a inner join w3.PSCRIPT_O b 
	On a.npi=b.npi
	Group by a.npi
	having sum(case when b.opioid_flag eq 1 then total_day_supply else 0 end) GT 0 
		and sum(case when b.opioid_flag eq 0 then total_day_supply else 0 end) GT 0 
	order by 4 desc;
quit;
proc sgplot data=w3.RES_04 (OBS=100000);
	scatter x=not_opiate_total_supply_day y=opiate_total_supply_day; 
	TITLE 'Opiate vs. Non-Opiate Supply';
run;
PROC RANK data=w3.RES_04 out=_res4a descending;
	var opiate_supply_ratio opiate_total_supply_day;
	ranks opiateRank opiateTotRank;
run;
proc sgplot data=WORK._res4a(where=(opiateRank LE 10));
	vbar npi / response=opiateRank categoryorder=respdesc nostatlabel;
	yaxis grid;
	Title "Top Physicians by Opoiate Ratio";
run;
proc sgplot data=WORK._res4a(where=(opiateRank LE 10));
	vbar npi / response=opiateTotRank categoryorder=respdesc nostatlabel;
	yaxis grid;
	Title "Top Physicians by Total Opiates Supplied";
run;
PROC SQL;
Create table w3.RES_05 as
Select a.zip_5,a.city_std, 
sum(case when b.opioid_flag eq 1 then b.total_day_supply else 0 end) as opiate_total_supply_day,
	sum(case when b.opioid_flag eq 0 then b.total_day_supply else 0 end) as	not_opiate_total_supply_day,
sum(case when b.opioid_flag eq 1 then b.total_day_supply else 0 end) / sum(case when b.opioid_flag eq 0 then b.total_day_supply else 0 end) as opiate_supply_ratio
	from W3.PHYSICIANMASTER a inner join w3.PSCRIPT_O b 
	On a.npi=b.npi
	Group by a.zip_5
	having sum(case when opioid_flag eq 1 then total_day_supply else 0 end) GT  0
		and count(case when opioid_flag eq 0 then total_day_supply else 0 end) GT 0 
	order by 4 desc;
quit;
PROC RANK data=w3.RES_05 out=work.res5 descending;
	var opiate_supply_ratio opiate_total_supply_day;
	ranks opiateRank_Location opiateTotRank_Location;
run;
proc sgplot data=_res5(where=(opiateRank_Location LE 20));
	vbar zip_5 / response= opiateRank_Location categoryorder=respdesc nostatlabel;
	yaxis grid;
	Title "Top Zip Codes by Opiate Ratio";
run;
proc sgplot data=_res5(where=(opiateTotRank_Location LE 20));
	vbar zip_5 / response=opiateTotRank_Location categoryorder=respdesc nostatlabel;
	yaxis grid;
	Title "Top Zip Codes by Total Opiates Supplied";
run;
proc sgplot data=WORK.res5(where=(opiateRank_Location LE 20));
	vbar city_std / response=opiateRank_Location categoryorder=respdesc nostatlabel;
	yaxis grid;
	Title "Top Cities by Opoiate Ratio";
run;
proc sgplot data=WORK.res5(where=(opiateTotRank_Location LE 20));
	vbar city_std / response=opiateTotRank_Location categoryorder=respdesc nostatlabel;
	yaxis grid;
	Title "Top Cities Cities by Total Opiates Supplied";
run;
PROC SQL;
Create table w3.RES_06 as
Select a.zip_5,a.city_std,
sum(case when b.opioid_flag eq 1 then b.total_day_supply else 0 end) as opiate_total_supply_day
/*sum(case when b.opioid_flag eq 1 then b.total_day_supply else 0 end)/a.population_est as Day_Supply_PerPerson*/
	from W3.PHYSICIANMASTER a inner join w3.PSCRIPT_O b 
	On a.npi=b.npi
	Group by a.zip_5
	having sum(case when opioid_flag eq 1 then total_day_supply else 0 end) GT  0
		and count(case when opioid_flag eq 0 then total_day_supply else 0 end) GT 0 
	order by 3 desc;
quit;
proc print(w3.RES_06)
PROC SQL;
Create table w3.RES_07 as
Select b.city_name, a.city_std
from z a full join p b
on a.city_name=b.city_name
Group by a.city_std;
quit;