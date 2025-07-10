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

### Create AWS S3 Bucket

1. **Sign in to AWS Console**

   * Go to [https://console.aws.amazon.com/s3](https://console.aws.amazon.com/s3)
   * Login with your AWS credentials.

2. **Open the S3 Dashboard**

   * From the AWS Management Console, search for and select **S3**.

3. **Click on "Create bucket"**

   * This opens the bucket creation form.

4. **Enter a Unique Bucket Name**

   * Bucket names must be globally unique across all AWS accounts.
   * Use lowercase letters, numbers, and hyphens only.

5. **Choose AWS Region**

   * Select the region where you want your data stored (e.g., `us-east-1`, `ap-south-1`).

6. **Configure Options (optional)**

   * **Versioning**: Enable if you want to keep multiple versions of an object.
   * **Tags**: Add metadata as key-value pairs.
   * **Default encryption**: Optional—select server-side encryption if needed.

7. **Set Bucket Permissions**

   * By default, public access is blocked (recommended for security).
   * You can adjust access settings later using **bucket policy** or **IAM roles**.

8. **Review and Create**

   * Review all your settings.
   * Click **"Create bucket"** at the bottom.


<img width="1269" alt="image" src="https://github.com/user-attachments/assets/d48f5a5d-47b6-487d-bef3-523b57264bd1" />

<img width="1269" alt="image" src="https://github.com/user-attachments/assets/7443ffac-afda-433e-9509-c3a9c87f7257" />

<img width="1094" alt="image" src="https://github.com/user-attachments/assets/6711ec9c-cff3-4ffc-b7dd-9f5c9f0a36be" />

### Create Redshift DataWarehouse

#### 1. Sign In to AWS Console
- URL: https://console.aws.amazon.com/
- Login with your AWS credentials.


#### 2. Open Amazon Redshift Service
- In the AWS Console, search for **Redshift** and open it.

#### 3. Click “Create cluster”


#### 4. Choose Cluster Creation Method
- Select **“Provisioned”** for full control over nodes and resources.
- Use **“Serverless”** if you want AWS to manage compute automatically.


#### 5. Configure Cluster Details

- **Cluster Identifier**: e.g., `redshift-cluster-ritayan`
- **Database name**: e.g., `dev` (default)
- **Port**: `5439` (default)
- **Master username**: e.g., `admin`
- **Master password**: Strong password

#### 6. Choose Node Type and Cluster Size

- **Node Type**: e.g., `dc2.large`, `ra3.xlplus`
- **Cluster Type**: 
  - `single-node` for development
  - `multi-node` for production

<img width="1437" alt="image" src="https://github.com/user-attachments/assets/a3461bfe-2758-4640-b27f-ae1181d6093a" />

<img width="1282" alt="image" src="https://github.com/user-attachments/assets/82748d53-c1e8-4c06-9888-254eb2ec253a" />

#### 7. Set Network and Security

- **VPC**: Select your Virtual Private Cloud
- **Subnet Group**: Choose a Redshift subnet group
- **VPC Security Group**: Ensure port 5439 is open to your IP
- **Give Proper IAM roles**

<img width="1423" alt="image" src="https://github.com/user-attachments/assets/3ebb4bfd-ca93-47f1-a9f7-7246374847b0" />
<img width="1345" alt="image" src="https://github.com/user-attachments/assets/873ac542-8456-45a3-8ed0-8ff9b0ce9364" />


#### 8. Review and Launch
- Review all configurations
- Click **“Create cluster”**

<img width="1568" alt="image" src="https://github.com/user-attachments/assets/350a2325-406d-4489-b46b-7fb7b09a6858" />

#### 9. Create Schema and table

<img width="1178" alt="image" src="https://github.com/user-attachments/assets/836066e7-b14c-4357-8196-188cb0d11422" />

```
USE dev;

CREATE SCHEMA movies; 

CREATE TABLE movies.imdb_movies_rating (
    Poster_Link VARCHAR(MAX),
    Series_Title VARCHAR(MAX),
    Released_Year VARCHAR(10),
    Certificate VARCHAR(50),
    Runtime VARCHAR(50),
    Genre VARCHAR(200),
    IMDB_Rating DECIMAL(10,2),
    Overview VARCHAR(MAX),
    Meta_score INT,
    Director VARCHAR(200),
    Star1 VARCHAR(200),
    Star2 VARCHAR(200),
    Star3 VARCHAR(200),
    Star4 VARCHAR(200),
    No_of_Votes INT,
    Gross VARCHAR(20)
);
```



### Create Glue Crawlers

1. Create a Glue Role

<img width="1606" alt="image" src="https://github.com/user-attachments/assets/7520044d-0970-45e6-a7a4-ff0207306cdb" />

2. Create Data Connections

    - For RedShift
      - For Redshift, transformation of data leads to creation of intermediate files which needs to be stored in the S3. Thats why we need to create
        a S3 endpoint which the redshift will have access too.
        <img width="1443" alt="image" src="https://github.com/user-attachments/assets/284ddafa-48f0-4fd9-ba5c-4908a10a39aa" />
        <img width="1043" alt="image" src="https://github.com/user-attachments/assets/a7eb5c2d-af7c-4951-9ce1-088f403e6674" />

      - Click on Connection and choose JDBC
      <img width="1307" alt="image" src="https://github.com/user-attachments/assets/4048d7b2-1091-419a-992d-cb6b4259db85" />
      - Copy the Redshift JDBC URL
      <img width="1572" alt="image" src="https://github.com/user-attachments/assets/8f4026f8-6e22-48a7-8d68-ff4c5d88aa26" />
      - Enter the required details
      - In the network, choose the redshift vpc
      <img width="1069" alt="image" src="https://github.com/user-attachments/assets/49baaab1-a06e-44a0-b82b-9ca2b3381191" />
      - Review and Create
      <img width="1689" alt="image" src="https://github.com/user-attachments/assets/470d003b-858d-4650-863a-8a3019429736" />

3. Test Connections and choose the `glue-role` option

<img width="1410" alt="image" src="https://github.com/user-attachments/assets/680179bd-307b-4a62-ac71-ace84ee8b4c7" />

<img width="1108" alt="image" src="https://github.com/user-attachments/assets/981091f9-ce1f-4dc9-b2f2-3ee98501c285" />

<img width="1057" alt="image" src="https://github.com/user-attachments/assets/71a5993c-7e09-49e4-9cc9-8049d43ad606" />

4. Create Glue Databases
   This acts as a catelog for the files in the S3 as well as for the tables in Redshift.
   <img width="1706" alt="image" src="https://github.com/user-attachments/assets/0a1078a0-b826-4657-8ea1-2f5b655114bf" />

6. Create 2 crawler. One to crawl the S3 bucket and the other to crawl the redshift datawarehouse table.

   Crawler - 1
   <img width="1675" alt="image" src="https://github.com/user-attachments/assets/05d455a7-6d39-4130-919a-05fc3316ac21" />

   Crawler - 2
   <img width="1678" alt="image" src="https://github.com/user-attachments/assets/541233ed-bbdc-4ba3-8c03-bee860cbb8ab" />
7. Run the crawlers.

<img width="1392" alt="image" src="https://github.com/user-attachments/assets/f2b37aad-1e92-4466-8069-a465a68be671" />

![image](https://github.com/user-attachments/assets/686d48c9-82f0-478d-ba5d-cd46344c4026)
![image](https://github.com/user-attachments/assets/b472905d-fcd5-4968-9bf5-741bd28c89f8)



8. 





## Results

1. Uploaded the data in the input folder of the S3 bucket

<img width="1670" alt="image" src="https://github.com/user-attachments/assets/79f2b3ca-2a34-4c43-941b-a6cb6dda4343" />

2. 
3. 


