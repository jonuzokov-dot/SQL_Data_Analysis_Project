WITH top_paying_jobs AS (
    SELECT
        name AS company_name,
        job_id,
        job_title, 
        job_location,
        job_schedule_type, 
        salary_year_avg, 
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_location = 'Anywhere' AND
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    s.skills AS skill_name,
    COUNT(s.skills) AS skill_count
FROM
    top_paying_jobs
LEFT JOIN skills_job_dim AS sj ON sj.job_id = top_paying_jobs.job_id
LEFT JOIN skills_dim AS s ON s.skill_id = sj.skill_id
GROUP BY
    skill_name
ORDER BY
    skill_count DESC;