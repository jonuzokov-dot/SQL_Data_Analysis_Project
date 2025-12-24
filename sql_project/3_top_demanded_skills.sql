SELECT
    s.skills AS skill_name,
    COUNT(s.skills) AS demand_count
FROM
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sj ON sj.job_id = jpf.job_id
LEFT JOIN skills_dim AS s ON s.skill_id = sj.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' 
    AND jpf.job_work_from_home = TRUE
GROUP BY
    skill_name
ORDER BY
    demand_count DESC
LIMIT 5;