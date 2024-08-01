-- Problem 1 
WITH diverse_jobs AS (
    SELECT 
        company_id,
        COUNT(DISTINCT job_title) AS count_of_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
) 

SELECT 
    cd.name AS company_name,
    count_of_jobs
FROM diverse_jobs dj left join company_dim cd on dj.company_id = cd.company_id
ORDER BY    
    count_of_jobs DESC

-- Problem 2 
WITH country_salary AS(
    SELECT  
    job_country,
    AVG(salary_year_avg) as average_salary
FROM 
    job_postings_fact
GROUP BY
    job_country
)

SELECT
    jpf.job_id,
    jpf.job_title,
    cd.name,
    AVG(jpf.salary_year_avg),
    CASE
    WHEN jpf.salary_year_avg > cs.average_salary
    THEN 'Above Average'
    ELSE 'Below Average'
  END AS salary_category,
    EXTRACT(month from job_posted_date) AS month
FROM 
    country_salary cs inner join job_postings_fact jpf ON
    cs.job_country = jpf.job_country inner join 
    company_dim cd ON cd.company_id = jpf.company_id
GROUP BY    
    jpf.job_id,
    cd.name,
    average_salary
ORDER BY 
    month DESC



-- Problem 3

WITH unique_skill AS(
    SELECT 
        jpf.company_id,
        COUNT(DISTINCT sd.skills) AS skills_count
    FROM skills_dim sd INNER JOIN skills_job_dim sjd ON 
    sd.skill_id = sjd.skill_id inner join job_postings_fact jpf ON 
    sjd.job_id = jpf.job_id
    GROUP BY
    company_id
),
top_pay AS(
    SELECT 
        jpf.company_id,
        MAX(salary_year_avg) as max_salary
    FROM 
        job_postings_fact jpf
    WHERE 
        jpf.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY
        company_id 
)

SELECT 
    cd.name,
    us.skills_count AS unique_skills_req,
    tp.max_salary
FROM company_dim cd left join unique_skill us ON
    us.company_id = cd.company_id LEFT JOIN top_pay tp ON
    cd.company_id = tp.company_id
Where 
    us.skills_count IS NOT NULL
ORDER BY 
    cd.name



