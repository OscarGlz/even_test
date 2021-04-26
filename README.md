## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Challenges](#challenges)
* [Support](#support)

## General info
Code challenge consisting in processing parquet files, load them a database and make the data available via API.
	
## Technologies
Project was created with (in order of use):
* SQL Server: 15.02
* Talend: 7.3.1
* Python: 3.8.6
* PyCharm: 2020:3

API Testing:
* Postman: 8.2.3
	
## Setup
* Python packages can be imported using below requirements.txt file

[requirements file](https://github.com/OscarGlz/even_test/blob/main/requirements.txt)

From command line execute

```shell
  pip install -r requirements.txt
```
* Talend job needs to be imported into Talend as show below in the menu and then, select attached file.

[Talend job file](https://github.com/OscarGlz/even_test/blob/main/talend_job.zip)

![Talend Import](https://github.com/OscarGlz/even_test/blob/main/ImportTalend.PNG)

* The Database can be created by executing the DB script in SQL Server. It contains tables, stored procedures and user.

[Database script file](https://github.com/OscarGlz/even_test/blob/main/even_db.sql)

## Challenges

#### Challenge 1
The first step was to create a database diagram in order to accomodate the information from the parquet files.

From the <b>rate_tables</b> table, we found that not all the <b>rate_table_offer_id</b> rows were in the <b>click</b> table. That is the reason why we did not create a FK from <b>clicks</b> table, the alternative was to error out those records with no match in <b>click</b> table. Finally, the relationship is 1 to 1, meaning that <b>click</b> table can be merged with <b>rate_tables</b> table. For the sake of simplicity in the exercise, we decided to leave them apart so there is no need to stich the data together.

![Database Diagram](https://github.com/OscarGlz/even_test/blob/main/DBDiagram.PNG)

#### Challenge 2
The file parse and bulk load into the DB (SQL server) was done using Talend Open Studio. A pipeline was created for this purpose which took less than 7 sec to load the information. Talend will run in any OS as long as the parameter in the path is adjusted.

![Talend pipeline](https://github.com/OscarGlz/even_test/blob/main/Talend.PNG)

#### Challenge 3
The REST API end point to retrieve the full dataset associated with a single lead_uuid in JSON format, was created using Python in PyCharm (it can run in any OS). In order to keep the code compact, a stored procedure was created in the DB that is called with the  <b>get</b>.

In this script from the Select in the stored procedure. You can notice the left join to the <b>click</b> table and since not all the records has a corresponding value in that table. Also, even thought the stored procedure is prepare to get all the fields, the json only have a few fields in order to keep the code compact.

```sql
SELECT  A.[lead_uuid]     
	,rate_table_id
      ,A.[rate_table_offer_id]
      ,[offer_apr]
      ,[offer_monthly_payment]
      ,[requested]
      ...
      ,[num_clicks]
      ,[last_click]
      ,[first_click]
  FROM [even].[dbo].[rate_tables] A
   JOIN [even].[dbo].[leads] B
  on A.lead_uuid = B.lead_uuid
   LEFT JOIN [even].[dbo].[clicks] C
  on A.[rate_table_offer_id] = C.[rate_table_offer_id]
  WHERE  A.[lead_uuid] = @lu
  order by [offer_monthly_payment] asc
```

[Python script](https://github.com/OscarGlz/even_test/blob/main/main.py)

The End point example is:
http://127.0.0.1:5000/detail/<lead_uuid>

![postman11](https://github.com/OscarGlz/even_test/blob/main/postman11.PNG)

Additionally, the End point validates that the lead_uuid format is valid. 

![postman12](https://github.com/OscarGlz/even_test/blob/main/postman12.PNG)

And lead_uuid exists in the DB.
![postman13](https://github.com/OscarGlz/even_test/blob/main/postman13.PNG)


#### Challenge 4
The second REST API endpoint that provides certain statistics for a given lead_uuid is calling a stored procedure and has the same validations as the previous one.

The stored procedure is prepared to get ALL the lead_uuid but it will return at this moment just one. For this, a window function was used with partition by lead_uuid.

```sql
 WITH CTE as (
  SELECT offer_apr,
         lead_uuid,
	RANK() OVER (PARTITION BY lead_uuid	ORDER BY   offer_apr asc ) row_num
  FROM [even].[dbo].[rate_tables]
  )
```
The End point example is:
http://127.0.0.1:5000/stats/<lead_uuid>

![postman21](https://github.com/OscarGlz/even_test/blob/main/postman21.PNG)


## Support
Got questions? send an email to ogoz00@hotmail.com


