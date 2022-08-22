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
CREATE TABLE work.Physician_MASTER As 
Select A.*, B.*
From P a inner join PE b 
ON A.NPI=B.NPI;
Quit;
PROC SQL;
CREATE TABLE work.PhysicianMASTER AS
SELECT a.*, b.*,put(a.zip_code,5.) as zip_5
FROM work.Physician_MASTER a INNER JOIN work.z b
ON (substr(put(a.zip_code,9.),1,5)=put(b.zip_code,5.));
QUIT;
PROC SQL;
DROP TABLE work.Physician_MASTER;  
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
CREATE TABLE work.PSCRIPT_O AS
SELECT a.*,b.opioid_flag 
FROM Pscript a FULL JOIN O b
ON a.Drug_Name=b.drug_name;
QUIT;
Proc SQL;
	update work.pscript_o
	Set OPIOID_FLAG=0
	where OPIOID_FLAG is NULL;
quit; 
PROC SQL;
CREATE TABLE work.Physician_Full AS
Select a.*, b.*,
sum (2018,-a.Graduation_Year) as Years_in_Practice,
compbl(a.first_name ||' '|| a.middle_initial ||' '|| a.last_name) as Full_Name
from  work.PhysicianMASTER a inner join PE b
ON A.NPI=B.NPI;
quit;
Proc sql;
create table _scriptcount
	as
	select 
	npi,
	/*Opoiods*/
	sum(case when drug_name eq 'HYDROCODONE-ACETAMINOPHEN' then total_day_supply else 0 end) AS HYDROCODONE_day_count,
	sum(case when drug_name eq 'TRAMADOL HCL' then total_day_supply else 0 end) AS TRAMADOL_day_count,
	sum(case when drug_name eq 'OXYCODONE-ACETAMINOPHEN' then total_day_supply else 0 end) AS PERCOCET_day_count,
	sum(case when drug_name eq 'OXYCODONE HCL' then total_day_supply else 0 end) AS OXYCODONE_day_count,
	sum(case when drug_name eq 'FENTANYL' then total_day_supply else 0 end) AS FENTANYL_day_count,
	/*Non-Opoiods*/
	sum(case when drug_name eq 'LEVOTHYROXINE SODIUM' then total_day_supply else 0 end) AS LEVOTHYROXINE_day_count,
	sum(case when drug_name eq 'POTASSIUM CHLORIDE' then total_day_supply else 0 end) AS POTASSIUM_day_count,
	sum(case when drug_name eq 'METFORMIN HCL' then total_day_supply else 0 end) AS METFORMIN_day_count,
	sum(case when drug_name eq 'DILTIAZEM HCL' then total_day_supply else 0 end) AS DILTIAZEM_day_count,
	sum(case when drug_name eq 'GABAPENTIN' then total_day_supply else 0 end) AS GABAPENTIN_day_count
	From work.PScript_O;
	quit;
Proc sql;
create table _scriptcountupdated
	as
	select npi, sum(HYDROCODONE_day_count,TRAMADOL_day_count,PERCOCET_day_count,OXYCODONE_day_count,FENTANYL_day_count) as sum_daycount_5_opioids,
	sum(HYDROCODONE_day_count,TRAMADOL_day_count,PERCOCET_day_count,OXYCODONE_day_count,FENTANYL_day_count)/sum(HYDROCODONE_day_count,TRAMADOL_day_count,PERCOCET_day_count,OXYCODONE_day_count,FENTANYL_day_count,LEVOTHYROXINE_day_count,POTASSIUM_day_count,METFORMIN_day_count,DILTIAZEM_day_count,GABAPENTIN_day_count) as pct_daycount_5_opioids,
	sum(LEVOTHYROXINE_day_count,POTASSIUM_day_count,METFORMIN_day_count,DILTIAZEM_day_count,GABAPENTIN_day_count) as sum_daycount_5_nonopioids, 
	sum(LEVOTHYROXINE_day_count,POTASSIUM_day_count,METFORMIN_day_count,DILTIAZEM_day_count,GABAPENTIN_day_count)/sum(HYDROCODONE_day_count,TRAMADOL_day_count,PERCOCET_day_count,OXYCODONE_day_count,FENTANYL_day_count,LEVOTHYROXINE_day_count,POTASSIUM_day_count,METFORMIN_day_count,DILTIAZEM_day_count,GABAPENTIN_day_count) as pct_daycount_5_nonopioids
	from _scriptcount;
