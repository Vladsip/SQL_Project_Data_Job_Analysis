/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts
and helps identify the most financially rewarding skills to acquire or improve */

SELECT 
    skills_dim.skills,
    ROUND (AVG (job_postings_fact.salary_year_avg), 0) AS avg_salary 
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 10


/*
📊 Shrnutí – Top 5 nejlépe placených dovedností:
Pořadí	Dovednost	Průměrný roční plat (USD)
1.	pyspark	208,172
2.	bitbucket	189,155
3.–4.	couchbase, watson	160,515
5.	datarobot	155,486
💡 Pozorované trendy:
🧠 1. Silná dominance nástrojů pro datové inženýrství a ML

    pyspark, databricks, airflow, jupyter, scikit-learn, datarobot, pandas, numpy

    → Vysoké platy (140–208k USD) ukazují, že zaměstnavatelé velmi oceňují schopnosti pracovat s velkými daty, automatizací a machine learningem.

💻 2. Popularita nástrojů DevOps a verzovacího systému

    bitbucket (189k), gitlab (154k), jenkins (125k), atlassian (131k)

    → Pokud data analytik zvládá i DevOps tooling, je výrazně atraktivnější na trhu.

☁️ 3. Cloud technologie a škálovatelnost

    gcp (Google Cloud Platform) – 122,500 USD

    kubernetes, databricks → moderní cloud-first přístup.

    → Firmy hledají analytiky schopné pracovat v distribuovaném prostředí.

🗃️ 4. Znalost konkrétních databází

    postgresql – 123,879 USD

    elasticsearch, couchbase → ukazují, že i méně běžné databáze mohou mít vysokou přidanou hodnotu.

📈 5. BI nástroje a analytické platformy

    microstrategy – 121,619 USD

    → Tradiční analytické nástroje si stále drží pozici, i když nepatří mezi TOP 10.*/