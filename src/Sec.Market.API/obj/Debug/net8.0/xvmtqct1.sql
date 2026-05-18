IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [CustomerReviews] (
    [Id] int NOT NULL IDENTITY,
    [ProductId] int NOT NULL,
    [Comment] nvarchar(max) NOT NULL,
    [CustomerName] nvarchar(max) NOT NULL,
    [CustomerEmail] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_CustomerReviews] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Products] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [Price] int NOT NULL,
    [Image] nvarchar(max) NOT NULL,
    [DateCreation] datetime2 NOT NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Users] (
    [Id] int NOT NULL IDENTITY,
    [Nom] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [Password] nvarchar(max) NOT NULL,
    [Role] nvarchar(max) NOT NULL,
    [Token] nvarchar(max) NOT NULL,
    [DateCreation] datetime2 NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Cards] (
    [Id] int NOT NULL IDENTITY,
    [Number] nvarchar(max) NOT NULL,
    [ExpirationDate] nvarchar(max) NOT NULL,
    [SecurityCode] nvarchar(max) NOT NULL,
    [Owner] nvarchar(max) NOT NULL,
    [Type] nvarchar(max) NOT NULL,
    [UserId] int NOT NULL,
    CONSTRAINT [PK_Cards] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Cards_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Orders] (
    [Id] int NOT NULL IDENTITY,
    [ProductId] int NOT NULL,
    [UserId] int NOT NULL,
    [Quantity] int NOT NULL,
    [Price] decimal(18,2) NOT NULL,
    [Date] datetime2 NOT NULL,
    [ShippingAdress] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Orders_Products_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Orders_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Comment', N'CustomerEmail', N'CustomerName', N'ProductId') AND [object_id] = OBJECT_ID(N'[CustomerReviews]'))
    SET IDENTITY_INSERT [CustomerReviews] ON;
INSERT INTO [CustomerReviews] ([Id], [Comment], [CustomerEmail], [CustomerName], [ProductId])
VALUES (1, N'Produit de très bonne qualitée', N'jd@test.com', N'John Doe', 1),
(2, N'Je recommande ce produit', N'ad@test.com', N'Anne Doe', 2);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Comment', N'CustomerEmail', N'CustomerName', N'ProductId') AND [object_id] = OBJECT_ID(N'[CustomerReviews]'))
    SET IDENTITY_INSERT [CustomerReviews] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DateCreation', N'Description', N'Image', N'Name', N'Price') AND [object_id] = OBJECT_ID(N'[Products]'))
    SET IDENTITY_INSERT [Products] ON;
INSERT INTO [Products] ([Id], [DateCreation], [Description], [Image], [Name], [Price])
VALUES (1, '2022-09-03T18:09:13.0008693-04:00', N'Chandail pour femme, taille M', N'image1.png', N'Chandail femme', 10),
(2, '2022-09-03T18:09:13.0008698-04:00', N'Polo noir homme, taille L', N'image2.png', N'Polo Homme noir', 20),
(3, '2022-09-03T18:09:13.0008701-04:00', N'T-shirt noir imprimé homme', N'image3.png', N'T-shirt imprimé noir', 30),
(4, '2022-09-03T18:09:13.0008704-04:00', N'T-shirt gris femme taille M', N'image4.png', N'T-shirt gris femme', 15),
(5, '2022-09-03T18:09:13.0008707-04:00', N'T-shirt multicolore femme taille M', N'image5.png', N'T-shirt multicolore femme', 25),
(6, '2022-09-03T18:09:13.0008710-04:00', N'T-shirt Tee Chemise Homme Treillis Bloc', N'image6.png', N'T-shirt Tee Chemise Homme Treillis Bloc', 35),
(7, '2022-09-03T18:09:13.0008713-04:00', N'T-shirt blanc imprimé homme', N'image7.png', N'T-shirt imprimé blanc', 5),
(8, '2022-09-03T18:09:13.0008716-04:00', N'T-shirt Tee Femme Graphic Papillon', N'image8.png', N'T-shirt Tee Femme Graphic Papillon', 10),
(9, '2022-09-03T18:09:13.0008719-04:00', N'T-shirt Tee Femme Chat Graphic 3D du quotidien', N'image9.png', N'T-shirt Tee Femme Chat Graphic 3D du quotidien', 20),
(10, '2022-09-03T18:09:13.0008722-04:00', N'T-shirt Tee Homme Estampage à chaud Graphic', N'image10.png', N'T-shirt Tee Homme Estampage à chaud Graphic', 30),
(11, '2022-09-03T18:09:13.0008724-04:00', N'T-shirt Tee Homme Unisexe Estampage', N'image11.png', N'T-shirt Tee Homme Unisexe Estampage', 25),
(12, '2022-09-03T18:09:13.0008727-04:00', N'T-shirt en tricot côtelé', N'image12.png', N'T-shirt en tricot côtelé', 15);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DateCreation', N'Description', N'Image', N'Name', N'Price') AND [object_id] = OBJECT_ID(N'[Products]'))
    SET IDENTITY_INSERT [Products] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DateCreation', N'Email', N'Nom', N'Password', N'Role', N'Token') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] ON;
INSERT INTO [Users] ([Id], [DateCreation], [Email], [Nom], [Password], [Role], [Token])
VALUES (1, '2022-09-03T18:09:13.0008436-04:00', N'jd@test.com', N'John Doe', N'123456', N'Admin', N'123456789'),
(2, '2022-09-03T18:09:13.0008485-04:00', N'ad@test.com', N'Anne Doe', N'123456', N'User', N'123456789');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DateCreation', N'Email', N'Nom', N'Password', N'Role', N'Token') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ExpirationDate', N'Number', N'Owner', N'SecurityCode', N'Type', N'UserId') AND [object_id] = OBJECT_ID(N'[Cards]'))
    SET IDENTITY_INSERT [Cards] ON;
INSERT INTO [Cards] ([Id], [ExpirationDate], [Number], [Owner], [SecurityCode], [Type], [UserId])
VALUES (1, N'12/25', N'6466675889085456', N'John Doe', N'123', N'Visa', 1);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ExpirationDate', N'Number', N'Owner', N'SecurityCode', N'Type', N'UserId') AND [object_id] = OBJECT_ID(N'[Cards]'))
    SET IDENTITY_INSERT [Cards] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'Price', N'ProductId', N'Quantity', N'ShippingAdress', N'UserId') AND [object_id] = OBJECT_ID(N'[Orders]'))
    SET IDENTITY_INSERT [Orders] ON;
INSERT INTO [Orders] ([Id], [Date], [Price], [ProductId], [Quantity], [ShippingAdress], [UserId])
VALUES (1, '2022-09-03T18:09:13.0008782-04:00', 10.0, 1, 1, N'23r Rue Paul, Quebec, QC, G2H537', 1);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'Price', N'ProductId', N'Quantity', N'ShippingAdress', N'UserId') AND [object_id] = OBJECT_ID(N'[Orders]'))
    SET IDENTITY_INSERT [Orders] OFF;
GO

CREATE INDEX [IX_Cards_UserId] ON [Cards] ([UserId]);
GO

CREATE INDEX [IX_Orders_ProductId] ON [Orders] ([ProductId]);
GO

CREATE INDEX [IX_Orders_UserId] ON [Orders] ([UserId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220903220913_Initial', N'8.0.13');
GO

COMMIT;
GO

