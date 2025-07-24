 # Intro
The Data Job Analysis project aims to explore and understand the current trends in the job market for data-related roles, with a focus on Data Analysts, Data Scientists, and related professions. Leveraging real job postings datasets, this project performs a structured analysis of:

    ✅ Top-paying roles and skills

    🌍 Job location distribution

    💼 Required tools, technologies, and programming languages

    📈 Salary trends and ranges

    🔎 Skills most commonly associated with high-paying positions

The ultimate goal is to uncover actionable insights for aspiring data professionals, hiring managers, and educators, by highlighting which skills are in demand, how they affect salary, and what geographic or industry-specific patterns exist.

Check SQL queries here: [project_sql folder](/SQL_Project_Data_Jobs_Analyses/project_sql/)
 # Background
 ## The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salarieS?
5. What are the most optimal skills to learn?

 # Tools I used
 For my deep dive into the data analyst job market, I harnessed the power of several key tools:
  - **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
  - **PostgreSQL:** The choosen database management system, ideal for handling the job posting data.
  - **Visual Studio Code:** My go-to for database management and executing SQL queries.
  - **Git & GitHub:** Essential from version control and sharing my SQL scripts and analysis, enosuring collaboration and project tracking.


 # The Analysis
 ### 1. What are the top-paying data analyst jobs?
- What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely?
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analyst, what are most optimal skills as Data Analyst?

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_location = 'Anywhere' AND salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 10
```
![Top paying jobs](SQL_Project_Data_Jobs_Analyses\assets\1_top_paying_jobs.png)
*Bar graph visualizing the salaty form the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*


Summary:

    - Highest salary: $650,000 (Mantys)

    - Lowest salary in top 10: $275,000

    - Average salary (top 10): approximately $361,500

    - Most positions are titled simply “Data Analyst” (8 out of 10).

    - 2 jobs are listed as “Business Data Analyst”.

    - Companies include a mix of large enterprises (e.g. JPMorgan Chase, NHS England) and smaller firms/startups.

### 2. What skills are required for these top-paying jobs?

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6. Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

![Skill Count for Top 10 Paying Data Analyst Jobs in 2023](SQL_Project_Data_Jobs_Analyses\assets\2_skill_count.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. What skills are most in demand for data analysts?
This query helped identify the skills most frequently requeted in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skillS_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```

| Skill     | Demand Count |
|-----------|--------------|
| SQL       | 7,291        |
| Excel     | 4,611        |
| Python    | 4,330        |
| Tableau   | 3,745        |
| Power BI  | 2,609        |
*Table of demand form the top 5 skills in data analyst job postings*

These figures represent the number of job postings requiring each skill across the dataset:

- **SQL** is the most in-demand skill with **7,291** job postings mentioning it — a fundamental requirement for data analysts.
- **Excel** appears in **4,611** job postings, confirming its continued relevance for data manipulation and reporting.
- **Python** is listed in **4,330** roles, indicating a strong need for programming and automation capabilities.
- **Tableau** is required in **3,745** postings, reflecting the importance of data visualization tools.
- **Power BI** is mentioned in **2,609** postings, showing its growing popularity as a BI solution.

### 4. Which skills are associated with higher salarieS?
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills_dim.skills,
    ROUND (AVG (job_postings_fact.salary_year_avg), 0) AS avg_salary 
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
```
This breakdown highlights the top-paying skills associated with data analyst roles:

- **PySpark** leads the list with an average salary of **$208,172**, reflecting its value in big data processing.
- **Bitbucket** follows with **$189,155**, suggesting high-paying opportunities in teams using Git-based DevOps tools.
- **Watson** and **Couchbase** both offer an average salary of **$160,515**, pointing to demand in AI and NoSQL technologies.
- **DataRobot** is linked to an average salary of **$155,486**, showcasing the value of AutoML platforms.
- **GitLab** (**$154,500**) and **Swift** (**$153,750**) highlight the demand for strong version control and mobile app skills.
- **Jupyter** (**$152,777**) and **Pandas** (**$151,821**) are key tools in the Python data stack, reinforcing their importance.
- **Elasticsearch** rounds out the list at **$145,000**, indicating its role in scalable search and analytics solutions.

| Skill         | Average Salary (USD) |
|--------------|----------------------|
| PySpark      | 208,172              |
| Bitbucket    | 189,155              |
| Watson       | 160,515              |
| Couchbase    | 160,515              |
| DataRobot    | 155,486              |
| GitLab       | 154,500              |
| Swift        | 153,750              |
| Jupyter      | 152,777              |
| Pandas       | 151,821              |
| Elasticsearch| 145,000              |
*Table of the average salary for the top 10 apying skills for data analysts*

### 5. What are the most optimal skills to learn?
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
WITH skills_demand AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skillS_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
), average_salary AS(
    SELECT 
        skills_job_dim.skill_id,
        ROUND (AVG (job_postings_fact.salary_year_avg), 0) AS avg_salary 
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_work_from_home = True
    GROUP BY skills_job_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
```

