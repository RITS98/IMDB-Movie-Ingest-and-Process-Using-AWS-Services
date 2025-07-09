# IMDB Movie Data Processing and Ingestion Using AWS Services

This project focuses on processing and ingesting IMDB movie data using various AWS services. The goal is to create a robust data pipeline that can handle large datasets efficiently.

## Technologies Used
1. AWS S3
2. AWS Glue Data Quality
3. AWS Glue Data Catalog
4. AWS Glue Crawler
5. AWS Glue Low Code ETL
6. AWS Redshift
7. AWS CloudWatch
8. AWS EventBridge
9. AWS SNS


## Architecture Overview
The architecture consists of the following components:
- **AWS S3**: Used for storing raw and processed data.
- **AWS Glue**: Used for data cataloging, crawling, and ETL processes.
- **AWS Redshift**: Used for data warehousing and analytics.
- **AWS CloudWatch**: Used for monitoring and logging the data pipeline.
- **AWS EventBridge**: Used for event-driven architecture to trigger workflows.
- **AWS SNS**: Used for notifications and alerts.

![movie_aws](https://github.com/user-attachments/assets/be9f31df-afaa-4cf9-ae42-17eff76279bd)

## Data Flow
1. Raw data is ingested into AWS S3.
2. AWS Glue Crawler scans the raw data and updates the Glue Data Catalog.
3. AWS Glue Low Code ETL jobs process the data and transform it into a structured format.
4. Processed data is stored to AWS Redshift for analytics.
5. AWS CloudWatch monitors the entire pipeline and logs events.
6. AWS EventBridge triggers workflows based on specific events.
7. AWS SNS sends notifications for any alerts or issues in the pipeline via email.


## About the Data

The dataset used in this project is a collection of IMDB movie data, which includes various attributes related to movies. The dataset is structured in a tabular format with the following columns:
- **Poster_Link**: Link of the poster that IMDB uses.
- **Series_Title**: Name of the movie.
- **Released_Year**: Year at which the movie was released.
- **Certificate**: Certificate earned by the movie.
- **Runtime**: Total runtime of the movie.
- **Genre**: Genre of the movie.
- **IMDB_Rating**: Rating of the movie on the IMDB site.
- **Overview**: Mini story/summary of the movie.
- **Meta_score**: Score earned by the movie.
- **Director**: Name of the Director.
- **Star1, Star2, Star3, Star4**: Names of the stars.
- **No_of_votes**: Total number of votes received by the movie.
- **Gross**: Money earned by the movie.


## Setup Steps


