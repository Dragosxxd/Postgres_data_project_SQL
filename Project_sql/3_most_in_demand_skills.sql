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

-- Most in demand skills for data scientists in the EU

SELECT
    sd.skills,
    count(sd.skills) as total_skill_count
FROM EU_jobs eu left join skills_job_dim sjd ON
    eu.job_id = sjd.job_id inner join skills_dim sd ON
    sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    sd.skills
ORDER BY
    total_skill_count DESC