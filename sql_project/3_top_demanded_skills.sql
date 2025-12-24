SELECT
    s.skills AS skill_name,
    COUNT(s.skills) AS skill_count
FROM
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sj ON sj.job_id = jpf.job_id
LEFT JOIN skills_dim AS s ON s.skill_id = sj.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
GROUP BY
    skill_name
ORDER BY
    skill_count DESC
LIMIT 5;