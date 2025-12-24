SELECT
    s.skills AS skill_name,
    ROUND(AVG(jpf.salary_year_avg),0) AS avarage_salary
FROM
    skills_dim AS s
INNER JOIN skills_job_dim AS sj ON sj.skill_id = s.skill_id
INNER JOIN job_postings_fact AS jpf ON jpf.job_id = sj.job_id
WHERE
    jpf.job_title_short = 'Data Analyst' 
    AND jpf.salary_year_avg IS NOT NULL
    --AND jpf.job_work_from_home = TRUE
GROUP BY
    skill_name
ORDER BY
    avarage_salary DESC;