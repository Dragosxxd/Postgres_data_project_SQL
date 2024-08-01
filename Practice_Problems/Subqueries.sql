-- Problem 1 

SELECT skills_dim.skills
FROM skills_dim
INNER JOIN (
    SELECT 
       skill_id,
       COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
    LIMIT 5
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC;

-- Problem 2 

SELECT
    sq.company_id,
    sq.company_name,
    CASE
        WHEN sq.job_count <10 THEN 'Small'
        WHEN sq.job_count BETWEEN 10 AND 50 THEN 'Medium'
        WHEN sq.job_count > 50 THEN 'Large'
    END AS size_category 
FROM   (SELECT
            cd.company_id,
            COUNT(jpf.job_id) AS job_count,
            cd.name as company_name
        FROM job_postings_fact jpf LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
        GROUP BY    
            company_name,
            cd.company_id
        ORDER BY
            job_count DESC) AS sq
ORDER BY company_id

-- Problem 3 
SELECT 
    s.average_salary,
    s.company_name
FROM  
    (SELECT 
        AVG(jpf.salary_year_avg) AS average_salary,
        cd.name as company_name
    FROM  job_postings_fact jpf INNER join company_dim cd ON jpf.company_id = cd.company_id
    GROUP BY 
    cd.name
    ) as s 
WHERE 
average_salary > (SELECT 
                    AVG(salary_year_avg) 
                  FROM job_postings_fact)
ORDER BY 
    s.average_salary DESC