### 🔍 Skill Demand vs. Salary – Breakdown

| Skill       | 💼 Demand Count | 💰 Average Salary | 📌 Notes |
|-------------|-----------------|------------------|---------|
| **Go**          | 27              | $115,320           | A modern programming language gaining popularity, especially in backend and cloud-native environments. |
| **Confluence**  | 11              | $114,210           | A team collaboration tool used mostly for documentation and project management. |
| **Hadoop**      | 22              | $113,193           | A legacy big data processing framework, still valued in traditional enterprise systems. |
| **Snowflake**   | 37              | $112,948           | A leading cloud data warehouse – high demand and competitive pay. |
| **Azure**       | 34              | $111,225           | Microsoft’s cloud platform – frequently requested for cloud-based analytics roles. |
| **BigQuery**    | 13              | $109,654           | Google’s cloud data warehouse – efficient for large-scale analytics workloads. |
| **AWS**         | 32              | $108,317           | Amazon Web Services remains a core requirement for cloud-based data engineering. |
| **Java**        | 17              | $106,906           | Still relevant in enterprise applications and data processing (e.g., Hadoop). |
| **SSIS**        | 12              | $106,683           | A data integration tool used with Microsoft SQL Server – less common but still valuable. |
| **Jira**        | 20              | $104,918           | A project management tool often required for Agile environments – not technical but commonly listed. |

*Table of the most optimal skills for data analyst sorted by salary*

 # What I Learned


Along this journey, I’ve supercharged my SQL skills with powerful techniques and deeper understanding:

- **🧩 Advanced Query Design:** Gained expertise in constructing complex SQL queries, efficiently joining multiple tables, and utilizing `WITH` clauses for streamlined temporary views.

- **📊 Smart Data Summarization:** Became confident with `GROUP BY`, `COUNT()`, and `AVG()` to transform raw data into meaningful summaries and insights.

- **🧠 Analytical Thinking:** Sharpened my logical problem-solving abilities by translating real-world questions into precise, valuable SQL outputs.


 # Conclusions
 ### 🔍 Key Insights

From the analysis, several important observations surfaced:

1. **Highest-Paying Remote Roles**: Data analyst positions that offer remote flexibility come with a wide range of salaries — with some reaching up to **$650,000 annually**.

2. **Skills Behind Top Salaries**: Advanced SQL skills are frequently required for well-paid analyst roles, making it a **key factor in landing high-compensation jobs**.

3. **Most Widely Requested Skills**: Among all required competencies, **SQL stands out** as the most frequently mentioned, highlighting its importance for job seekers entering the field.

4. **Specialized Skills Command More**: Tools like **SVN** and **Solidity** are associated with higher-than-average pay, suggesting that **niche technical knowledge brings salary advantages**.

5. **Strategic Skills for Career Growth**: SQL offers a strong mix of **high demand and competitive pay**, making it one of the most strategic skills to invest in for those looking to maximize market value.


### 💭 Final Reflections

Through this project, I significantly expanded my SQL expertise and gained meaningful perspectives on the current data analyst job landscape. The insights uncovered throughout the analysis help inform decisions around which skills to prioritize and how to approach the job hunt effectively. 

For aspiring data professionals, mastering in-demand and well-compensated skills can offer a competitive edge in today’s job market. This journey also underscores the value of lifelong learning and staying agile in response to new developments in the data analytics space.
