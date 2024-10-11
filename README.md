# 1. Introduction 
This project provides a comprehensive analysis of the data job market in South Africa, specifically targeting data scientist roles. It investigates lucrative job opportunities, essential skills sought by employers, and trends that highlight the correlation between demand and salary. 

For detailed SQL queries, please refer to my [project_sql](/project_sql/) folder. 
# 2. Background
In an era where data science is integral to strategic decision-making, this project seeks to deliver a comprehensive analysis of the data scientist job market, emphasizing the identification of high-paying and in-demand skills. The objective is to empower aspiring data scientists with critical insights that will enhance their career prospects and attract the attention of potential employers.

The dataset utilized for this analysis is sourced from [Luke Barousse's SQL Course](https://lukebarousse.com/sql), which contains a substantial  array of information on job titles, salaries, geographical trends, and essential competencies within the industry.

Key analytical questions guiding this exploration include:
- What are the top-paying data scientist roles?
- What skills are critical for securing these high-level positions?
- Which competencies are most sought after in the field?
- How do specific skills correlate with higher salary brackets?
- What skills should candidates prioritize for optimal career advancement?

By addressing these questions, this project aims to illuminate pathways for skill development that align with market demands, thereby enhancing the employability of prospective data scientists in an increasingly competitive environment.


# 3. Tools I used
To conduct a thorough exploration of the data scientist job market, I utilized a selection of powerful tools that enhanced my analytical capabilities:

- **SQL**: This essential language formed the foundation of my data analysis, enabling me to construct complex queries that revealed deep insights and trends within the dataset.
- **PostgreSQL**: This sophisticated database management system was instrumental in efficiently managing and processing the extensive job posting data, ensuring robust performance throughout the analysis.
- **Visual Studio Code**: I leveraged this versatile development environment for seamless database interactions and executing complex SQL queries, fostering an organized workflow.

- **Git & GitHub**: Utilizing these platforms ensured effective version control and collaboration, providing a transparent framework for tracking changes in my SQL scripts and analytical documentation.
# 4. The Analysis
This analysis revolves around various queries designed to uncover key insights into the data scientist job market. Each query targets a specific aspect, facilitating a deeper understanding of industry trends and demands. By employing a structured methodology, I aimed to ensure a comprehensive exploration of the data. The following sections detail my approach to each query, highlighting the ultimate findings.

## 4.1. Top 10 High-Paying Data Scientist Jobs 
To identify high-paying data scientist positions, I filtered job postings by high average annual salary and location, specifically highlighting opportunities in South Africa. This analysis showcases the most rewarding positions in the field. 

``` sql 
SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        ROUND(salary_year_avg,2)* 19 AS annual_salary_avg,
        job_posted_date,
        name AS company_name
FROM
        job_postings_fact

--Let's also find out the company name of these role, now we're gonna join company_dim with job_postings_facts.

LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
        job_title_short = 'Data Scientist' AND
        job_country = 'South Africa' AND 
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10;
```
This analysis provides a detailed overview of the query results, offering valuable insights into the top data scientist roles for 2023:
- **High Demand and Salary Range**: The top-paying data science jobs in South Africa show strong demand, particularly in financial institutions like **Nedbank** and **Standard Bank Group**, with salaries ranging from R1,722,730.00 to R3,239,500.00  indicating significant opportunities for both entry-level and experienced professionals.

- **Concentration of Roles**: Most positions are located in Johannesburg, reflecting its status as a financial and tech hub, with companies such as **Luno** and **Experian** actively hiring, while other cities like Durban (U.S. Department of Labor) and Centurion (OUTsurance) also feature roles, albeit less frequently.

- **Emerging Specializations**: Job titles from companies like **Standard Bank Group** and **Nedbank** indicate a trend towards specialized roles within data science, such as "Machine Learning Modelling" and "Insights," highlighting the evolving nature of the field and the need for targeted skills.

![Top paying jobs](/additional%20info/top_paying_jobs.png)

*A bar graph that displays top data scientist paying jobs associated with their salaries.*
## 4.2. Key Skills Required for High-Level Positions
To identify the skills neccessary for securing top-paying data scientist jobs, I joined job postings with the skills data,uncovering the attributes that employers demand in lucrative positions. 

``` sql
WITH top_paying_jobs AS (
     SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        ROUND(salary_year_avg,2)* 19 AS annual_salary_avg,
        job_posted_date,
        name AS company_name
FROM
        job_postings_fact
--Let's also find out the company name of these role, now we're gonna join company_dim with job_postings_facts.
LEFT JOIN company_dim ON 
        job_postings_fact.company_id = company_dim.company_id
WHERE
        job_title_short = 'Data Scientist' AND
        job_country = 'South Africa' AND 
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10
)

--We're gonna need to connect the skills_job_dim and skills_dim so that we can show the skills required for this role 

SELECT 
        top_paying_jobs.* ,
        skills
FROM
         top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
     annual_salary_avg DESC;
```


The horizontal bar graph below presents the distribution of the most in-demand skills for data scientist roles in 2023. **SAS** emerged as the leading skill, with 10 occurrences, highlighting its critical role in data analytics, particularly in industries like finance and healthcare. **Python** followed closely with 8 occurrences, underscoring its versatility and demand in machine learning, data analysis, and automation. **R**, with 7 occurrences, remains a strong contender, essential for statistical analysis and data modeling. **SQL**, with 5 occurrences, continues to be a cornerstone for database management and querying.

**Spark** and **Hadoop**, each with 4 occurrences, demonstrate the growing need for big data processing tools in handling large datasets and distributed data systems. **Azure**, **Tableau**, and **Matlab**, with 3 occurrences each, highlight important, though secondary, skills for data visualization and cloud operations. These tools are crucial for specific tasks but not as critical as the core programming and database skills.

This data suggests that employers are seeking candidates with a balanced mix of traditional data analytics skills and modern technologies like cloud and big data processing.

![Skills for top paying jobs](/additional%20info/top_paying_skills.png)

*A bar graph that shows top skills required for the data science profession.*
## 4.3. Most Valued Skills In Data Science Profession
This query highlights the skills most frequently mentioned in job descriptions, drawing attention to the areas where demand for expertise is surging. 
```sql
SELECT 
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Scientist' AND 
        job_country = 'South Africa'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
The table  display below the distribution of in-demand skills for data scientist roles based on the current data. **Python** emerges as the most sought-after skill, with 1495 occurrences, emphasizing its widespread utility in machine learning, data manipulation, and analytics. **SQL**, with 1314 occurrences, follows closely, highlighting its critical role in database querying and management. **R** and **SAS**, with 982 and 934 occurrences respectively, maintain strong demand, demonstrating their continued relevance in statistical analysis and specialized industries like healthcare and finance.

In contrast, **Excel** records 397 occurrences, showing it is still valued for simpler data handling and reporting tasks, though it is less critical than programming languages. This distribution suggests that employers prioritize a robust combination of programming proficiency, database skills, and statistical tools in their hiring practices, with Python and SQL forming the backbone of required skills.

| Skills  | Demand Count | 
|:----------:|:----------:|
| Python    | 1495   | 
| SQL   | 1314   | 
| R    | 982  | 
|  SAS    |       934      |
|    Excel   |      397      |

*Table of the demand for the top 5 skills in data scientist job postings.*


## 4.4. Top Skills Associated With High Average Salary
By evaluating the average salaries tied to specific skills, I uncover which abilities offer the highest financial rewards in South Africa. 

``` sql
SELECT 
   skills,
   ROUND(AVG(salary_year_avg),2)*19 AS annual_salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Scientist' AND
        salary_year_avg IS NOT NULL AND 
        job_country = 'South Africa'

GROUP BY skills
ORDER BY annual_salary_avg DESC
LIMIT 30;
```
- **Specialized Programming Languages Command the Highest Salaries**: Niche languages such as **Clojure**, **Scala**, and **C** lead with average salaries of approximately R3,239,500.00 , underscoring the premium placed on advanced, specialized programming skills. These languages are less common and often critical in high-performance computing and complex software engineering, driving up their value in the marketplace.

- **Big Data & Cloud Skills Are Highly Valued**: Technologies related to big data and cloud infrastructure, such as **Cognos**, **Redshift**, **Spark**, and **Hadoop** , offer salaries ranging from approximately R2,850,000.00 to R2,992,500.00. This reflects the growing reliance on distributed computing and large-scale data management, with companies willing to pay a premium for expertise in these high-demand areas.

- **Common Tools Command Lower Salaries**: Widely-used tools like **Power BI**, **Excel**, and **Tableau** average salaries between R1,330,000.00 and R1,818,300.00 , reflecting a larger talent pool and broader accessibility. While essential for business intelligence and data visualization, these tools do not carry the same salary premium as more specialized programming or cloud-related technologies.

| Skills | Annual Average Salary (in rands) |
|:-------:|:--------------:|
|  clojure     |  3239500.00            |
|   scala    |   3239500.00           |
|    c   |3239500.00 |
|    lua   |    3239500.00          |
|    cognos   |      2992500.00        |
|   redshift    |       2992500.00       |
|    spark   |   2911826.00          |
|   hadoop    |    2911826.00          |
|    sql server   |     2848983.50         |
|    matlab   |       2802601.27       |
|    looker   |      2274300.00        |
|   java    |     2262818.30         |
|     python  |      2083640.13        |
|   dax    |        2080500.00      |
|    ssrs   |       2080500.00       |
|    t-sql   |      2080500.00        |
|   azure    |          2047060.00    |
|    r   |          2044001.76    |
|    aws   |     2038700.00         |
|  sas     |1981279.15|
|     c++  |         1966262.50     |
|    sql   |      1955877.10        |
|    excel   |         1818300.00     |
|   julia    |      1722730.00        |
|    tableau   |          1706331.67   |
|   power bi    |      1479144.30        |
|   spss    |     1418247.97         |
|    qlik   |     1330000.00         |
|  html     |   1330000.00           |
|    c#   |     1329643.75         |

*Table above shows average salaries of the most valuable skills for data scientists.*

## 4.5. Skills For Optimal Career Advancement
By analyzing the intersection of market demand and salary trends, this query reveals the most strategic skills to learn for long-term career success.

```sql 
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2)*19 AS annual_salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_country ='South Africa'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 5
ORDER BY
    annual_salary_avg DESC,
    demand_count DESC
