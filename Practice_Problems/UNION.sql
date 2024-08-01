-- Problem 1
SELECT
    job_id,
    job_title,
    CASE
        WHEN salary_year_avg IS NOT NULL THEN 'Salary Info Provided'
    END as salary_information 
FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL 

UNION ALL 

SELECT
    job_id,
    job_title,
    CASE
        WHEN salary_year_avg IS NULL THEN 'Salary Info MISSING'
    END as salary_information 
FROM
    job_postings_fact
WHERE salary_year_avg IS NULL 

-- Problem 2 
SELECT
    j.job_id,
    job_title_short,
    job_location,
    job_via,
    j.salary_year_avg,
    sd.skills,
    sd.type
FROM(   SELECT *
        FROM january_jobs

        UNION ALL 

        SELECT *
        FROM february_jobs

        UNION ALL

        SELECT *
        FROM march_jobs
) as j LEFT JOIN skills_job_dim sjd ON
    j.job_id = sjd.job_id LEFT JOIN skills_dim sd ON
    sjd.skill_id = sd.skill_id
WHERE 
    j.salary_year_avg > 70000
ORDER BY 
    j.job_id


-- Problem 3
SELECT 
    sd.skills,
    COUNT(j.job_id),
    EXTRACT(MONTH from job_posted_date) as month,
    EXTRACT(YEAR from job_posted_date) as year
FROM (   SELECT *
        FROM january_jobs

        UNION ALL 

        SELECT *
        FROM february_jobs

        UNION ALL

        SELECT *
        FROM march_jobs
) j inner join skills_job_dim sjd ON 
    j.job_id = sjd.job_id LEFT JOIN skills_dim sd ON
    sjd.skill_id = sd.skill_id 
GROUP BY 
    sd.skills,
    year,
    month
ORDER BY
    sd.skills,
    year,
    month




