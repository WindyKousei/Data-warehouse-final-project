-- Create SakilaDW
IF NOT EXISTS (SELECT * FROM [sys].[databases] WHERE [name] = 'SakilaDW') CREATE DATABASE [SakilaDW]

-- Drop foreign keys
DECLARE @SQL NVARCHAR(MAX) = ''
SELECT @SQL =
	@SQL
	+ 'ALTER TABLE '
	+ QUOTENAME(OBJECT_NAME([parent_object_id]))
	+ ' DROP CONSTRAINT '
	+ QUOTENAME([name])
	+ ';'
FROM [sys].[foreign_keys]
EXEC (@SQL)

-- Create DimDate
IF OBJECT_ID('dbo.DimDate') IS NOT NULL DROP TABLE [dbo].[DimDate]

CREATE TABLE [dbo].[DimDate] (
	[DateKey] INT PRIMARY KEY,
	[Date] DATE NOT NULL,
	[DayNumberOfWeek] TINYINT NOT NULL,
	[DayNameOfWeek] NVARCHAR(10) NOT NULL,
	[DayNumberOfMonth] TINYINT NOT NULL,
	[DayNumberOfYear] SMALLINT NOT NULL,
	[IsWeekend] NCHAR(1) NOT NULL,
	[WeekNumberOfYear] TINYINT NOT NULL,
	[MonthName] NVARCHAR(10) NOT NULL,
	[MonthNumberOfYear] TINYINT NOT NULL,
	[CalendarQuarter] TINYINT NOT NULL,
	[CalendarYear] SMALLINT NOT NULL,
	[CalendarSemester] TINYINT NOT NULL,
	[FiscalQuarter] TINYINT NOT NULL,
	[FiscalYear] SMALLINT NOT NULL,
	[FiscalSemester] TINYINT NOT NULL
)

-- Populate DimDate (Use the attached Populate DimDate.sql file)

-- Create DimTime
IF OBJECT_ID('dbo.DimTime') IS NOT NULL DROP TABLE [dbo].[DimTime]

CREATE TABLE [dbo].[DimTime] (
	[TimeKey] INT PRIMARY KEY,
	[FullTime] TIME(7) NOT NULL,
	[FullTimeString] NVARCHAR(8) NOT NULL,
	[Hour] TINYINT NOT NULL,
	[HourMinString] NVARCHAR(5) NOT NULL,
	[HourFullString] NVARCHAR(8) NOT NULL,
	[Minute] TINYINT NOT NULL,
	[MinuteFullString] NVARCHAR(8) NOT NULL,
	[Second] TINYINT NOT NULL
)

-- Populate DimTime (Use the attached Populate DimTime.sql file)

-- Create DimFilm
IF OBJECT_ID('dbo.DimFilm') IS NOT NULL DROP TABLE [dbo].[DimFilm]

CREATE TABLE [dbo].[DimFilm] (
	[FilmKey] INT IDENTITY(1,1) PRIMARY KEY,
	[FilmID] INT NOT NULL,
	[FilmTitle] NVARCHAR(255) NOT NULL,
	[FilmDescription] NVARCHAR(255) NOT NULL,
	[FilmReleaseYear] NVARCHAR(4) NOT NULL,
	[FilmLanguage] NVARCHAR(20) NOT NULL,
	[FilmRentalDuration] TINYINT NOT NULL,
	[FilmRentalRate] DECIMAL(4,2) NOT NULL,
	[FilmLength] SMALLINT NOT NULL,
	[FilmReplacementCost] DECIMAL(5,2) NOT NULL,
	[FilmRating] NVARCHAR(5) NOT NULL,
	[HasTrailer] NCHAR(1) NOT NULL,
	[HasCommentary] NCHAR(1) NOT NULL,
	[HasDeletedScene] NCHAR(1) NOT NULL,
	[HasBehindTheScene] NCHAR(1) NOT NULL,
	[IsCategoryAction] NCHAR(1) NOT NULL,
	[IsCategoryAdventure] NCHAR(1) NOT NULL,
	[IsCategoryAnimation] NCHAR(1) NOT NULL,
	[IsCategoryComedy] NCHAR(1) NOT NULL,
	[IsCategoryDocumentary] NCHAR(1) NOT NULL,
	[IsCategoryDrama] NCHAR(1) NOT NULL,
	[IsCategoryFantasy] NCHAR(1) NOT NULL,
	[IsCategoryHistorical] NCHAR(1) NOT NULL,
	[IsCategoryHorror] NCHAR(1) NOT NULL,
	[IsCategoryMusical] NCHAR(1) NOT NULL,
	[IsCategoryNoir] NCHAR(1) NOT NULL,
	[IsCategoryRomance] NCHAR(1) NOT NULL,
	[IsCategorySciFi] NCHAR(1) NOT NULL,
	[IsCategorySports] NCHAR(1) NOT NULL,
	[IsCategoryThriller] NCHAR(1) NOT NULL,
	[IsCategoryWestern] NCHAR(1) NOT NULL
)

