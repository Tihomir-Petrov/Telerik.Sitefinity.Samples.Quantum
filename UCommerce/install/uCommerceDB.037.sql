/*
	Definition Framework 1.0
	- UI registrations
*/
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

DECLARE @AdminPageId INT

-- Definition UI
INSERT INTO [dbo].[uCommerce_AdminPage] ([FullName], [ActiveTab]) VALUES (N'ASP.umbraco_uCommerce_settings_catalog_editdefinition_aspx', N'')
SELECT @AdminPageId = SCOPE_IDENTITY()

INSERT INTO [dbo].[uCommerce_AdminTab] ([VirtualPath], [AdminPageId], [SortOrder], [MultiLingual], [ResouceKey], [HasSaveButton], [HasDeleteButton], [Enabled]) VALUES (N'EditDefinitionBaseProperties.ascx', @AdminPageId, 1, 1, N'Common', 1, 0, 1)

-- Definition fields UI
INSERT INTO [dbo].[uCommerce_AdminPage] ([FullName], [ActiveTab]) VALUES (N'ASP.umbraco_uCommerce_settings_catalog_editdefinitionfield_aspx', N'')
SELECT @AdminPageId = SCOPE_IDENTITY()

INSERT INTO [dbo].[uCommerce_AdminTab] ([VirtualPath], [AdminPageId], [SortOrder], [MultiLingual], [ResouceKey], [HasSaveButton], [HasDeleteButton], [Enabled]) VALUES (N'EditDefinitionFieldDescription.ascx', @AdminPageId, 2, 1, N'Description', 1, 0, 1)
INSERT INTO [dbo].[uCommerce_AdminTab] ([VirtualPath], [AdminPageId], [SortOrder], [MultiLingual], [ResouceKey], [HasSaveButton], [HasDeleteButton], [Enabled]) VALUES (N'EditDefinitionFieldBaseProperties.ascx', @AdminPageId, 1, 0, N'Common', 1, 0, 1)
GO
