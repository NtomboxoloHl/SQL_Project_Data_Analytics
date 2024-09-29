/**What are the top-paying data scientist jobs?*
    -Identify the top 10 highest-paying data scientist roles in South Africa that are avilable remotely.
    -Focucses on job postings with specified salaries(remove NULLS).
    -Why? Highlight the top-paying opportunies for data scientist, offering insights
     into employment options and location flexibility.
 */

SELECT
         job_id,
        job_title,
        job_location,
        job_schedule_type,
        ROUND(salary_year_avg,2),
        job_posted_date,
        name AS company_name
FROM
        job_postings_fact
--Let's also find out the company name of these role, now we're gonna join company_dim with job_postings_facts.
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
        job_title_short = 'Data Scientist' AND
        job_country = 'South Africa' AND 
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10;