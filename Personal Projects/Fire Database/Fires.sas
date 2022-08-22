libname alldata 'C:\Users\timot\Dropbox\Educational\MSBA\BAN7095 Serenova Practicum\Wildfires';
options mprint;
%MACRO csvImport(csv=);	
	FILENAME REFFILE %tslit("C:\Users\timot\Dropbox\Educational\MSBA\BAN7095 Serenova Practicum\Wildfires\&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv(rename=adj_close=&csv) replace;
		GETNAMES=YES;
		guessingrows=10000000;
	RUN;
%MEND;
%csvImport(csv=FireData_Clean);
proc contents data = work.FireData_Clean;
run;
proc print data=work.FireData_Clean (obs=10);
run;
proc corr data=work.FireData_Clean;
run;
proc arima data = work.FireData_Clean plots(only) = (series (corr) residual (corr normal));
  identify var = TotalFires;
  estimate p=(1,4) method=ML ;
run ;
quit ;

proc arima data = work.FireData_Clean plots(only) = (series (corr) residual (corr normal));
  identify var = G_Count;
  estimate p=(1) q=(3) method=ML ;
run ;
quit ;
