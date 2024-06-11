
/* Question: What are the top paying data analyst jobs?
  - Identify top 5 paying job titles in Data field
  - Identify top 10 paying job posting.
  - Identify the top 10 highest-paying Data Analyst roles that are available remotely, on-site, hybrid.
  - Identify the top 10 highest-paying Data Scientist roles that are available remotely, on-site, hybrid.
  - Focus on job postings within a salary range
  - Why are they the highest? Highlight the top-paying opportunities for Data Analysts, offering insights into employee qualifications 
*/



-- What are the top 5 paying job titles in the Data industry?
SELECT 
    job_title_short AS title,
    AVG(salary_year_avg) AS average_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY average_salary DESC
LIMIT 10;

-- What are the top 10 paying jobs postings?
SELECT 
    job_id,
    name AS company_name,
    job_title_short AS title,
    job_title AS title_desc,
    job_location AS location,
    job_country,
    job_schedule_type AS schedule,
    job_work_from_home AS is_remote,
    salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL
LIMIT 10

-- What are the top highest-paying Data Analyst roles that are available?
SELECT 
    job_id,
    name AS company_name,
    job_title_short AS title,
    job_title AS title_desc,
    job_location AS location,
    job_country,
    job_schedule_type AS schedule,
    job_work_from_home AS is_remote,
    salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10

-- What are the top highest-paying Data Scientist roles that are available?
SELECT 
    job_id,
    name AS company_name,
    job_title_short AS title,
    job_title AS title_desc,
    job_location AS location,
    job_country,
    job_schedule_type AS schedule,
    job_work_from_home AS is_remote,
    salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10






    