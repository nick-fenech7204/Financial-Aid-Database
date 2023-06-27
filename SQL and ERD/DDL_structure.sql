USE master;

IF DB_ID('Financial_Aid') IS NOT NULL
BEGIN
    ALTER DATABASE Financial_Aid SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Financial_Aid;
END

GO

CREATE DATABASE Financial_Aid;

GO

USE Financial_Aid;

drop table if EXISTS [Subsidized Loans]

create TABLE [Subsidized Loans](
    subsidizedID INT PRIMARY KEY identity (1,1),
    [School Name] NVARCHAR(100) null,
    [Recipients_DL_Subsidized] bigint null,
    [Number of Loans Originated_DL_Subsidized] bigint null, 
    [Amount of Loans Originated_DL_Subsidized] bigint null, 
    [Number of Disbursements_DL_Subsidized] bigint null, 
    [Amount of Disbursements_DL_Subsidized] bigint null,
    [Year] date null
);

drop table if EXISTS [Unsubsidized Loans-Undergrad]

create TABLE [Unsubsidized Loans-Undergrad](
    unsubsidized_undergradID INT PRIMARY KEY identity (1,1),
    [School Name] NVARCHAR(100) null,
    [Recipients_DL_Unsubsidized_Undergrad] bigint null,
    [Number of Loans Originated_DL_Unsubsidized_Undergrad] bigint null, 
    [Amount of Loans Originated_DL_Unsubsidized_Undergrad] bigint null, 
    [Number of Disbursements_DL_Unsubsidized_Undergrad] bigint null, 
    [Amount of Disbursements_DL_Unsubsidized_Undergrad] bigint null,
    [Year] date null
);

drop table if EXISTS [Unsubsidized Loans-Graduate]

create TABLE [Unsubsidized Loans-Graduate](
    unsubsidized_graduateID INT PRIMARY KEY identity (1,1),
    [School Name] NVARCHAR(100) null,
    [Recipients_DL_Unsubsidized_Graduate] bigint null,
    [Number of Loans Originated_DL_Unsubsidized_Graduate] bigint null, 
    [Amount of Loans Originated_DL_Unsubsidized_Graduate] bigint null, 
    [Number of Disbursements_DL_Unsubsidized_Graduate] bigint null, 
    [Amount of Disbursements_DL_Unsubsidized_Graduate] bigint null,
    [Year] date null
);

drop table if EXISTS [Parent Plus Loan]

create TABLE [Parent Plus Loan](
    parent_plusID INT PRIMARY KEY identity (1,1),
    [School Name] NVARCHAR(100) null,
    [Recipients_DL_Parent_Plus] bigint null,
    [Number of Loans Originated_DL_Parent_Plus] bigint null, 
    [Amount of Loans Originated_DL_Parent_Plus] bigint null, 
    [Number of Disbursements_DL_Parent_Plus] bigint null, 
    [Amount of Disbursements_DL_Parent_Plus] bigint null,
    [Year] date null
);

drop table if EXISTS [Graduate Plus Loan]

create TABLE [Graduate Plus Loan](
    graduate_plusID INT PRIMARY KEY identity (1,1),
    [School Name] NVARCHAR(100) null,
    [Recipients_DL_Grad_Plus] bigint null,
    [Number of Loans Originated_DL_Grad_Plus] bigint null, 
    [Amount of Loans Originated_DL_Grad_Plus] bigint null, 
    [Number of Disbursements_DL_Grad_Plus] bigint null, 
    [Amount of Disbursements_DL_Grad_Plus] bigint null,
    [Year] date null
);

drop table if exists [Pell Grant]

create TABLE [Pell Grant](
    pell_grantID INT PRIMARY KEY identity (1,1),
    [School Name] NVARCHAR(100) null,
    [Pell Recipients] float null,
    [Pell Disbursements] float null,
    [Year] date null
);

drop table if exists [Location]

create TABLE [Location](
    locationID INT PRIMARY KEY identity (1,1),
    [State]  nvarchar(50) null
);

drop table if exists [Institution Type]

create TABLE [Institution Type](
    institution_typeID INT PRIMARY KEY identity (1,1),
    [School Type]  nvarchar(50) null,
);

drop table if exists [Institution]

