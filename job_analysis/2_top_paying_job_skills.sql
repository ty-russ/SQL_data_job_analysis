/* Question: What skills are required for the top paying data analyst jobs?
- Add specific skills required for roles in the posting
- Why? It provides a detailed look at which high-paying jobs demand certain skills, which skills should one have to be top-salaried.
*/

-- What Skills are required?
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        name AS company_name,
        job_title_short AS title,
        job_title AS title_desc,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills,
    type
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

/* TODO : export output csv, analyse and insights in python jupyter notebook    -
    - group by skills
    - identify most in demand skills
    - visualize and draw insights
*/
