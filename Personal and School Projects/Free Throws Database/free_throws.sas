libname FT 'C:\Users\timot\Dropbox\Educational\MSBA\Independent\Sports Data Sets';
options mprint;
%MACRO csvImport(csv=);
	FILENAME REFFILE %tslit("C:\Users\timot\Dropbox\Educational\MSBA\Independent\Sports Data Sets\&csv..csv");
	PROC IMPORT DATAFILE=REFFILE
		DBMS=CSV
		OUT=&csv;
		GETNAMES=YES;
		guessingrows=250;
	RUN;
%MEND;
%csvImport(csv=free_throws);
proc contents data=work.free_throws;
run;
proc print data=work.free_throws (OBS=10);
run;
proc sql;
create table FT.free_throws_updated as 
select season,game_id,end_result, period,time format=Time6.,player,playoffs,scan(score,1) as TeamOneScore,scan(score,2) as TeamTwoScore,shot_made
from work.free_throws;
run;
proc sql;
alter table FT.free_throws_updated
ADD time_remaining_qtr num (3)format=MMSS5., CloseGame num (1),pressure num (1), TeamOneScore_t num(3) format=BEST12., TeamTwoScore_t num (3) format=BEST12.;
quit;
proc print data=FT.free_throws_updated(OBS=10);
run;
proc sql;
update FT.free_throws_updated 
set time_remaining_qtr=time, TeamOneScore_t = input(TeamOneScore, 8.),TeamTwoScore_t = input(TeamTwoScore, 8.); 
run;
proc sql;
update FT.free_throws_updated 
set CloseGame = 1 where abs(TeamTwoScore_t-TeamOneScore_t) <5;
run;
proc print data=FT.free_throws_updated(OBS=100);
run;
proc sql;
update FT.free_throws_updated
set CloseGame =0 where closegame is NULL;
run;
proc corr data=FT.free_throws_updated;
var shot_made,period, playoff, closegame,time_remaining_qtr; 
run;
proc print data=FT.free_throws_updated(OBS=100);
run;
proc sql;
create table ft.player_percent as select 
player, 
sum(shot_made) as FT_Made, 
count(shot_made) as FTA, 
sum(shot_made)/count(shot_made) as FT_Percent
from ft.free_throws_updated group by player,season having count(shot_made)>100;
run; 
proc sort data=ft.player_percent;
by descending FT_Percent; 
run;
proc print data=ft.player_percent;
run;

/*
issues that remain in coding:
--have to manually run SQL statements; broken out to validate; help consolidating would be great.
--join on season AND player not working--could just bulk the player for all years, but would rather have season by season)
--when PersonalSeasonFT is null (FTA<100), use average. "summary statement not allowed"?
--pressure flag formats time_remaining_qtr_seconds incorrectly
--time and time_remaining_qtr_seconds formatting help */

proc sql; 
Create Table FT.free_throws_final as select
a.season,a.playoffs,a.game_id,a.period,a.time,a.time_remaining_qtr as time_remaining_qtr_seconds,a.CloseGame,a.TeamOneScore_t,a.TeamTwoScore_t,a.player,a.pressure,b.FT_Percent as PersonalSeasonFT,a.shot_made
from FT.free_throws_updated a left join ft.player_percent b 
on (a.player=b.player and a.season=b.season);
run;

proc print data=FT.free_throws_final (OBS=100);
where PersonalMultiSeasonFT is null; 
run;
proc sql;
update FT.free_throws_final
set PersonalSeasonFT =sum(shot_made)/count(shot_made)where PersonalSeasonFT is null;
run;
proc print data=FT.free_throws_final (OBS=100);
where PersonalMultiSeasonFT is null; 
run;
proc print data=FT.free_throws_final(OBS=500);
run;
data FT.free_throws_final;
modify FT.free_throws_final;
IF (time_remaining_qtr_seconds =<120 AND period >=4 AND closegame=1) THEN pressure = 1;
else pressure=0;
run;
proc print data=FT.free_throws_final(OBS=100);
where pressure=1 and time_remaining_qtr_seconds>10;
run;
proc re



