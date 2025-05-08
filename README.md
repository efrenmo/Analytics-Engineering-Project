# Analytics Engineering Project

## Project Overview

### Problem Statement

The client, a company relying on various transactional databases for customer relationship management, enterprise resource planning, accounting, and other core functions, faced challenges in leveraging their data for business intelligence and analytical purposes. The client also had additional relevant data stored in cloud-based files but lacked a unified data management infrastructure necessary for comprehensive analysis. This project sought to bridge that gap by creating a comprehensive data engineering solution.

### Objective

To Engineere a comprehensive business intelligence solution consolidating multiple transactional databases and cloud-stored files into a unified Snowflake data warehouse that enabled data-driven decision making and actionable business insights.

<h2>Architecture and Technical Implementation</h2>
<p align="center">
  <img src="https://github.com/efrenmo/Analytics-Engineering-Project/blob/main/Screenshots/ae_infra_l.drawio.png" />
</p>

### Extract, Load, Transform, and Serve Pipeline Architecture

### Data Ingestion - Extract and Load

We have two main data sources; RDS PostgreSQL transactional databases, and csv files stored in AWS S3.

1. **Data Source 1: Transactional databases - RDS PostgreSQL:**
   - **Airbyte** was used to replicate selected tables from PostgreSQL and map them to staging tables in the Snowflake data warehouse.
   - It enabled incremental replication from PostgreSQL into Snowflake.
     - Incremental SYNCS were configured using primary keys and cursor fields.
   - I configured connectors, managed schema mapping, and monitored pipeline health through Airbyte’s UI.
   - Airbyte was the tool of choice for its performance, product fit, and ease to use, in addition to being production-ready.  
     - **Performance:** Airbyte has made significant progress in improving its performance, with the Postgres connector now being faster than Fivetran for Postgres replication.
     - **Product fit:** It provides dedicated connectors for both PostgreSQL and Snowflake, ensuring seamless integration between the two platforms.
     - **Ease to use:** You can easily configure RDS as the source, and Snowflake as the destination, create a connection, and set-up a sync schedule directly from the Airbyte user interface.
     - **Production-Ready:** Airbyte is used by over 30,000 companies worldwide to cover their data pipeline needs, demonstrating its scalability and reliability as a data integration platform.     - 
2. **Data Source 2: AWS S3 - CSV files:**
     - To ingest CSV files from AWS S3 and load their data into tables in the Snowflake data warehouse, a **Lambda function** is configured to trigger when new CSV files are detected in a specific S3 bucket.
     - When activated, the Lambda function loads a custom **Docker** image from our private **Elastic Container Registry (ECR)** repository. This Docker image contains the necessary Python script and dependencies to establish connections with both AWS S3 and Snowflake, process the CSV file, and load its data into Snowflake.
     - Lambda function was the tool of choice for its event-driven processing, simplicity and speed, scalability and efficiency .

### Data Transformation
   - **DBT (Data Build Tool)** was central to my transformation layer. 
   - I wrote modular SQL models to clean, join, and reshape raw data into analytics-ready tables. 
   - I implemented type 2 slowly changing dimensions (SCD2) for historical tracking.
   - Organized models into staging, intermediate, and marts layers.
   - Used DBT’s testing framework to enforce data quality and catch anomalies early.

### Data Analytics
   - Utilized **Metabase**, a business intelligence tool, to create interactive dashboards and reports.
   - Enabled analysts to draw actionable insights from the transformed data.

### Data Stack

- **Programming Language**: Python
- **Database**: PostgreSQL
- **Data Ingestion Tools**: Airbyte, AWS Cloud (EC2, Lambda, S3, ECR)
- **Containerization**: Docker
- **Data Warehouse**: Snowflake
- **Data Transformation Tool**: DBT
- **Business Intelligence Tool**: Metabase

### Infrastructure Specifications
<br>
<table>
  <tr>
    <th width="20%">Specification</th>
    <th width="26%">EC2 Instance 1</th>
    <th width="27%">EC2 Instance 2</th>
    <th width="27%">EC2 Instance 3</th>
  </tr>
  <tr>
    <td></td>
    <td align="center"><b>Airbyte</b></td>
    <td align="center"><b>DBT</b></td>
    <td align="center"><b>Metabase</b></td>
  </tr>
  <tr>
    <td><b>Instance Type</b></td>
    <td align="center">General Purpose T2 Large</td>
    <td align="center">General Purpose T2 Medium</td>
    <td align="center">General Purpose T2 Small</td>
  </tr>
  <tr>
    <td><b>vCPU</b></td>
    <td align="center">2</td>
    <td align="center">2</td>
    <td align="center">1</td>
  </tr>
  <tr>
    <td><b>Memory</b></td>
    <td align="center">8 GB</td>
    <td align="center">4 GB</td>
    <td align="center">2 GB</td>
  </tr>
  <tr>
    <td><b>OS</b></td>
    <td>Ubuntu Server 22.04 LTS</td>
    <td>Ubuntu Server 22.04 LTS</td>
    <td>Ubuntu Server 22.04 LTS</td>
  </tr>
  <tr>
    <td><b>Storage</b></td>
    <td>20 GB SSD HD Root Volume</td>
    <td>20 GB SSD HD Root Volume</td>
    <td>20 GB SSD HD Root Volume</td>
  </tr>
  <tr>
    <td><b>Dependencies</b></td>
    <td>
      • Docker 24.0.5, build ced0996<br>
      • Docker Compose v2.20.2<br>
      • Airbyte
    </td>
    <td>
      • python3-pip<br>
      • dbt-postgres<br>
      &nbsp;&nbsp;○ Core 1.5.2<br>
      &nbsp;&nbsp;○ Postgres 1.5.2
    </td>
    <td>
      • Docker 24.0.5, build ced0996<br>
      • Docker Compose v2.20.2<br>
      • Metabase
    </td>
  </tr>
</table>


