
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/06/2023 13:12:00
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


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


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
    [ApartmentsRes_Id_Aparment] int  NOT NULL,
    [Users_Id_User] int  NOT NULL
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

-- Creating primary key on [ApartmentsRes_Id_Aparment], [Users_Id_User] in table 'Reservations'
ALTER TABLE [dbo].[Reservations]
ADD CONSTRAINT [PK_Reservations]
    PRIMARY KEY CLUSTERED ([ApartmentsRes_Id_Aparment], [Users_Id_User] ASC);
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

-- Creating foreign key on [ApartmentsRes_Id_Aparment] in table 'Reservations'
ALTER TABLE [dbo].[Reservations]
ADD CONSTRAINT [FK_Reservations_Apartment]
    FOREIGN KEY ([ApartmentsRes_Id_Aparment])
    REFERENCES [dbo].[Apartments]
        ([Id_Aparment])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Users_Id_User] in table 'Reservations'
ALTER TABLE [dbo].[Reservations]
ADD CONSTRAINT [FK_Reservations_User]
    FOREIGN KEY ([Users_Id_User])
    REFERENCES [dbo].[Users]
        ([Id_User])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Reservations_User'
CREATE INDEX [IX_FK_Reservations_User]
ON [dbo].[Reservations]
    ([Users_Id_User]);
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

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------