WITH skills_demand AS (
    SELECT
        s.skill_id,
        s.skills AS skill_name,
        COUNT(s.skills) AS demand_count
    FROM
        job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sj ON sj.job_id = jpf.job_id
    LEFT JOIN skills_dim AS s ON s.skill_id = sj.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL 
        AND jpf.job_work_from_home = TRUE
    GROUP BY
        s.skill_id
), avarage_salary AS (
    SELECT
        s.skill_id,
        s.skills AS skill_name,
        ROUND(AVG(jpf.salary_year_avg),0) AS salary_avg
    FROM
        skills_dim AS s
    INNER JOIN skills_job_dim AS sj ON sj.skill_id = s.skill_id
    INNER JOIN job_postings_fact AS jpf ON jpf.job_id = sj.job_id
    WHERE
        jpf.job_title_short = 'Data Analyst' 
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = TRUE
    GROUP BY
        s.skill_id
)

SELECT
    skills_demand.skill_name,
    skills_demand.demand_count,
    avarage_salary.salary_avg
FROM
    skills_demand
INNER JOIN avarage_salary ON avarage_salary.skill_id = skills_demand.skill_id
GROUP BY
    skills_demand.skill_name,
    skills_demand.demand_count,
    avarage_salary.salary_avg
HAVING
    skills_demand.demand_count > 10
ORDER BY
    avarage_salary.salary_avg DESC,
    skills_demand.demand_count DESC
    