LIMIT 10;  
```


| Skill ID | Skills | Demand Count | Annual Average Salary (in rands) |
|:----------:|:----------:|:----------:|:----------:|
| 1  | Python   | 13   |  2083640.13  |
| 5    | R   | 12   |  2044001.76  |
| 7    | SAS   | 10   |  1981279.15  |
| 186    | SAS  | 10  | 1981279.15  |
| 0    | SQL   | 10   |  1955877.10  |
| 182    | Tableau  | 7  | 1706331.67  |

*The table above displays salary-based ranking of optimal skills for data scientist.*


- **Core Programming Skills**: **Python** and **R** are the most in-demand skills with Python leading with 13 demand postings and an average salary of R2,083,640.13. Furthermore, R, with 12 demand postings and an average salary of R2,044,001.76, follows closely.These languages are essential for data manipulation, machine learning, and statistical analysis.
- **Specialized Analytical Tools**: **SAS** and **SQL** each have 10 demand postings, with salaries over R1,938,000.00. These tools remain crucial in industries requiring robust analytics, such as finance and healthcare.
- **Data Visualization Skills**: While **Tableau** has fewer demand postings (7), it offers a solid salary of R1,706,331.67, showing that visualization is important but secondary to programming and analytical expertise.

# What I learned 
My experience with SQL has been a journey of continuous learning and growth. Along the way, I have acquired practical skills and honed advanced techniques that have broadened my understanding of data manipulation. Each challenge helped me build a solid foundation in SQL, from writing complex queries to optimizing data analysis processes.

During this journey, I've significantly enhanced my SQL expertise, adding a suite of powerful new skills to my toolkit:
 - I have become adept at using INNER JOIN, LEFT JOIN, and other advanced join techniques to seamlessly connect multiple datasets, creating cohesive, actionable data from different sources.
 - I have leveraged aggregate functions like SUM() and COUNT() to efficiently summarize large datasets, with HAVING clauses for precise filtering.
- I have gained proficiency in writing subqueries to extract specific information, improving both query efficiency and clarity.
- I learned how to use Git and GitHub for version control, managing code changes, and tracking progress throughout my project.
# Conclusion
### Insights
The analysis revealed several key insights:
1. **Highest-Paying Data Scientist Roles**: The top-paying positions for data scientists, offering flexibility across local, remote, or hybrid work arrangements, provide a broad salary range, with the highest compensation reaching R3,239,500.

2. **Skills For Top Paying Jobs**: Advanced proficiency in **SAS** and **Python** is a key requirement for securing high-paying data scientist positions.

3. **Most In-Demand skill**: **Python** stands as the most in-demand skill within the data science job market, reflecting its widespread application across various industries. 

4. **Skills with High Average Salaries**: Professionals who posses expertise in **Clojure**, **Scala** and **C** often secure high-paying positions.

5. **Critical Skills to Boost Career Marketability**: Given the rapid growth of the data science field, demand for professionals skilled in **Python** and **R** is projected to remain strong, making them pivotal to career advancement.



This project has deepened my understanding of SQL while offering a comprehensive overview of the current demands within the data scientist job market. Through the analysis, critical skill areas that drive demand and offer competitive compensation have been identified, forming a basis for targeted professional growth. Aspiring data scientists can leverage these insights to navigate the competitive job landscape more effectively, aligning their skill sets with industry needs. The project further emphasizes the necessity of staying adaptable and continuously enhancing one's expertise to keep pace with the rapid advancements in the data science field.

[def]: /project_sql/