quit;
PROC SQL;
CREATE TABLE W3.NC_Opioid_Analysis AS
Select a.NPI,
a.Credentials,
a.Gender,
a.Entity_Type,
a.Street_Address_1,
a.Street_Address_2,
a.State_Code,
a.Provider_Type,
a.Num_of_Services,
a.Num_of_Medicare_Beneficiaries,
a.Total_Medicare_Payment_Amt,
a.Average_Age_of_Beneficiaries,
a.Medical_school_name,
a.Graduation_year,
a.Primary_specialty,
a.Organization_legal_name,
a.Accepts_Medicare,
a.City_Name,
a.Population_est,
a.Years_in_Practice,
a.Full_Name,
b.sum_daycount_5_opioids,
b.pct_daycount_5_opioids,
b.sum_daycount_5_nonopioids,
b.pct_daycount_5_nonopioids,
b.sum_daycount_5_opioids/a.Num_of_Medicare_Beneficiaries as opiod_daycount_per_bene 
from work.Physician_Full a inner join _scriptcountupdated b
ON A.NPI=B.NPI
WHERE a.Years_in_Practice <100;
quit;
Proc Contents data=w3.nc_opioid_analysis; 
run;
Proc SQL;
Drop table W3.Physician_Full, W3.PhysicianMaster, W3.PScript_O,_ScriptCount,PScript;
quit;
Proc Print data=w3.nc_opioid_analysis;
var NPI Full_Name Credentials;
where Credentials is null;
run;
proc sql;
update w3.nc_opioid_analysis
Set Credentials="N/A"
where Credentials is NULL;
quit;
proc freq data=W3.NC_Opioid_Analysis;
Tables Credentials/Out=w3.credentials_after;
run;
proc sql;
alter table w3.nc_opioid_analysis
ADD Cred_Flag num (1);
quit;
Proc SQL;
	update w3.nc_opioid_analysis
	Set Cred_Flag=0 where Credentials eq "N/A"; 
QUIT;
Proc SQL;
	update w3.nc_opioid_analysis
	Set Cred_Flag=1 where Credentials not eq "N/A"; 
QUIT;
proc freq data=W3.NC_Opioid_Analysis;
Tables Cred_Flag sum_daycount_5_opioids pct_daycount_5_opioids sum_daycount_5_nonopioids pct_daycount_5_nonopioids sum_daycount_5_opioids opiod_daycount_per_bene /Out=w3.proc_print_after;
run;
Proc Contents data=w3.nc_opioid_analysis; 
run;
proc corr data=W3.NC_Opioid_Analysis;
var sum_daycount_5_opioids pct_daycount_5_opioids sum_daycount_5_nonopioids pct_daycount_5_nonopioids sum_daycount_5_opioids opiod_daycount_per_bene /Out=w3.proc_print_after;
run;
Proc SQL;
Create table W3.RES1 as select
Primary_Specialty, sum(sum_daycount_5_opioids) as Total_Opioid_Day_Counts, count (NPI) as Total_Doctors
from w3.nc_opioid_analysis
Group by Primary_Specialty;
run;
Proc Rank data=W3.RES1 groups=5 out=W3.RES1_rank descending;
	var Total_Opioid_Day_Counts;
	ranks SpecialtyOpioidRank;
