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


SELECT
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
LIMIT 30