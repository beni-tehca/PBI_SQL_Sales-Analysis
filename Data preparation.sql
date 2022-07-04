/* 

Cleansing Data in SQL Queries

*/
-- Cleansing DIM_Date
SELECT 
  [DateKey], 
  [FullDateAlternateKey] As Date,
  --,[DayNumberOfWeek], 
  [EnglishDayNameOfWeek] as Day,
  --,[SpanishDayNameOfWeek]
  --,[FrenchDayNameOfWeek]
  --,[DayNumberOfMonth]
  --,[DayNumberOfYear], 
  [WeekNumberOfYear] As WeekNo, 
  [EnglishMonthName] AS Month,
  LEFT(EnglishMonthName,3) As MonthShort,
  --,[SpanishMonthName]
  --,[FrenchMonthName], 
  [MonthNumberOfYear] As MonthNo, 
  [CalendarQuarter] As Quarter, 
  [CalendarYear] As Year
  --,[CalendarSemester]
  --,[FiscalQuarter]
  --,[FiscalYear]
  --,[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]
WHERE 
  CalendarYear >= 2020

  --Cleansing DIM_Customer

SELECT 
  [CustomerKey] AS CustomerKey, 
  --,[GeographyKey]
  --,[CustomerAlternateKey]
  --,[Title]
  [FirstName] AS [First Name] 
  --,[MiddleName]
  ,[LastName] AS [Last Name], 
  Cust.FirstName + ' ' + Cust.LastName As [Full Name], 
  --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix]
  CASE when Cust.Gender = 'M' then 'Male' when Cust.Gender = 'F' then 'Female' End As Gender 
  --,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  --,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  ,cust.DateFirstPurchase, 
  --,[CommuteDistance]
  Geo.City AS [Customer City] -- Joined in Customer City from Geography Table
FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] AS Cust 
  Left join AdventureWorksDW2019..DimGeography AS Geo on Cust.GeographyKey = Geo.GeographyKey 
ORDER BY 
  CustomerKey ASC -- Ordered List by CustomerKey


  --Cleansing DIM_Product

  SELECT 
   Pro.ProductKey, 
  Pro.ProductAlternateKey AS ProductItemCode, 
  --      ,[ProductSubcategoryKey], 
  --      ,[WeightUnitMeasureCode]
  --      ,[SizeUnitMeasureCode] 
  Pro.EnglishProductName AS [Product Name], 
  Sub.EnglishProductSubcategoryName AS [Sub Category], -- Joined in from Sub Category Table
  Cat.EnglishProductCategoryName AS [Product Category], -- Joined in from Category Table
  --      ,[SpanishProductName]
  --      ,[FrenchProductName]
  --      ,[StandardCost]
  --      ,[FinishedGoodsFlag] 
  Pro.[Color] AS [Product Color], 
  --      ,[SafetyStockLevel]
  --      ,[ReorderPoint]
  --      ,[ListPrice] 
  Pro.[Size] AS [Product Size], 
  --      ,[SizeRange]
  --      ,[Weight]
  --      ,[DaysToManufacture]
  Pro.[ProductLine] AS [Product Line], 
  --     ,[DealerPrice]
  --      ,[Class]
  --      ,[Style] 
  Pro.[ModelName] AS [Product Model Name], 
  --      ,[LargePhoto]
  Pro.[EnglishDescription] AS [Product Description], 
  --      ,[FrenchDescription]
  --      ,[ChineseDescription]
  --      ,[ArabicDescription]
  --      ,[HebrewDescription]
  --      ,[ThaiDescription]
  --      ,[GermanDescription]
  --      ,[JapaneseDescription]
  --      ,[TurkishDescription]
  --      ,[StartDate], 
  --      ,[EndDate],
  --      ,Pro.Status AS [Product Status], 
  ISNULL (Pro.Status, 'Outdated') AS [Product Status] 
FROM 
  [AdventureWorksDW2019]..[DimProduct] as Pro
  LEFT JOIN AdventureWorksDW2019..DimProductSubcategory AS Sub ON Pro.ProductSubcategoryKey = Sub.ProductSubcategoryKey
  LEFT JOIN AdventureWorksDW2019..DimProductCategory AS Cat ON Sub.ProductCategoryKey = Cat.ProductCategoryKey 
order by 
  Pro.ProductKey asc


  -- Cleansed FACT_InternetSales Table --
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey], 
  --  ,[PromotionKey]
  --  ,[CurrencyKey]
  --  ,[SalesTerritoryKey]
  [SalesOrderNumber], 
  --  [SalesOrderLineNumber], 
  --  ,[RevisionNumber]
  --  ,[OrderQuantity], 
  --  ,[UnitPrice], 
  --  ,[ExtendedAmount]
  --  ,[UnitPriceDiscountPct]
  --  ,[DiscountAmount] 
  --  ,[ProductStandardCost]
  --  ,[TotalProductCost] 
  [SalesAmount] --  ,[TaxAmt]
  --  ,[Freight]
  --  ,[CarrierTrackingNumber] 
  --  ,[CustomerPONumber] 
  --  ,[OrderDate] 
  --  ,[DueDate] 
  --  ,[ShipDate] 
FROM 
  [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE 
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) - 2 -- Ensures we always only bring two years of date from extraction.
ORDER BY
  OrderDateKey ASC



