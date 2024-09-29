-- Create  tables for each months of these postings that is Jan, Feb, Mar. 
-- January vacancies
CREATE TABLE january_job AS
SELECT * 
FROM
         job_postings_fact 
WHERE 
        EXTRACT(MONTH FROM job_posted_date)= 1;-- only shows job posted in Jan

-- February vacancies
CREATE TABLE february_job AS
SELECT * 
FROM
         job_postings_fact 
WHERE 
        EXTRACT(MONTH FROM job_posted_date)= 2;-- only shows job posted in Feb

-- March vacancies
CREATE TABLE march_job AS
SELECT * 
FROM
         job_postings_fact 
WHERE 
        EXTRACT(MONTH FROM job_posted_date)= 3;-- only shows job posted in March