run;
Proc SQL;
Create table work.NC_Ranks as select
A.*, B.SpecialtyOpioidRank
from w3.nc_opioid_analysis a left join W3.RES1_rank b
on a.Primary_Specialty=b.Primary_Specialty;
run;
proc sql;
alter table NC_Ranks
Add specialty_1 num(1), specialty_2 num(1), specialty_3 num(1),specialty_4 num(1), specialty_5 num(1);
quit;
proc sql;
update NC_Ranks
Set specialty_1=1 where SpecialtyOpioidRank eq 0;
quit;
proc sql;
update NC_Ranks
Set specialty_1=0 where SpecialtyOpioidRank not eq 0;
quit;
proc sql;
update NC_Ranks
Set specialty_2=1 where SpecialtyOpioidRank eq 1;
quit;
proc sql;
update NC_Ranks
Set specialty_2=0 where SpecialtyOpioidRank not eq 1;
quit;
proc sql;
update NC_Ranks
Set specialty_3=1 where SpecialtyOpioidRank eq 2;
quit;
proc sql;
update NC_Ranks
Set specialty_3=0 where SpecialtyOpioidRank not eq 2;
quit;
proc sql;
update NC_Ranks
Set specialty_4=1 where SpecialtyOpioidRank eq 3;
quit;
proc sql;
update NC_Ranks
Set specialty_4=0 where SpecialtyOpioidRank not eq 3;
quit;
proc sql;
update NC_Ranks
Set specialty_5=1 where SpecialtyOpioidRank eq 4;
quit;
proc sql;
update NC_Ranks
Set specialty_5=0 where SpecialtyOpioidRank not eq 4;
quit; 
Proc SQL;
Drop table W3.Opioid_Analysis;
quit;
Proc SQL;
Create table W3.NC_Opioid_Analysis as select
*
from NC_Ranks;
quit;
proc freq data=W3.NC_Opioid_Analysis;
Tables Cred_Flag Specialty_1 Specialty_2 Specialty_3 Specialty_4 Specialty_5/Out=w3.SpecialtyFlagsFreq;
title "Specialty Flags Frquency, where Specialty1 is largest bin";
quit; 
PROC STDIZE 
data= W3.NC_Opioid_Analysis 
out	= W3.NC_Opioid_Analysis_STDZE 
outstat = _STDZSTATS 
method	= STD;
var sum_daycount_5_opioids pct_daycount_5_opioids sum_daycount_5_nonopioids pct_daycount_5_nonopioids opiod_daycount_per_bene;
title1 'Standardize using STD ~ MEAN 0, STDEV 1'
run;
proc univariate data=W3.NC_Opioid_Analysis nextrval=5;
var sum_daycount_5_opioids pct_daycount_5_opioids sum_daycount_5_nonopioids pct_daycount_5_nonopioids opiod_daycount_per_bene
;
	histogram;
