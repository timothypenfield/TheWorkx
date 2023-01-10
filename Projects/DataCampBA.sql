-- Select the count of the number of rows
SELECT count(*)
from fortune500;

SELECT count(*) - count(ticker) AS missing
  FROM fortune500;

select count(*) - count(profits_change) as missing
from fortune500

select count(*) - count(industry) as missing
from fortune500

SELECT company.name
-- Table(s) to select from
  FROM company
  inner join fortune500 
  using(ticker);

-- Count the number of tags with each type
SELECT type, count(id) AS count
  FROM tag_type
 -- To get the count for each type, what do you need to do?
 group by type
 -- Order the results with the most common
 -- tag types listed first
 order by count desc ;

 -- Select the 3 columns desired
SELECT company.name, tag_type.tag, tag_type.type
  FROM company
  	   -- Join to the tag_company table
       inner JOIN tag_company 
       ON company.id = tag_company.company_id
       -- Join to the tag_type table
       inner JOIN tag_type
       ON tag_company.tag = tag_type.tag
  -- Filter to most common type
  WHERE type='cloud';

-- Use coalesce
SELECT coalesce(industry, NULL, 'Unknown') AS industry2,
       -- Don't forget to count!
       count(name) 
  FROM fortune500 
-- Group by what? (What are you counting by?)
 GROUP BY industry2
-- Order results to see most common first
order by count(industry) desc
-- Limit results to get just the one value you want
 limit 1;

 SELECT company_original.name, title, rank
  -- Start with original company information
  FROM company AS company_original
       -- Join to another copy of company with parent
       -- company information
	   LEFT JOIN company AS company_parent
       ON company_original.parent_id = company_parent.id 
       -- Join to fortune500, only keep rows that match
       INNER JOIN fortune500 
       -- Use parent ticker if there is one, 
       -- otherwise original ticker
       ON coalesce(company_parent.ticker, 
                   company_original.ticker) = 
             fortune500.ticker
 -- For clarity, order by rank
 ORDER BY rank; 

 -- Select the original value
SELECT profits_change, 
	   -- Cast profits_change
       CAST(profits_change as integer) AS profits_change_int
  FROM fortune500;

  SELECT '3.2'::numeric,
       '-123'::numeric,
       '1e3'::numeric,
       '1e-3'::numeric,
       '02314'::numeric,
       '0002'::numeric;

       -- Select the count of each revenues_change integer value
SELECT revenues_change::integer, count(*) 
  FROM fortune500
 GROUP BY revenues_change::integer 
 -- order by the values of revenues_change
 ORDER BY revenues_change;

 -- Select average revenue per employee by sector
SELECT sector, 
       avg(revenues/employees::numeric) AS avg_rev_employee
  FROM fortune500
 GROUP BY sector
 -- Use the column alias to order the results
 ORDER BY avg_rev_employee desc;

 -- Divide unanswered_count by question_count
SELECT unanswered_count/question_count::numeric AS computed_pct, 
       -- What are you comparing the above quantity to?
       unanswered_pct
  FROM stackoverflow
 -- Select rows where question_count is not 0
 WHERE question_count > 0
limit 10;

-- Select min, avg, max, and stddev of fortune500 profits
SELECT min(profits),
       avg(profits),
       max(profits),
       stddev(profits)
  FROM fortune500;

  SELECT trunc(employees,-5) AS employee_bin, count(employees)
       -- Count number of companies with each truncated value
       ___
  FROM fortune500
 -- Use alias to group
 GROUP BY employee_bin
 -- Use alias to order
 ORDER BY employee_bin;

 -- Bins created in Step 2
WITH bins AS (
      SELECT generate_series(2200, 3050, 50) AS lower,
             generate_series(2250, 3100, 50) AS upper),
     -- Subset stackoverflow to just tag dropbox (Step 1)
     dropbox AS (
      SELECT question_count 
        FROM stackoverflow
       WHERE tag='dropbox') 
