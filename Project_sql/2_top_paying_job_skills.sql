-- Create a CTE that contains only the data from the countries in the European Union
WITH EU_jobs AS(
    SELECT *
    FROM job_postings_fact
    WHERE 
    job_country IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 
                    'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 
                    'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 
                    'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
)

-- Find the top 5 skills for the best paying job postings in the european union
SELECT
    sd.skills,
    COUNT(sd.skills) AS skills_count
FROM (SELECT
    job_id,
    job_title,
    cd.name AS company_name,
    job_country,
    salary_year_avg
FROM    
    EU_jobs LEFT JOIN company_dim cd ON
    EU_jobs.company_id = cd.company_id
WHERE   
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Scientist'
ORDER BY    
    salary_year_avg DESC
LIMIT 10) AS top_30 INNER JOIN skills_job_dim sjd ON 
        top_30.job_id = sjd.job_id INNER JOIN skills_dim sd ON
        sjd.skill_id = sd.skill_id
GROUP BY
    sd.skills
ORDER BY
    skills_count DESC

          