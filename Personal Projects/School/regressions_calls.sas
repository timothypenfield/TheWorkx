libname alldata 'C:/Users/timot/Dropbox/Educational/MSBA/BAN7070 Time Series Forecasting/Final Time Series Project';

%MACRO csvImport(csv=);
	FILENAME REFFILE %tslit("C:/Users/timot/Dropbox/Educational/MSBA/BAN7070 Time Series Forecasting/Final Time Series Project/&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv;
		GETNAMES=YES;
		guessingrows=1000;
	RUN;
%MEND;
%csvImport(csv=calls);
proc contents data=work.calls;
run;
proc reg data=work.calls
         outest=work.EstFullModel;
   model Minutes=Tickets Hours ScriptTix / 
             vif ;
run;

proc reg data=work.calls
         outest=work.EstFullModel;
   model Minutes= ScriptTix / 
             vif ;
run;
proc reg data=work.calls
         outest=work.EstFullModel;
   model Minutes= Tickets / 
             vif ;
run;

proc arima data = work.calls Plots=(series(corr crosscorr) forecast(forecast forecastonly));
  identify var = Minutes crosscor=ScriptTix;
  estimate p=1 q=2 input=(ScriptTix) method=ml ;

  forecast lead=4 ;
run ;