-- Select columns for result
-- What column are you counting to summarize?
SELECT lower, upper, count(question_count) 
  FROM bins  -- Created above
       -- Join to dropbox (created above), 
       -- keeping all rows from the bins table in the join
       LEFT JOIN dropbox
       -- Compare question_count to lower and upper
         ON question_count >= lower 
        AND question_count < upper
 -- Group by lower and upper to count values in each bin
 GROUP BY lower, upper
 -- Order by lower to put bins in order
 ORDER BY lower;


 -- Correlation between revenues and profit
SELECT corr(revenues,profits) AS rev_profits,
	   -- Correlation between revenues and assets
       corr(revenues,assets) AS rev_assets,
       -- Correlation between revenues and equity
       corr(revenues,equity) AS rev_equity 
  FROM fortune500;

  -- What groups are you computing statistics by?
SELECT sector,
       -- Select the mean of assets with the avg function
       avg(assets) AS mean,
       -- Select the median
       percentile_disc(.5) within group (order by assets) AS median
  FROM fortune500
 -- Computing statistics for each what?
 GROUP BY sector
 -- Order results by a value of interest
 ORDER BY mean;

 -- To clear table if it already exists;
-- fill in name of temp table
DROP TABLE IF EXISTS profit80;

-- Create the temporary table
create temp table profit80 AS 
  -- Select the two columns you need; alias as needed
  SELECT sector, 
  percentile_disc(.8) within group (order by profits) AS pct80
    -- What table are you getting the data from?
from fortune500   
-- What do you need to group by?
   group by sector ;
   
-- See what you created: select all columns and rows 
-- from the table you created
SELECT * 
  FROM profit80;

  -- Code from previous step
DROP TABLE IF EXISTS profit80;

CREATE TEMP TABLE profit80 AS
  SELECT sector, 
         percentile_disc(0.8) WITHIN GROUP (ORDER BY profits) AS pct80
    FROM fortune500 
   GROUP BY sector;

-- Select columns, aliasing as needed
SELECT f.title, f.sector,f.profits, 
       f.profits/p.pct80 AS ratio
-- What tables do you need to join?  
  FROM fortune500 f
       LEFT JOIN profit80 p
-- How are the tables joined?
       ON f.sector=p.sector
-- What rows do you want to select?
 WHERE f.profits> p.pct80;

 -- To clear table if it already exists
DROP TABLE IF EXISTS startdates;

CREATE TEMP TABLE startdates AS
SELECT tag, min(date) AS mindate
  FROM stackoverflow
 GROUP BY tag;
 
-- Select tag (Remember the table name!) and mindate
SELECT startdates.tag, 
       mindate, 
       -- Select question count on the min and max days
	   so_min.question_count AS min_date_question_count,
       so_max.question_count AS max_date_question_count,
       -- Compute the change in question_count (max- min)
       so_max.question_count - so_min.question_count AS change
  FROM startdates
       -- Join startdates to stackoverflow with alias so_min
       INNER JOIN stackoverflow AS so_min
          -- What needs to match between tables?
          ON startdates.tag = so_min.tag
         AND startdates.mindate = so_min.date
       -- Join to stackoverflow again with alias so_max
       INNER JOIN stackoverflow AS so_max
          -- Again, what needs to match between tables?
          ON startdates.tag = so_max.tag
         AND so_max.date = '2018-09-25';

         DROP TABLE IF EXISTS correlations;

CREATE TEMP TABLE correlations AS
SELECT 'profits'::varchar AS measure,
       corr(profits, profits) AS profits,
       corr(profits, profits_change) AS profits_change,
       corr(profits, revenues_change) AS revenues_change
  FROM fortune500;

-- Add a row for profits_change
-- Insert into what table?
INSERT INTO correlations
-- Follow the pattern of the select statement above
-- Using profits_change instead of profits
SELECT 'profits_change'::varchar AS measure,
       corr(profits_change, profits) AS profits,
       corr(profits_change, profits_change) AS profits_change,
       corr(profits_change, revenues_change) AS revenues_change
  FROM fortune500;

-- Repeat the above, but for revenues_change
INSERT INTO correlations
SELECT 'revenues_change'::varchar AS measure,
       corr(revenues_change, profits) AS profits,
       corr(revenues_change, profits_change) AS profits_change,
       corr(revenues_change, revenues_change) AS revenues_change
  FROM fortune500;