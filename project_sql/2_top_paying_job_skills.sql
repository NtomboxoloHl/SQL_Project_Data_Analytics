/*What skills are required for the top paying data scientist jobs?
    -Use the top 10 highest paying data scientist jobs in South Africa from first query.
    -Add the specific skills required for these roles.
    -Why? It provides a detailed look at which high-paying jobs demand certain skills,
        helping job seekers understand which skills to develop that aligns with top salaries. */
WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title,
            salary_year_avg,
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
    LIMIT 10
)

/*We're gonna need to connect the skills_job_dim and skills_dim 
so that we can show the skills required for this role */
SELECT 
        top_paying_jobs.* ,
        skills
FROM
         top_paying_jobs
INNER JOIN skills_job_dim ON 
         top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
         skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;