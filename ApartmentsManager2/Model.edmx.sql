
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/13/2023 10:31:10
-- Generated from EDMX file: C:\Users\cserr\source\repos\ApartmentsManager2\ApartmentsManager2\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Apartments];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Contact]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Apartments] DROP CONSTRAINT [FK_Contact];
GO
IF OBJECT_ID(N'[dbo].[FK_ApartmentUploadedFile]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UploadedFiles] DROP CONSTRAINT [FK_ApartmentUploadedFile];
GO
IF OBJECT_ID(N'[dbo].[FK_UserUploadedFile]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_UserUploadedFile];
GO
IF OBJECT_ID(N'[dbo].[FK_ReservationUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [FK_ReservationUser];
GO
IF OBJECT_ID(N'[dbo].[FK_ReservationApartment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [FK_ReservationApartment];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Apartments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Apartments];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[UploadedFiles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UploadedFiles];
GO
IF OBJECT_ID(N'[dbo].[Reservations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Reservations];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Apartments'
CREATE TABLE [dbo].[Apartments] (
    [Id_Aparment] int IDENTITY(1,1) NOT NULL,
    [Address] nvarchar(50)  NOT NULL,
    [City] nvarchar(20)  NOT NULL,
    [Contact] int  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id_User] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Surname] nvarchar(max)  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [UploadedFile_Id_UploadedFile] int  NOT NULL
);
GO

-- Creating table 'UploadedFiles'
CREATE TABLE [dbo].[UploadedFiles] (
    [Id_UploadedFile] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [ContentType] nvarchar(20)  NOT NULL,
    [Content] varbinary(max)  NOT NULL,
    [Apartment_Id_Aparment] int  NULL
);
GO

-- Creating table 'Reservations'
CREATE TABLE [dbo].[Reservations] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [UserId_User] int  NOT NULL,
    [ApartmentId_Aparment] int  NOT NULL,
    [Start_Date] datetime  NOT NULL,
    [End_Date] datetime  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id_Aparment] in table 'Apartments'
ALTER TABLE [dbo].[Apartments]
ADD CONSTRAINT [PK_Apartments]
    PRIMARY KEY CLUSTERED ([Id_Aparment] ASC);
GO

-- Creating primary key on [Id_User] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id_User] ASC);
GO

-- Creating primary key on [Id_UploadedFile] in table 'UploadedFiles'
ALTER TABLE [dbo].[UploadedFiles]
ADD CONSTRAINT [PK_UploadedFiles]
    PRIMARY KEY CLUSTERED ([Id_UploadedFile] ASC);
GO

-- Creating primary key on [Id] in table 'Reservations'
ALTER TABLE [dbo].[Reservations]
ADD CONSTRAINT [PK_Reservations]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Contact] in table 'Apartments'
ALTER TABLE [dbo].[Apartments]
ADD CONSTRAINT [FK_Contact]
    FOREIGN KEY ([Contact])
    REFERENCES [dbo].[Users]
        ([Id_User])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Contact'
CREATE INDEX [IX_FK_Contact]
ON [dbo].[Apartments]
    ([Contact]);
GO

-- Creating foreign key on [Apartment_Id_Aparment] in table 'UploadedFiles'
ALTER TABLE [dbo].[UploadedFiles]
ADD CONSTRAINT [FK_ApartmentUploadedFile]
    FOREIGN KEY ([Apartment_Id_Aparment])
    REFERENCES [dbo].[Apartments]
        ([Id_Aparment])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ApartmentUploadedFile'
CREATE INDEX [IX_FK_ApartmentUploadedFile]
ON [dbo].[UploadedFiles]
    ([Apartment_Id_Aparment]);
GO

-- Creating foreign key on [UploadedFile_Id_UploadedFile] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_UserUploadedFile]
    FOREIGN KEY ([UploadedFile_Id_UploadedFile])
    REFERENCES [dbo].[UploadedFiles]
        ([Id_UploadedFile])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserUploadedFile'
CREATE INDEX [IX_FK_UserUploadedFile]
ON [dbo].[Users]
    ([UploadedFile_Id_UploadedFile]);
GO

-- Creating foreign key on [UserId_User] in table 'Reservations'
ALTER TABLE [dbo].[Reservations]
ADD CONSTRAINT [FK_ReservationUser]
    FOREIGN KEY ([UserId_User])
    REFERENCES [dbo].[Users]
        ([Id_User])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ReservationUser'
CREATE INDEX [IX_FK_ReservationUser]
ON [dbo].[Reservations]
    ([UserId_User]);
GO

-- Creating foreign key on [ApartmentId_Aparment] in table 'Reservations'
ALTER TABLE [dbo].[Reservations]
ADD CONSTRAINT [FK_ReservationApartment]
    FOREIGN KEY ([ApartmentId_Aparment])
    REFERENCES [dbo].[Apartments]
        ([Id_Aparment])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ReservationApartment'
CREATE INDEX [IX_FK_ReservationApartment]
ON [dbo].[Reservations]
    ([ApartmentId_Aparment]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------