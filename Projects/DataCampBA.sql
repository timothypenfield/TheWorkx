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