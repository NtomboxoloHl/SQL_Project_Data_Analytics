/*Let's re-classify where a job is located, so our main focus is at the  job_location column. 
For this scenario, label new columns as follows:
-'Anywhere' jobs as 'Remote'.
-'New York,NY' jobs as 'Local'.
Otherwise 'Onsite'. */

SELECT  job_title_short,
        job_location,
        CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York,NY' THEN 'Local'
        ELSE 'Onsite'
        END AS location_category 
FROM job_postings_fact;

/*Also analyse how many jobs I can apply to whelther its local, remote or onsite for Data Analst. */
SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York,NY' THEN 'Local'
        ELSE 'Onsite'
        END AS location_category 
FROM 
job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY location_category;
