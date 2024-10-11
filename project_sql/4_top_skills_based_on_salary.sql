/*What are the top skills based on salary?
    -Look at the average salary associated with each skills for data scientist positions.
    -Focuses on roles with specified salaries, specifically in South Africa.
    -Why? It reveals how different skills impact salary levels for data scientist and
    helps identify the most financially rewarding skills to acquire or improve. */
SELECT 
   skills,
   ROUND(AVG(salary_year_avg),2)*19 AS annual_salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Scientist' AND
        salary_year_avg IS NOT NULL AND 
        job_country = 'South Africa'

GROUP BY skills
ORDER BY annual_salary_avg DESC
LIMIT 30;