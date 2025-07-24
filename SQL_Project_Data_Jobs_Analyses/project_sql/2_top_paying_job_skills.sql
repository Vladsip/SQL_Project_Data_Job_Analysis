/*
Question:
- What skills are required for the top_paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries */


WITH top_paying_jobs AS(
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_location = 'Anywhere' AND salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skillS_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

/*
🔸 SQL je nejčastěji zmiňovanou dovedností (8× z 10 pozic), což potvrzuje, že i pro velmi dobře placené role je práce s relačními databázemi naprosto zásadní.

🔸 Python (7×) je klíčový pro datovou vědu, skriptování a machine learning.

🔸 Cloudové platformy (hlavně AWS) a nástroje pro velká data (Spark, ETL) ukazují, že firmy čím dál více spoléhají na robustní infrastruktury a škálovatelná řešení.

🔸 Vizualizační nástroje (Tableau, Power BI, Excel) jsou stále velmi důležité, i když méně časté než core technické dovednosti. */