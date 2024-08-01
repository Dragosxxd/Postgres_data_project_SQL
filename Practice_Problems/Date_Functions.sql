-- Problem 1
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) as average_salary,
    AVG(salary_hour_avg) 
FROM 
    job_postings_fact 
WHERE 
    EXTRACT(month from job_posted_date) > '6'
GROUP BY
    job_schedule_type    
ORDER BY 
    job_schedule_type   ; 


-- Problem 2 
SELECT 
    COUNT(job_id), 
    EXTRACT(month from job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EDT') AS month
FROM 
    job_postings_fact
GROUP BY
   month 
ORDER BY
    month;

-- Problem 3

SELECT
    cd.name,
    COUNT(jpf.job_id)
FROM job_postings_fact JPF INNER JOIN company_dim cd ON
jpf.company_id = cd.company_id
WHERE
    jpf.job_health_insurance = TRUE AND
    EXTRACT(QUARTER from jpf.job_posted_date) = 2
GROUP BY
    cd.name
HAVING 
    COUNT(jpf.job_id) <> 0
ORDER BY 
    COUNT(jpf.job_id) desc;
    

