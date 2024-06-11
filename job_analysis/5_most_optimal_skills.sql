/*
 Answer: What are the most optimal skills to learn (high demand and also high paying)?
 - Identify skills in high demand and assosicated with high average salaries for Data Analyst roles.
 - Concentrates on remote positions with salaries
 - Why? Targets skills that offer job security (high_demand) and high salaries offering strategic insights for career development in DA.
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS skill_demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
         AND salary_year_avg IS NOT NULL
         AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)


SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skill_demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE skill_demand_count > 10
ORDER BY
    avg_salary DESC,
    skill_demand_count DESC
LIMIT 50;



-- Approach 2 

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 50;



-- TODO: Visualize to compare skills with demand and salary, demand graph.
-- generally seems like cloud computing is leading


