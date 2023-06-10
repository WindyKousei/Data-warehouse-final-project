-- Truncate or Create ActorSTG
IF OBJECT_ID('dbo.ActorSTG') IS NOT NULL TRUNCATE TABLE [dbo].[ActorSTG]
ELSE CREATE TABLE [dbo].[ActorSTG] (
	[actor_id] INT,
	[first_name] NVARCHAR(50),
	[last_name] NVARCHAR(50)
)

-- Truncate or Create FilmSTG
IF OBJECT_ID('dbo.FilmSTG') IS NOT NULL TRUNCATE TABLE [dbo].[FilmSTG]
ELSE CREATE TABLE [dbo].[FilmSTG] (
	[film_id] INT,
	[title] NVARCHAR(255),
	[description] NVARCHAR(255),
	[release_year] NVARCHAR(4),
	[language] NVARCHAR(20),
	[rental_duration] TINYINT,
	[rental_rate] NUMERIC(4,2),
	[length] SMALLINT,
	[replacement_cost] NUMERIC(5,2),
	[rating] NVARCHAR(5),
	[special_features] NVARCHAR(255),
	[category] NVARCHAR(255)
)

-- Truncate or Create DimStore
IF OBJECT_ID('dbo.StoreSTG') IS NOT NULL TRUNCATE TABLE [dbo].[StoreSTG]
ELSE CREATE TABLE [dbo].[StoreSTG] (
	[store_id] INT,
	[address] NVARCHAR(50),
	[address2] NVARCHAR(50),
	[district] NVARCHAR(20),
	[city] NVARCHAR(50),
	[country] NVARCHAR(50),
	[postal_code] NVARCHAR(10),
	[phone] NVARCHAR(20),
	[manager_first_name] NVARCHAR(50),
	[manager_last_name] NVARCHAR(50)
)

-- Truncate or Create DimCustomer
IF OBJECT_ID('dbo.CustomerSTG') IS NOT NULL TRUNCATE TABLE [dbo].[CustomerSTG]
ELSE CREATE TABLE [dbo].[CustomerSTG] (
	[customer_id] INT,
	[first_name] NVARCHAR(50),
	[last_name] NVARCHAR(50),
	[email] NVARCHAR(50),
	[address] NVARCHAR(50),
	[address2] NVARCHAR(50),
	[district] NVARCHAR(20),
	[city] NVARCHAR(50),
	[country] NVARCHAR(50),
	[postal_code] NVARCHAR(10),
	[phone] NVARCHAR(20),
	[is_active] NVARCHAR(1)
)

-- Truncate or Create DimStaff
IF OBJECT_ID('dbo.StaffSTG') IS NOT NULL TRUNCATE TABLE [dbo].[StaffSTG]
ELSE CREATE TABLE [dbo].[StaffSTG] (
	[staff_id] INT,
	[first_name] NVARCHAR(50),
	[last_name] NVARCHAR(50),
	[email] NVARCHAR(50),
	[address] NVARCHAR(50),
	[address2] NVARCHAR(50),
	[district] NVARCHAR(20),
	[city] NVARCHAR(50),
	[country] NVARCHAR(50),
	[postal_code] NVARCHAR(10),
	[phone] NVARCHAR(20),
	[is_active] NVARCHAR(1),
	[manager_staff_id] TINYINT,
	[username] NVARCHAR(50),
	[password] NVARCHAR(50)
)

-- Truncate or Create DimFilmActorBridge
IF OBJECT_ID('dbo.FilmActorBridgeSTG') IS NOT NULL TRUNCATE TABLE [dbo].[FilmActorBridgeSTG]
ELSE CREATE TABLE [dbo].[FilmActorBridgeSTG] (
	[actor_id] INT,
	[film_id] INT
)

-- Truncate or Create InventorySTG, RentalSTG
IF OBJECT_ID('dbo.InventorySTG') IS NOT NULL TRUNCATE TABLE [dbo].[InventorySTG]
ELSE CREATE TABLE [dbo].[InventorySTG] (
	[inventory_id] INT,
	[film_id] INT,
	[store_id] INT
)

IF OBJECT_ID('dbo.RentalSTG') IS NOT NULL TRUNCATE TABLE [dbo].[RentalSTG]
ELSE CREATE TABLE [dbo].[RentalSTG] (
	[inventory_id] INT,
	[return_date] DATETIME
)

-- Truncate or Create PaymentSTG
IF OBJECT_ID('dbo.PaymentSTG') IS NOT NULL TRUNCATE TABLE [dbo].[PaymentSTG]
ELSE CREATE TABLE [dbo].[PaymentSTG] (
	[customer_id] INT,
	[film_id] INT,
	[store_id] INT,
	[staff_id] INT,
	[payment_date] DATETIME,
	[rental_date] DATETIME,
	[return_date] DATETIME,
	[total_amount_paid] NUMERIC(5,2)
)