CREATE TABLE Institution (
    institutionID INT PRIMARY KEY IDENTITY (1, 1),
    [OPE ID] NVARCHAR(50) NULL,
    [School Name] NVARCHAR(100) NULL, 
    [Year] DATE NULL, 
    [institution_typeID] INT NULL, 
    [locationID] INT NULL, 
    CONSTRAINT [fk_Main_Institution_institution_typeID]
        FOREIGN KEY (institution_typeID)
        REFERENCES [Institution Type] (institution_typeID),
    CONSTRAINT [fk_Main_Institution_locationID]
        FOREIGN KEY (locationID)
        REFERENCES [Location] (locationID)
);

drop table if exists [Institution Unsubsidized Loans-Undergrad Bridge]

CREATE TABLE [Institution Unsubsidized Loans-Undergrad Bridge] (
    institutionID INT,
    unsubsidized_undergradID INT,
    CONSTRAINT [FK_Institution_Unsubsidized_Loans_Undergrad_Bridge_Institution] 
        FOREIGN KEY (institutionID) 
            REFERENCES Institution (institutionID),
    CONSTRAINT [FK_Institution_Unsubsidized_Loans_Undergrad_Bridge_Unsubsidized_Loans_Undergrad] 
        FOREIGN KEY (unsubsidized_undergradID) 
            REFERENCES [Unsubsidized Loans-Undergrad] (unsubsidized_undergradID)
);

drop table if exists [Institution Subsidized Loans Bridge]

CREATE TABLE [Institution Subsidized Loans Bridge] (
    institutionID INT,
    subsidizedID  INT,
    CONSTRAINT [FK_Institution_Subsidized_Loans_Bridge_Institution] 
        FOREIGN KEY (institutionID) 
            REFERENCES Institution (institutionID),
    CONSTRAINT [FK_Institution_Subsidized_Loans_Bridge_Subsidized_Loans]    
        FOREIGN KEY (subsidizedID)      
            REFERENCES [Subsidized Loans](subsidizedID)
);

drop table if exists [Institution Unsubsidized Loans-Graduate Bridge]

CREATE TABLE [Institution Unsubsidized Loans-Graduate Bridge] (
    institutionID INT,
    unsubsidized_graduateID  INT,
    CONSTRAINT [FK_Institution_Unsubsidized_Loans_Graduate_Bridge_Institution] 
        FOREIGN KEY (institutionID) 
            REFERENCES Institution (institutionID),
    CONSTRAINT [FK_Institution_Unsubsidized_Loans_Graduate_Bridge_Unsubsidized_Loans_Graduate]    
        FOREIGN KEY (unsubsidized_graduateID)      
            REFERENCES [Unsubsidized Loans-Graduate](unsubsidized_graduateID)
);

drop table if exists [Institution Parent Plus Loans Bridge]

CREATE TABLE [Institution Parent Plus Loans Bridge] (
    institutionID INT,
    parent_plusID  INT,
    CONSTRAINT [FK_Institution_Parent_Plus_Loans_Bridge_Institution] 
        FOREIGN KEY (institutionID) 
            REFERENCES Institution (institutionID),
    CONSTRAINT [FK_Institution_Parent_Plus_Loans_Bridge_Parent_Plus_Loan]    
        FOREIGN KEY (parent_plusID)      
            REFERENCES [Parent Plus Loan](parent_plusID)

);

drop table if exists [Institution Graduate Plus Loans Bridge]

CREATE TABLE [Institution Graduate Plus Loans Bridge] (
    institutionID INT,
    graduate_plusID  INT,
    CONSTRAINT [FK_Institution_Graduate_Plus_Loans_Bridge_Institution] 
        FOREIGN KEY (institutionID) 
            REFERENCES Institution (institutionID),
    CONSTRAINT [FK_Institution_Graduate_Plus_Loans_Bridge_Graduate_Plus_Loan]    
        FOREIGN KEY (graduate_plusID)      
            REFERENCES [Graduate Plus Loan](graduate_plusID)

);

drop TABLE if exists [Institution Pell Grant Bridge]

CREATE TABLE [Institution Pell Grant Bridge] (
    institutionID INT,
    pell_grantID  INT,
    CONSTRAINT [FK_Institution_Pell_Grant_Bridge_Institution] 
        FOREIGN KEY (institutionID) 
            REFERENCES Institution (institutionID),
    CONSTRAINT [FK_Institution_Pell_Grant_Bridge_Institution_Pell_Grant]    
        FOREIGN KEY (pell_grantID)      
            REFERENCES [Pell Grant](pell_grantID)

);