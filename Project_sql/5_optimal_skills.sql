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

-- Find the best paid skills for DATA SCIENTISTS in the EU
SELECT
    sd.skills,
    ROUND(avg(salary_year_avg), 2 ) as total_salary,
    COUNT(eu.job_id) as Demand_count
FROM EU_jobs eu left join skills_job_dim sjd ON
    eu.job_id = sjd.job_id inner join skills_dim sd ON
    sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING 
    COUNT(eu.job_id) > 10
ORDER BY
    Demand_count DESC,
    total_salary DESC
LIMIT 10