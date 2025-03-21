# Analytics Engineering Project

<h2>Project Architecture</h2>
<p align="center">
  <img src="https://github.com/efrenmo/Analytics-Engineering-Project/blob/main/Screenshots/ae_infra_l.drawio.png" />
</p>

## Project Overview

### Objective

To Engineere a comprehensive business intelligence solution for a client struggling with fragmented data sources, consolidating multiple transactional databases and cloud-stored files into a unified Snowflake data warehouse that enabled data-driven decision making and actionable business insights.

### Problem Statement

The client, a company relying on various transactional databases for customer relationship management, enterprise resource planning, accounting, and other core functions, faced challenges in leveraging their data for business intelligence and analytical purposes. The client also had additional relevant data stored in cloud-based files but lacked a unified data management infrastructure necessary for comprehensive analysis. This project sought to bridge that gap by creating a comprehensive data engineering solution.

### Solution

To address these challenges, the project involved the following key phases:

1. **Data Ingestion**:
   - Extracted data from a relational RDS PostgreSQL database and AWS S3 object storage.
   - Loaded the extracted data into a Snowflake data warehouse using Airbyte and AWS Lambda.

2. **Data Transformation**:
   - Cleaned and manipulated the ingested data using DBT (Data Build Tool).
   - Ensured data quality and consistency to prepare it for analysis.

3. **Data Analytics**:
   - Utilized Metabase, a business intelligence tool, to create interactive dashboards and reports.
   - Enabled analysts to draw actionable insights from the transformed data.

### Dataset

The project utilized the TPC-DS (Transaction Processing Performance Council Decision Support) dataset, which is commonly used to benchmark the performance of decision support systems running on SQL-based big data systems.

### Technologies Used

- **Programming Language**: Python
- **Database**: PostgreSQL
- **Data Ingestion Tools**: Airbyte, AWS Cloud (EC2, Lambda, S3, ECR)
- **Containerization**: Docker
- **Data Warehouse**: Snowflake
- **Data Transformation Tool**: DBT
- **Business Intelligence Tool**: Metabase