run;
/*All Variables, Ranked*/
PROC RANK data=W3.NC_Opioid_Analysis out=W3.NC_OPIOID_RANK descending;
var sum_daycount_5_opioids pct_daycount_5_opioids sum_daycount_5_nonopioids pct_daycount_5_nonopioids opiod_daycount_per_bene;
ranks sum_opioids_rank pct_opioids_rank sum_nonopioids_rank pct_nonopioids_rank per_beneficiary_rank;
run; 
/*Count of Opiates, Sorted,Ranked, and Plotted*/
PROC sort data=W3.NC_OPIOID_RANK out=work.DRopioidrank;
by descending sum_opioids_rank;
run; 
proc print data=work.DRopioidrank;
var NPI Full_Name Credentials Primary_Specialty Years_in_Practice city_name sum_daycount_5_opioids;
run;
/*Count of Non Opiates, Sorted,Ranked, and Plotted*/
PROC sort data=W3.NC_OPIOID_RANK out=work.DRnonopioidrank;
by descending per_beneficiary_rank;
run; 
proc print data=work.DRnonopioidrank;
var NPI Full_Name Credentials Primary_Specialty Years_in_Practice city_name sum_daycount_5_nonopioids;
run; 
/*Beneficiary Ratio, Sorted,Ranked, and Plotted*/
PROC sort data=W3.NC_OPIOID_RANK out=work.DRperbeneficiaryrank;
by descending opiod_daycount_per_bene;
run; 
proc print data=work.DRperbeneficiaryrank;
var NPI Full_Name Credentials Primary_Specialty Years_in_Practice city_name opiod_daycount_per_bene;
run; 
/*Opiate Ratio, Sorted,Ranked, and Plotted*/
PROC sort data=W3.NC_OPIOID_RANK out=work.DRpercentopiaterank;
by descending pct_opioids_rank;
run; 
proc print data=work.DRpercentopiaterank;
var NPI Full_Name Credentials Primary_Specialty Years_in_Practice city_name pct_daycount_5_opioids;
run;
/*Non-Opiate Ratio, Sorted,Ranked, and Plotted*/
PROC sort data=W3.NC_OPIOID_RANK out=work.DRpercentnonopiaterank;
by descending pct_nonopioids_rank;
run; 
proc print data=work.DRpercentopiaterank;
var NPI Full_Name Credentials Primary_Specialty Years_in_Practice city_name pct_daycount_5_nonopioids;
run; 
PROC TABULATE data=w3.nc_opioid_analysis out=w3.outcrosstab;
CLASS gender graduation_year;
VAR NPI;
TABLE graduation_year*gender ,
 NPI * (N) ;
RUN; 
proc sgplot data=w3.outcrosstab;
	hbar graduation_year / response= NPI_N group=gender nostatlabel;
	yaxis grid;
	Title "New Doctors by Graduation Year";
run;
proc means data=W3.NC_Opioid_Analysis_STDZE;
	var sum_daycount_5_opioids pct_daycount_5_opioids sum_daycount_5_nonopioids pct_daycount_5_nonopioids opiod_daycount_per_bene;
run;
proc fastclus data=W3.NC_Opioid_Analysis_STDZE 
			out=clus_opioids_5
			outstat=_clusopioids_5
			maxiter=100
			impute
			maxc=5;
		var average_age_of_beneficiaries sum_daycount_5_opioids	sum_daycount_5_nonopioids;
run;
proc sgplot data=clus_opioids_5 (OBS=1000);
	scatter x =cluster y=average_age_of_beneficiaries;
	Title "Ages of Beneficiaries--5 Clusters";
run;
proc sgplot data=clus_opioids_5 (OBS=1000);
	scatter x = cluster y=sum_daycount_5_opioids;
	Title "Day Counts of Opioids-- Clusters";
run;
proc sgplot data=clus_opioids_5 (OBS=1000);
	scatter x = cluster y=sum_daycount_5_nonopioids;
	Title "Day Counts of Non-Opioids--5 Clusters";
run;
proc fastclus data=W3.NC_Opioid_Analysis_STDZE 
			out=clus_opioids_10 
			outstat=_clusopioids_10
			maxiter=100
			impute
			maxc=10;
		var average_age_of_beneficiaries sum_daycount_5_opioids	sum_daycount_5_nonopioids;
run;  
proc sgplot data=clus_opioids_10 (OBS=1000);
	scatter x = cluster y=average_age_of_beneficiaries;
	Title "Ages of Beneficiaries-10 Clusters";
run;
proc sgplot data=clus_opioids_10 (OBS=1000);
	scatter x = cluster y=sum_daycount_5_opioids;
	Title "Day Counts of Opioids--10 Clusters";
run;
proc sgplot data=clus_opioids_10 (OBS=1000);
	scatter x = cluster y=sum_daycount_5_nonopioids;
	Title "Day Counts of Non-Opioids--10 Clusters";
run;