-- Create DimActor
IF OBJECT_ID('dbo.DimActor') IS NOT NULL DROP TABLE [dbo].[DimActor]

CREATE TABLE [dbo].[DimActor] (
	[ActorKey] INT IDENTITY(1,1) PRIMARY KEY,
	[ActorID] INT NOT NULL,
	[ActorFirstName] NVARCHAR(50) NOT NULL,
	[ActorLastName] NVARCHAR(50) NOT NULL,
	[ActorFullName] NVARCHAR(50) NOT NULL,
)

-- Create DimFilmActorBridge
IF OBJECT_ID('dbo.DimFilmActorBridge') IS NOT NULL DROP TABLE [dbo].[DimFilmActorBridge]

CREATE TABLE [dbo].[DimFilmActorBridge] (
	[ActorKey] INT NOT NULL,
	[FilmKey] INT NOT NULL,
	PRIMARY KEY CLUSTERED ([ActorKey], [FilmKey])
)

ALTER TABLE [dbo].[DimFilmActorBridge]
ADD CONSTRAINT [FK_DimFilmActorBridge_FilmKey] FOREIGN KEY (FilmKey)
REFERENCES [dbo].[DimFilm] ([FilmKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[DimFilmActorBridge]
ADD CONSTRAINT [FK_DimFilmActorBridge_ActorKey] FOREIGN KEY (ActorKey)
REFERENCES [dbo].[DimActor] ([ActorKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

-- Create DimCustomer
IF OBJECT_ID('dbo.DimCustomer') IS NOT NULL DROP TABLE [dbo].[DimCustomer]

CREATE TABLE [dbo].[DimCustomer] (
	[CustomerKey] INT IDENTITY(1,1) PRIMARY KEY,
	[CustomerID] INT NOT NULL,
	[CustomerFirstName] NVARCHAR(50) NOT NULL,
	[CustomerLastName] NVARCHAR(50) NOT NULL,
	[CustomerFullName] NVARCHAR(50) NOT NULL,
	[CustomerEmail] NVARCHAR(50) NOT NULL,
	[CustomerAddress] NVARCHAR(50) NOT NULL,
	[CustomerAddress2] NVARCHAR(50) NOT NULL,
	[CustomerDistrict] NVARCHAR(20) NOT NULL,
	[CustomerCity] NVARCHAR(50) NOT NULL,
	[CustomerCountry] NVARCHAR(50) NOT NULL,
	[CustomerPostalCode] NVARCHAR(10) NOT NULL,
	[CustomerPhone] NVARCHAR(20) NOT NULL,
	[IsActive] NCHAR(1) NOT NULL
)

-- Create DimStaff
IF OBJECT_ID('dbo.DimStaff') IS NOT NULL DROP TABLE [dbo].[DimStaff]

CREATE TABLE [dbo].[DimStaff] (
	[StaffKey] INT IDENTITY(1,1) PRIMARY KEY,
	[StaffID] INT NOT NULL,
	[StaffFirstName] NVARCHAR(50) NOT NULL,
	[StaffLastName] NVARCHAR(50) NOT NULL,
	[StaffFullName] NVARCHAR(50) NOT NULL,
	[StaffEmail] NVARCHAR(50) NOT NULL,
	[StaffAddress] NVARCHAR(50) NOT NULL,
	[StaffAddress2] NVARCHAR(50) NOT NULL,
	[StaffDistrict] NVARCHAR(20) NOT NULL,
	[StaffCity] NVARCHAR(50) NOT NULL,
	[StaffCountry] NVARCHAR(50) NOT NULL,
	[StaffPostalCode] NVARCHAR(10) NOT NULL,
	[StaffPhone] NVARCHAR(20) NOT NULL,
	[IsActive] NCHAR(1) NOT NULL,
	[IsStoreManager] NCHAR(1) NOT NULL,
	[StaffUsername] NVARCHAR(50) NOT NULL,
	[StaffPassword] NVARCHAR(50) NOT NULL
)

-- Create DimStore
IF OBJECT_ID('dbo.DimStore') IS NOT NULL DROP TABLE [dbo].[DimStore]

CREATE TABLE [dbo].[DimStore] (
	[StoreKey] INT IDENTITY(1,1) PRIMARY KEY,
	[StoreID] INT NOT NULL,
	[StoreAddress] NVARCHAR(50) NOT NULL,
	[StoreAddress2] NVARCHAR(50) NOT NULL,
	[StoreDistrict] NVARCHAR(20) NOT NULL,
	[StoreCity] NVARCHAR(50) NOT NULL,
	[StoreCountry] NVARCHAR(50) NOT NULL,
	[StorePostalCode] NVARCHAR(10) NOT NULL,
	[StorePhone] NVARCHAR(20) NOT NULL,
	[StoreManager] NVARCHAR(50) NOT NULL
)

-- Create FactPayment
IF OBJECT_ID('dbo.FactPayment') IS NOT NULL DROP TABLE [dbo].[FactPayment]

CREATE TABLE [dbo].[FactPayment] (
	[CustomerKey] INT NOT NULL,
	[FilmKey] INT NOT NULL,
	[StoreKey] INT NOT NULL,
	[StaffKey] INT NOT NULL,
	[PaymentDateKey] INT NOT NULL,
	[PaymentTimeKey] INT NOT NULL,
	[RentalDateKey] INT NOT NULL,
	[RentalTimeKey] INT NOT NULL,
	[ReturnDateKey] INT,
	[ReturnTimeKey] INT,
	[MaximumRentalDuration] TINYINT NOT NULL,
	[RentalRate] DECIMAL(4,2) NOT NULL,
	[TotalAmountPaid] DECIMAL(5,2) NOT NULL,
	[LateDuration] TINYINT NOT NULL,
	[TotalLateFee] DECIMAL(4,2) NOT NULL
)

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_CustomerKey] FOREIGN KEY (CustomerKey)
REFERENCES [dbo].[DimCustomer] ([CustomerKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_FilmKey] FOREIGN KEY (FilmKey)
REFERENCES [dbo].[DimFilm] ([FilmKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_StoreKey] FOREIGN KEY (StoreKey)
REFERENCES [dbo].[DimStore] ([StoreKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_StaffKey] FOREIGN KEY (StaffKey)
REFERENCES [dbo].[DimStaff] ([StaffKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_PaymentDateKey] FOREIGN KEY (PaymentDateKey)
REFERENCES [dbo].[DimDate] ([DateKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_PaymentTimeKey] FOREIGN KEY (PaymentTimeKey)
REFERENCES [dbo].[DimTime] ([TimeKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_RentalDateKey] FOREIGN KEY (RentalDateKey)
REFERENCES [dbo].[DimDate] ([DateKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_RentalTimeKey] FOREIGN KEY (RentalTimeKey)
REFERENCES [dbo].[DimTime] ([TimeKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_ReturnDateKey] FOREIGN KEY (ReturnDateKey)
REFERENCES [dbo].[DimDate] ([DateKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactPayment]
ADD CONSTRAINT [FK_FactPayment_ReturnTimeKey] FOREIGN KEY (ReturnTimeKey)
REFERENCES [dbo].[DimTime] ([TimeKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

-- Create FactInventory
IF OBJECT_ID('dbo.FactInventory') IS NOT NULL DROP TABLE [dbo].[FactInventory]

CREATE TABLE [dbo].[FactInventory] (
	[FilmKey] INT NOT NULL,
	[StoreKey] INT NOT NULL,
	[DefaultStockLevel] TINYINT,
	[QuantityRented] TINYINT,
	[CurrentStockLevel] TINYINT
)

ALTER TABLE [dbo].[FactInventory]
ADD CONSTRAINT [FK_FactInventory_FilmKey] FOREIGN KEY (FilmKey)
REFERENCES [dbo].[DimFilm] ([FilmKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

ALTER TABLE [dbo].[FactInventory]
ADD CONSTRAINT [FK_FactInventory_StoreKey] FOREIGN KEY (StoreKey)
REFERENCES [dbo].[DimStore] ([StoreKey])
ON UPDATE NO ACTION
ON DELETE NO ACTION

-- Create SakilaSTG
IF NOT EXISTS (SELECT * FROM [sys].[databases] WHERE [name] = 'SakilaSTG') CREATE DATABASE [SakilaSTG]