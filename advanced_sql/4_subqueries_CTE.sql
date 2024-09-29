/*Find the companies that have the most job openings.
(i) Get the total number of job postings per company id(job_posting_fact).
(ii) Return the total number of jobs with the company name (company_dim).*/

WITH company_job_count AS (
SELECT                                  --For (i)
    company_id,
    COUNT(*) as total_jobs
FROM job_postings_fact
GROUP BY company_id)

SELECT company_dim.name AS company_name,
        company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;
/* For (ii), We have job_posting_fact connected to the company_dim table using company_id.
So we're gonna use LEFT JOIN where A=company_dim and B=job_posting_fact.*/

