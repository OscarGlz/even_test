## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Challenges](#challenges)
* [Support](#support)

## General info
Code challenge consisting in processing parquet files, load them a database and make the data available via API.
	
## Technologies
Project is created with:
* Talend: 7.3.1
* Python: 3.8.6
* SQL Server: 15.02
* PyCharm: 2020:3

API Testing:
* Postman: 8.2.3

	
## Setup
To run this project, install it locally using npm:

## Challenges

#### Challenge 1
The first step was to create a database diagram in order to accomodate the information from the parquet files.

From the <b>rate_tables</b> table we found that not all the <b>rate_table_offer_id</b> rows were in the <b>click</b> table. That is the reason why we did not create a FK from <b>clicks</b> table, the alternative was to error out those records with no match in <b>click</b> table. Finally, the relationship is 1 to 1, meaning that <b>click</b> table can be merged with <b>rate_tables</b> table.

![Database Diagram](https://github.com/OscarGlz/even_test/blob/main/DBDiagram.PNG)

#### Challenge 2
The file parse and bulk load into the DB (SQL server) was done using Talend Open Studio. A pipe line was created for this purpose which took less than 7 sec to load the information.

[Database script](https://github.com/OscarGlz/even_test/blob/main/even_db.sql)

![Talend pipeline](https://github.com/OscarGlz/even_test/blob/main/Talend.PNG)

#### Challenge 3
The REST API end point to retrieve the full dataset associated with a single lead_uuid in JSON format, was created using Python in PyCharm. In order to keep the code compact, a stored procedure was created in the DB that is called with the get.

The End point example is:
http://127.0.0.1:5000/detail/<lead_uuid>

![postman11](https://github.com/OscarGlz/even_test/blob/main/postman11.PNG)

Additionally, the End point validates that the lead_uuid format is valid. 

![postman12](https://github.com/OscarGlz/even_test/blob/main/postman12.PNG)

And lead_uuid exists in the DB.
![postman13](https://github.com/OscarGlz/even_test/blob/main/postman13.PNG)


#### Challenge 4
The second REST API endpoint that provides certain statistics for a given lead_uuid is calling a stored procedure and has the same validations as the previous one.

![postman21](https://github.com/OscarGlz/even_test/blob/main/postman21.PNG)


## Support
Got questions? send an email to ogoz00@hotmail.com


