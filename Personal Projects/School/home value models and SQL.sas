libname Home '/folders/myshortcuts/BAN7002/Week_7/Data';
options mprint;
%MACRO csvImport(csv=);
	
	FILENAME REFFILE %tslit("/folders/myshortcuts/BAN7002/Week_7/Data/&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv;
		GETNAMES=YES;
		guessingrows=250;
	RUN;	
%MEND;
%csvImport(csv=predict);
%csvImport(csv=training);
%csvImport(csv=validate);
%csvImport(csv=zips);
proc sql;
create table predict_zips as select
a.*, b.city_state, b.population, b.pop_density, b.median_income
from predict a inner join zips b
on a.zipcode=b.zip;
quit;
proc sql;
create table training_zips as select
a.*, b.city_state, b.population, b.pop_density, b.median_income
from training a inner join zips b
on a.zipcode=b.zip;
quit;
proc sql;
create table validate_zips as select
a.*, b.city_state, b.population, b.pop_density, b.median_income
from validate a inner join zips b
on a.zipcode=b.zip;
quit;
data Home.FullData;
set
    predict_zips
    training_zips
    validate_zips;
run;
proc means data=Home.FullData
	N NMISS MEAN Q1 Q3 MEDIAN MIN MAX; 
	var _numeric_ ;
	OUTPUT OUT=work.fulldata_freq;
	Title1 'All Data Descriptive Stats: Initial';
run;
proc means data=Training_zips
	N NMISS MEAN Q1 Q3 MEDIAN MIN MAX; 
	var _numeric_ ;
	OUTPUT OUT=work.fulldata_freq;
	Title1 'Training Subset Descriptive Stats: Initial';
run;
proc freq data=Home.FullData;
Table YR_REMOD/Out=FullDataREMOD_Freq;
run; 
proc fastclus data=Home.FullData out=YrBuilt_Clustered
maxclusters=10;
var Yr_Built;
run;
proc fastclus data=Training_zips out=Training_Clustered
maxclusters=5;
var AV_Total;
run;
Proc SQL;
Create table Training_Averages_Clustered as 
select cluster,mean (AV_TOTAL) as AVE_HomePrice, mean (living_area) as SQ_FT, mean(LAND_SF) as LOT_SIZE, mean(R_BDRMs) as Average_Bed, mean (R_Full_BTH) as Average_Bath, mean (R_TOTAL_RMs) as Total_Rooms
from work.Training_Clustered
Group by cluster;
quit;
proc print data=Training_Averages_Clustered;
title1 "Clusters of Homes in these Areas";
run;
Proc SQL;
Create table Overall_Condition_Analysis as 
select count(R_INT_CND) as Average_Total
from work.Training_Clustered
where R_Ovrall_CND eq "A" and (R_INT_CND eq "G" or R_EXT_CND eq "G" or R_INT_CND eq "E" or R_EXT_CND eq "E");
quit;

proc freq data=Home.FullData;
Table R_OVRALL_CND/Out=FullOverallCND_Freq;
run;
proc freq data=Home.FullData;
Table R_INT_CND/Out=FullINTCND_Freq;
run;
proc freq data=Home.FullData;
Table R_EXT_CND/Out=FullEXTCND_Freq;
run;
proc freq data=Home.FullData;
Table R_VIEW/Out=FullRVIEW_Freq;
run;
proc freq data=Home.FullData;
Table R_KITCH_STYLE/Out=R_KITCH_STYLE_Freq;
run;
proc freq data=Home.FullData;
Table R_BTH_STYLE/Out=R_BTH_STYLE_Freq;
run;
proc freq data=Home.FullData;
Table R_INT_FIN/Out=R_INT_FIN_Freq;
run;
proc freq data=Home.FullData;
Table R_AC/Out=R_AC_Freq;
run;
proc freq data=Home.FullData;
Table R_HEAT_TYP/Out=R_HEAT_TYP_Freq;
run;
proc freq data=Home.FullData;
Table R_BLDG_STYL/Out=R_BLDG_STYL_Freq;
run;
proc print data=FullDataREMOD_Freq;
title1 "Full Data: Year of Remodel, Initial";
run;
proc sgplot data=YrBuilt_Clustered;
	histogram Yr_Built;
	Title 'Training Data: Year of Home Build';
run;
proc sgplot data=YrBuilt_Clustered (OBS=1000);
	scatter x = Cluster y=Yr_Built;
	Title 'Full Data: Year of Home Build';
run; 
proc print data=FullOverallCND_Freq;
title1 "Full Data: Overall Condition, Initial";
run; 
proc print data=FullINTCND_Freq;
title1 "Full Data: Interior Condition, Initial";
run; 
proc print data=FullEXTCND_Freq;
title1 "Full Data: Exterior Condition, Initial";
run; 
proc print data=FullRVIEW_Freq;
title1 "Full Data: Residential View, Initial";
run; 
proc print data=R_KITCH_STYLE_Freq;
title1 "Full Data: Kitchen Style, Initial";
run; 
proc print data=R_BTH_STYLE_Freq;
title1 "Full Data: Bathroom Style, Initial";
run; 
proc print data=R_INT_FIN_Freq;
title1 "Full Data: Interior Finish Style, Initial";
run; 
proc print data=R_AC_Freq;
title1 "Full Data: Type of AC, Initial Review";
run;
proc print data=R_HEAT_TYP_Freq;
title1 "Full Data: Type of Heat, Initial Review";
proc freq data=training_zips;
Table R_BLDG_STYL/Out=R_BLDG_STYL_Freqtrain;
run;
proc print data=R_BLDG_STYL_Freqtrain;
title1 "Predict Data: TypeBuilding, Initial Review";
run;
data predict_zips_flags;
set predict_zips;
IF YR_REMOD = "" THEN Remodel_Flag = 0;
ELSE IF YR_REMOD >= 2010 THEN Remodel_Flag = 2;
ELSE IF YR_REMOD < 2010 and YR_REMOD >= 2000 THEN Remodel_Flag = 1;
ELSE IF YR_REMOD < 2000 THEN Remodel_Flag = 0;

IF YR_BUILT =< 1900 and YR_BUILT >=1800  THEN Built_Flag = 0;
ELSE IF YR_BUILT > 1900 and YR_BUILT=<1950 THEN Built_Flag = 1;
ELSE IF YR_BUILT < 1800 THEN Built_Flag = 1;
ELSE IF YR_BUILT > 1950 and YR_BUILT=<1985 THEN Built_Flag = 2;
ELSE IF YR_BUILT > 1985 and YR_BUILT=<2000 THEN Built_Flag = 3;
ELSE IF YR_BUILT > 2000 and YR_BUILT=<2020 THEN Built_Flag = 4;

IF OWN_OCC eq "Y" THEN OWN_Flag = 1;
ELSE IF OWN_OCC eq "N" THEN OWN_Flag = 0;

IF R_OVRALL_CND eq "G" OR "E" THEN OverallCond_Flag = 1;
ELSE IF R_OVRALL_CND eq "P" THEN OverallCond_Flag = -1;
ELSE IF R_OVRALL_CND not eq "G" OR "E" OR "P"  THEN OverallCond_Flag = 0;

IF R_VIEW eq "G" OR "E" THEN R_VIEW_FLAG = 1;
ELSE IF R_VIEW eq "P" THEN R_VIEW_FLAG = -1;
ELSE IF R_VIEW not eq "G" OR "E" OR "P"  THEN R_VIEW_FLAG = 0;

IF R_KITCH_STYLE eq "L" OR "M" THEN KitchStyle_Flag = 1;
ELSE IF R_KITCH_STYLE not eq "L" OR "M" THEN KitchStyle_Flag = 0;

IF R_BTH_STYLE eq "L" OR "M" THEN BthStyle_Flag = 1;
ELSE IF R_BTH_STYLE not eq "L" OR "M" THEN BthStyle_Flag = 0;

IF R_AC eq "C" OR "D" THEN AC_Flag = 1;
ELSE IF R_AC not eq "C" OR "D" THEN AC_Flag = 0;

IF R_BLDG_STYL eq "BW" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "BW" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CN" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CP" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CV" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "DK" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "RN" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "RR" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "SL" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "VT" THEN BuildingType_Flag = 1;
run;

proc sql;
update predict_zips_flags
set BuildingType_Flag = 0
where BuildingType_Flag not eq 1;
quit;


data training_zips_flags;
set training_zips;
IF YR_REMOD = "" THEN Remodel_Flag = 0;
ELSE IF YR_REMOD >= 2010 THEN Remodel_Flag = 2;
ELSE IF YR_REMOD < 2010 and YR_REMOD >= 2000 THEN Remodel_Flag = 1;
ELSE IF YR_REMOD < 2000 THEN Remodel_Flag = 0;

IF YR_BUILT =< 1900 and YR_BUILT >=1800  THEN Built_Flag = 0;
ELSE IF YR_BUILT > 1900 and YR_BUILT=<1950 THEN Built_Flag = 1;
ELSE IF YR_BUILT < 1800 THEN Built_Flag = 1;
ELSE IF YR_BUILT > 1950 and YR_BUILT=<1985 THEN Built_Flag = 2;
ELSE IF YR_BUILT > 1985 and YR_BUILT=<2000 THEN Built_Flag = 3;
ELSE IF YR_BUILT > 2000 and YR_BUILT=<2020 THEN Built_Flag = 4;

IF OWN_OCC eq "Y" THEN OWN_Flag = 1;
IF R_OVRALL_CND eq "G" OR "E" THEN OverallCond_Flag = 1;
ELSE IF R_OVRALL_CND eq "P" THEN OverallCond_Flag = -1;
ELSE IF R_OVRALL_CND not eq "G" OR "E" OR "P"  THEN OverallCond_Flag = 0;

IF R_VIEW eq "G" OR "E" THEN R_VIEW_FLAG = 1;
ELSE IF R_VIEW eq "P" THEN R_VIEW_FLAG = -1;
ELSE IF R_VIEW not eq "G" OR "E" OR "P"  THEN R_VIEW_FLAG = 0;

IF R_KITCH_STYLE eq "L" OR "M" THEN KitchStyle_Flag = 1;
ELSE IF R_KITCH_STYLE not eq "L" OR "M" THEN KitchStyle_Flag = 0;

IF R_BTH_STYLE eq "L" OR "M" THEN BthStyle_Flag = 1;
ELSE IF R_BTH_STYLE not eq "L" OR "M" THEN BthStyle_Flag = 0;

IF R_AC eq "C" OR "D" THEN AC_Flag = 1;
ELSE IF R_AC not eq "C" OR "D" THEN AC_Flag = 0;

IF R_BLDG_STYL eq "BW" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "BW" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CN" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CP" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CV" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "DK" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "RN" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "RR" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "SL" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "VT" THEN BuildingType_Flag = 1;
run;

proc sql;
update training_zips_flags
set BuildingType_Flag = 0
where BuildingType_Flag not eq 1;
quit;

Proc SQL;
Create table Clustered_Remod as 
select Remodel_Flag, count(Remodel_Flag) as Number_of_Homes mean (AV_TOTAL) as AVE_HomePrice, mean (living_area) as SQ_FT, mean(LAND_SF) as LOT_SIZE, mean(R_BDRMs) as Average_Bed, mean (R_Full_BTH) as Average_Bath, mean (R_TOTAL_RMs) as Total_Rooms
from training_zips_flags
Group by Remodel_Flag;
quit;

proc print data= Clustered_Remod;
title1 "Homes Prices,by Remodeled Status";
run;

data validate_zips_flags;
set validate_zips;
IF YR_REMOD = "" THEN Remodel_Flag = 0;
ELSE IF YR_REMOD >= 2010 THEN Remodel_Flag = 2;
ELSE IF YR_REMOD < 2010 and YR_REMOD >= 2000 THEN Remodel_Flag = 1;
ELSE IF YR_REMOD < 2000 THEN Remodel_Flag = 0;

IF YR_BUILT =< 1900 and YR_BUILT >=1800  THEN Built_Flag = 0;
ELSE IF YR_BUILT > 1900 and YR_BUILT=<1950 THEN Built_Flag = 1;
ELSE IF YR_BUILT < 1800 THEN Built_Flag = 1;
ELSE IF YR_BUILT > 1950 and YR_BUILT=<1985 THEN Built_Flag = 2;
ELSE IF YR_BUILT > 1985 and YR_BUILT=<2000 THEN Built_Flag = 3;
ELSE IF YR_BUILT > 2000 and YR_BUILT=<2020 THEN Built_Flag = 4;

IF OWN_OCC eq "Y" THEN OWN_Flag = 1;
ELSE IF OWN_OCC eq "N" THEN OWN_Flag = 0;

IF R_OVRALL_CND eq "G" OR "E" THEN OverallCond_Flag = 1;
ELSE IF R_OVRALL_CND eq "P" THEN OverallCond_Flag = -1;
ELSE IF R_OVRALL_CND not eq "G" OR "E" OR "P"  THEN OverallCond_Flag = 0;

IF R_VIEW eq "G" OR "E" THEN R_VIEW_FLAG = 1;
ELSE IF R_VIEW eq "P" THEN R_VIEW_FLAG = -1;
ELSE IF R_VIEW not eq "G" OR "E" OR "P"  THEN R_VIEW_FLAG = 0;

IF R_KITCH_STYLE eq "L" OR "M" THEN KitchStyle_Flag = 1;
ELSE IF R_KITCH_STYLE not eq "L" OR "M" THEN KitchStyle_Flag = 0;

IF R_BTH_STYLE eq "L" OR "M" THEN BthStyle_Flag = 1;
ELSE IF R_BTH_STYLE not eq "L" OR "M" THEN BthStyle_Flag = 0;

IF R_AC eq "C" OR "D" THEN AC_Flag = 1;
ELSE IF R_AC not eq "C" OR "D" THEN AC_Flag = 0;

IF R_BLDG_STYL eq "BW" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "BW" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CN" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CP" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "CV" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "DK" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "RN" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "RR" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "SL" THEN BuildingType_Flag = 1;
else IF R_BLDG_STYL eq "VT" THEN BuildingType_Flag = 1;
run;

proc sql;
update validate_zips_flags
set BuildingType_Flag = 0
where BuildingType_Flag not eq 1;
quit;

proc sgplot data=Training_zips_flags;
	histogram Remodel_Flag;
	Title 'Training Data: Remodel Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram Built_Flag;
	Title 'Training Data: Build Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram OWN_Flag;
	Title 'Training Data: Own Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram OverallCond_Flag;
	Title 'Training Data: Overall Home Condition Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram R_VIEW_FLAG;
	Title 'Training Data: Overall Home Vista Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram KitchStyle_Flag;
	Title 'Training Data: Kitchen Style Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram BthStyle_Flag;
	Title 'Training Data: Bathroom Style Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram AC_Flag;
	Title 'Training Data: AC Flag';
run;
proc sgplot data=Training_zips_flags;
	histogram BuildingType_Flag;
	Title 'Training Data: Building Type Flag';
run;
PROC STDIZE data=training_zips_flags
			out=training_zips_flags_sdt 
			OUTSTAT=training_zips_flags_stdz 
			method=STD;
var AV_TOTAL OverallCond_Flag KitchStyle_Flag R_VIEW_FLAG Built_Flag OWN_Flag Land_SF Living_Area Median_Income NUM_Floors Pop_Density Population R_BDRMS R_FPLACE R_FULL_BTH R_HALF_BTH R_KITCH R_TOTAL_RMS Remodel_Flag BthStyle_Flag AC_Flag BuildingType_Flag; 
run;
proc print data=training_zips_flags_sdt (OBS=20);
var AV_TOTAL OverallCond_Flag R_VIEW_FLAG Built_Flag OWN_Flag Land_SF Living_Area Median_Income NUM_Floors Pop_Density Population R_BDRMS R_FPLACE R_FULL_BTH R_HALF_BTH R_KITCH R_TOTAL_RMS Remodel_Flag BthStyle_Flag; 
title1 "Training Home Value Metrics STD";
run;
PROC STDIZE data=validate_zips_flags
			out=validate_zips_flags_sdt 
			OUTSTAT=validate_zips_flags_stdz 
			method=STD;
var AV_TOTAL OverallCond_Flag R_BDRMS KitchStyle_Flag R_VIEW_FLAG Built_Flag OWN_Flag Land_SF Living_Area Median_Income NUM_Floors Pop_Density Population R_BDRMS R_FPLACE R_FULL_BTH R_HALF_BTH R_KITCH R_TOTAL_RMS Remodel_Flag BthStyle_Flag AC_Flag BuildingType_Flag; 
run;
PROC STDIZE data=predict_zips_flags
			out=predict_zips_flags_sdt 
			OUTSTAT=predict_zips_flags_stdz 
			method=STD; 
var OverallCond_Flag R_BDRMS KitchStyle_Flag R_VIEW_FLAG Built_Flag OWN_Flag Land_SF Living_Area Median_Income NUM_Floors Pop_Density Population R_BDRMS R_FPLACE R_FULL_BTH R_HALF_BTH R_KITCH R_TOTAL_RMS Remodel_Flag BthStyle_Flag AC_Flag BuildingType_Flag; 
run;
proc reg data=training_zips_flags_sdt
	outest=Home.PriceModel1_Flags_Only;
	model AV_TOTAL = R_BDRMS OWN_Flag Built_Flag Land_SF Remodel_Flag BuildingType_Flag BthStyle_Flag KitchStyle_Flag AC_Flag OverallCond_Flag R_VIEW_FLAG / stb;
	code file='/folders/myshortcuts/BAN7002/Week_7/model1.sas';
run;
proc score data=training_zips_flags_sdt
score=Home.PriceModel1_Flags_Only
type=parms
out=training_score_model1_std;
var OWN_Flag R_BDRMS Built_Flag Land_SF Remodel_Flag BuildingType_Flag BthStyle_Flag KitchStyle_Flag AC_Flag OverallCond_Flag R_VIEW_FLAG;
run;
proc score data=validate_zips_flags_sdt
score=Home.PriceModel1_Flags_Only
type=parms
out=validate_score_model1_std;
var OWN_Flag Built_Flag R_BDRMS Land_SF Remodel_Flag BuildingType_Flag BthStyle_Flag KitchStyle_Flag AC_Flag OverallCond_Flag R_VIEW_FLAG;
run;
data scored_train_validate_model1;
set 
    training_score_model1_std
    validate_score_model1_std;
run;
proc reg data=training_zips_flags_sdt
	outest=Home.PriceModel2;
	model AV_TOTAL = Land_SF Living_Area Median_Income Population R_FPLACE R_FULL_BTH BthStyle_Flag OWN_Flag Built_Flag  Remodel_Flag BuildingType_Flag KitchStyle_Flag AC_Flag OverallCond_Flag R_VIEW_FLAG / stb;
	code file='/folders/myshortcuts/BAN7002/Week_7/model2.sas';
run;
proc score data=training_zips_flags_sdt
score=Home.PriceModel2
type=parms
out=training_score_model2_std;
var Land_SF Living_Area Median_Income Population R_FPLACE R_FULL_BTH OWN_Flag Built_Flag BthStyle_Flag Remodel_Flag BuildingType_Flag BthStyle_Flag KitchStyle_Flag AC_Flag OverallCond_Flag R_VIEW_FLAG;
run;
proc score data=validate_zips_flags_sdt
score=Home.PriceModel2
type=parms
out=validate_score_model2_std;
var Land_SF Living_Area Median_Income Population R_FPLACE R_FULL_BTH OWN_Flag Built_Flag BthStyle_Flag Remodel_Flag BuildingType_Flag BthStyle_Flag KitchStyle_Flag AC_Flag OverallCond_Flag R_VIEW_FLAG;
run;
data scored_train_validate_model2;
set 
    training_score_model2_std
    validate_score_model2_std;
run;
proc sql;
	create table Home.train_model1_compare as 
	select 
	mean((Model1 - AV_TOTAL)**2) as MSE,
	(mean((Model1 - AV_TOTAL)**2))**0.5 as RMSE
	from scored_train_validate_model1;
quit;

proc sql;
	create table Home.train_model2_compare as 
	select 
	mean((Model1 - AV_TOTAL)**2) as MSE,
	(mean((Model1 - AV_TOTAL)**2))**0.5 as RMSE
	from scored_train_validate_model2;
quit;
proc print data=Home.train_model1_compare;
title1 "Training/Validate Mean Residuals: Model 1";
run;
proc print data=Home.train_model2_compare;
title1 "Training/Validate Mean Residuals: Model 2";
run;