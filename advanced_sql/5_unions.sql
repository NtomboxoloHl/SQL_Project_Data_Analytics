-- Get jobs and companies from Jan
SELECT 
        job_title_short,
        company_id,
        job_location
FROM january_job

UNION ALL --combinig Jan and Feb 

--Get jobs and companies from Feb
SELECT 
        job_title_short,
        company_id,
        job_location
FROM february_job

UNION ALL-- combining all three tables

--Get jobs and companies from Mar
SELECT 
        job_title_short,
        company_id,
        job_location
FROM march_job;