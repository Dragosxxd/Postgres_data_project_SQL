-- Problem 1 

CREATE TABLE data_science_jobs  (
    job_id INT PRIMARY KEY,
    job_title TEXT , 
    company_name TEXT ,
    post_date DATE
);

-- Problem 2 
INSERT INTO  data_science_jobs (job_id, job_title, company_name, post_date)
VALUES 
(1, 'Data Scientist', 'Tech Innovations' ,'2023-01-01' ) ,
(2, 'Machine Learning Engineer' , 'Data Driven Co' , '2023-01-15'),
(3, 'AI Specialist', 'Future Tech' , '2023-02-01');

-- Problem 3
ALTER TABLE data_science_jobs 
ADD COLUMN remote BOOLEAN;

-- Problem 4

ALTER TABLE data_science_jobs 
RENAME COLUMN post_date TO posted_on;

-- Problem 5 

ALTER TABLE data_science_jobs 
ALTER COLUMN remote SET DEFAULT FALSE;
INSERT INTO data_science_jobs (job_id, job_title, company_name, posted_on)
VALUES
(4, 'Data Scientist', 'Google', '2023-02-05');

-- Problem 6

ALTER TABLE data_science_jobs 
DROP COLUMN company_name;


-- Problem 7

UPDATE data_science_jobs 
SET remote = TRUE WHERE job_id = 2;

-- Problem 8
DROP TABLE data_science_jobs;