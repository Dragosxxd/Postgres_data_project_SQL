-- Problem 1 
SELECT  
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 100000 THEN 'high salary'
        WHEN salary_year_avg BETWEEN 60000 and 99999 THEN 'Standard salary'
         WHEN salary_year_avg < 60000 THEN 'Low salary'
    END AS salary_category    
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;

-- Problem 2 
SELECT 
    COUNT(DISTINCT CASE WHEN job_work_from_home = TRUE THEN company_id END) AS wfh_companies,
    COUNT(DISTINCT CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM job_postings_fact;

-- Problem 3 
SELECT
    job_id,
    salary_year_avg,
CASE 
    WHEN job_title ILIKE '%Senior%' THEN 'Senior'
    WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Manager/Lead'
    WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
    ELSE 'Not Specified'
END as experience_level,
CASE 
    WHEN job_work_from_home = FALSE THEN 'not_remote'
    WHEN job_work_from_home = TRUE THEN 'remote'
END as remote_option
FROM 
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    job_id;




