/* Question: What are the most in-demand skills for a data analyst?
   - Join job postings to job_skills inner join table similar to query 2
   - Identify the top 5 in-demand skills for data analyst.
   - Focus on all job postings.
   - Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills to job seekers.
*/


-- Approach 1

WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim
    INNER JOIN job_postings_fact  ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Scientist'
    GROUP BY skill_id 
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;

-- Approach 2

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS skill_demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    skill_demand_count DESC
LIMIT 5;