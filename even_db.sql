USE [master]
GO
/****** Object:  Database [even]    Script Date: 4/25/2021 3:07:43 PM ******/
CREATE DATABASE [even]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'even', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\even.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'even_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\even_log.ldf' , SIZE = 1449984KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [even] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [even].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [even] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [even] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [even] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [even] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [even] SET ARITHABORT OFF 
GO
ALTER DATABASE [even] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [even] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [even] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [even] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [even] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [even] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [even] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [even] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [even] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [even] SET  DISABLE_BROKER 
GO
ALTER DATABASE [even] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [even] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [even] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [even] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [even] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [even] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [even] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [even] SET RECOVERY FULL 
GO
ALTER DATABASE [even] SET  MULTI_USER 
GO
ALTER DATABASE [even] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [even] SET DB_CHAINING OFF 
GO
ALTER DATABASE [even] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [even] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [even] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [even] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'even', N'ON'
GO
ALTER DATABASE [even] SET QUERY_STORE = OFF
GO
USE [even]
GO
/****** Object:  User [test]    Script Date: 4/25/2021 3:07:43 PM ******/
CREATE USER [test] FOR LOGIN [test] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [test]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [test]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [test]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [test]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [test]
GO
ALTER ROLE [db_datareader] ADD MEMBER [test]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [test]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [test]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [test]
GO
/****** Object:  Table [dbo].[clicks]    Script Date: 4/25/2021 3:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clicks](
	[rate_table_offer_id] [bigint] NOT NULL,
	[num_clicks] [smallint] NULL,
	[last_click] [bigint] NULL,
	[first_click] [bigint] NULL,
 CONSTRAINT [PK_clicks] PRIMARY KEY CLUSTERED 
(
	[rate_table_offer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leads]    Script Date: 4/25/2021 3:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leads](
	[lead_uuid] [uniqueidentifier] NOT NULL,
	[requested] [int] NULL,
	[state] [varchar](2) NULL,
	[loan_purpose] [varchar](100) NULL,
	[credit] [varchar](100) NULL,
	[annual_income] [int] NULL,
	[is_employed] [varchar](50) NULL,
	[monthly_net_income] [int] NULL,
	[mortgage_property_type] [varchar](50) NULL,
	[has_mortgage] [varchar](50) NULL,
	[zipcode] [varchar](10) NULL,
	[lead_created_at] [bigint] NULL,
	[index_level_0] [int] NULL,
 CONSTRAINT [PK_leads] PRIMARY KEY CLUSTERED 
(
	[lead_uuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rate_tables]    Script Date: 4/25/2021 3:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rate_tables](
	[lead_uuid] [uniqueidentifier] NOT NULL,
	[rate_table_id] [bigint] NOT NULL,
	[rate_table_offer_id] [bigint] NOT NULL,
	[rate_table_offer_created_at] [bigint] NULL,
	[offer_apr] [numeric](18, 2) NULL,
	[offer_fee_fixed] [numeric](18, 2) NULL,
	[offer_fee_rate] [numeric](18, 0) NULL,
	[offer_monthly_payment] [numeric](18, 2) NULL,
	[offer_rec_score] [int] NULL,
	[offer_rank_on_table] [smallint] NULL,
	[demand_sub_account_id] [int] NULL,
	[index_level_0] [int] NULL,
 CONSTRAINT [PK_rate_tables] PRIMARY KEY CLUSTERED 
(
	[lead_uuid] ASC,
	[rate_table_id] ASC,
	[rate_table_offer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[rate_tables]  WITH CHECK ADD  CONSTRAINT [FK_rate_tables_leads] FOREIGN KEY([lead_uuid])
REFERENCES [dbo].[leads] ([lead_uuid])
GO
ALTER TABLE [dbo].[rate_tables] CHECK CONSTRAINT [FK_rate_tables_leads]
GO
/****** Object:  StoredProcedure [dbo].[get_lead_dataset]    Script Date: 4/25/2021 3:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure  [dbo].[get_lead_dataset](@lu uniqueidentifier)
as
  SELECT  A.[lead_uuid]     
	   ,rate_table_id
	    ,A.[rate_table_offer_id]
		 ,[offer_apr]
		  ,[offer_monthly_payment]
      ,[requested]
      ,[state]
      ,[loan_purpose]
      ,[credit]
      ,[annual_income]
      ,[is_employed]
      ,[monthly_net_income]
      ,[mortgage_property_type]
      ,[has_mortgage]
      ,[zipcode]
      ,[lead_created_at]
      ,A.[index_level_0]	  
      ,[rate_table_id]      
      ,[rate_table_offer_created_at]     
      ,[offer_fee_fixed]
      ,[offer_fee_rate]     
      ,[offer_rec_score]
      ,[offer_rank_on_table]
      ,[demand_sub_account_id]
      ,B.[index_level_0]	  
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
GO
/****** Object:  StoredProcedure [dbo].[get_lead_statistics]    Script Date: 4/25/2021 3:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure  [dbo].[get_lead_statistics](@lu uniqueidentifier)
as
  WITH CTE as (
  SELECT offer_apr,
         lead_uuid,
	RANK() OVER (PARTITION BY lead_uuid	ORDER BY   offer_apr asc ) row_num
  FROM [even].[dbo].[rate_tables]
  ), 
  
  demandCTE as
  (SELECT 
         lead_uuid,		 
		 count(distinct demand_sub_account_id) tot_demand_sub	
  FROM [even].[dbo].[rate_tables]  
  group by lead_uuid  
  )
   
  Select  distinct offer_apr,
             tot_demand_sub,	 
         a.lead_uuid
  From   cte A
  join demandCTE B
  on A.lead_uuid = B.lead_uuid
  WHERE  row_num = 1
  and a.lead_uuid = @lu 
GO
USE [master]
GO
ALTER DATABASE [even] SET  READ_WRITE 
GO
