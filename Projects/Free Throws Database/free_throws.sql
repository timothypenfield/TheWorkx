select * from free_throws
/*PLAYER LEVEL OVERALL FT Percent Stats*/
select season,sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent from free_throws group by season
select player,sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent from free_throws group by player having count(shot_made)>100 order by FT_Percent desc
select player,season, sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent from free_throws group by player,season having count(shot_made)>100 order by FT_Percent desc
/*GAME LEVEL Stats*/
select period,sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent from free_throws group by period
select period,sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent from free_throws group by period order by FTA desc
select period,sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent from free_throws group by period order by FT_Percent desc
select playoffs,count(distinct game_id), sum(shot_made) as FT_Made, count(shot_made) as FTA, sum(shot_made)/count(shot_made) as FT_Percent, sum(shot_made)/count(distinct game_id) as FTM_per_Game, count(shot_made)/count(distinct game_id) as FTA_per_Game from free_throws group by playoffs order by FT_Percent desc
 