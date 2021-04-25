## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Process](#process)

## General info
Code challenge consisting in processing parquet files, load them a database and make the data available via API.
	
## Technologies
Project is created with:
* Talend: 7.3.1
* Python: 3.8.6
* SQL Server: 15.02

	
## Setup
To run this project, install it locally using npm:

## Process

# Challenge 1
The first step was to create a database diagram in order to accomodate the information from the parquet files.

From the rate_tables table we found that not all the rate_table_offer_id was in the click table. That is the reason why we did not create a FK from Clicks table, the alternative was to error out those records with no match in Click table. Finally, the relationship is 1 to 1, meaning that click can be merged with rate_tables table.

![Database Diagram](https://github.com/OscarGlz/even_test/blob/main/DBDiagram.PNG)

# Challenge 2
The file parse and bulk load into the DB (SQL server) was done using Talend Open Studio. A pipe line was created for this purpose which took less than 7 sec to load the information.
![Talend pipeline](https://github.com/OscarGlz/even_test/blob/main/Talend.PNG)

