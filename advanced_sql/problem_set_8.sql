/*Find job postings from first quartern tht has a salary greater than $70k.
    -Combine jon posting tables from the first quarter of 2023 (Jan-Mar).
    -Gets job postings with an averge yearly salary > $70, 000. */


-- Combining all three table to create a new table called Q1 job postings. 
SELECT 
        job_title_short,
        job_location,
        job_via,
        job_posted_date::date,
        salary_year_avg
FROM (
SELECT *
FROM january_job

UNION ALL 

SELECT *
FROM february_job

UNION ALL

SELECT *
FROM march_job
) AS Q1_job_postings

WHERE
     Q1_job_postings.salary_year_avg >70000 AND Q1_job_postings.job_title_short = 'Data Analyst'
ORDER BY 
    Q1_job_postings.salary_year_avg DESC;