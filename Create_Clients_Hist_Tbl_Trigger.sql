use ClientHealth
go 

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = 'T_TB_Clients_I' AND [type] = 'TR')
   DROP TRIGGER [T_TB_Clients_I] 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = 'T_TB_Clients_U' AND [type] = 'TR')
   DROP TRIGGER [T_TB_Clients_U] 
GO

select * from sys.objects where type = 'TR'


/****** Object:  Trigger [dbo].[T_TB_Clients_I]    Script Date: 2/6/2019 3:05:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************/
/*** Script Name                  : - [T_TB_Clients_I]                    ***/
/*** Script Version               : - 1.00                                ***/
/*** Script Desciption            : - erstellt Trigger for Insert (Hist)  ***/
/*** Script Audience              : -                                     ***/
/*** Script Owner                 : - C-S-L K.Bilger                      ***/
/*** Scripter/Design              : - C-S-L K.Bilger                      ***/
/***                                                                      ***/
/*** Change History *********************************************************/
/*** Version (Old/New)            : - 1.00.00                             ***/
/*** Modification Date            : - 01/25/2019                          ***/
/*** By                           : - Klaus Bilger                        ***/
/*** Reason                       : -                                     ***/
/*** Comments                     : -                                     ***/
/***                                                                      ***/
/*** Version (Old/New)            : - %Version%                           ***/
/*** Modification Date            : - %DATE%                              ***/
/*** By                           : - %PERSON%                            ***/
/*** Reason                       : - %REASON%                            ***/
/*** Comments                     : - %COMMENTS%                          ***/
/***                                                                      ***/
/****************************************************************************/
--
--

CREATE TRIGGER [dbo].[T_TB_Clients_I]
   ON  [dbo].[Clients]
   AFTER INSERT
AS 
BEGIN
	begin try
		Declare @Hostname as varchar(100)
		DECLARE DS_Update_Cursor CURSOR FOR  
		SELECT Hostname FROM INSERTED
		OPEN DS_Update_Cursor   
		FETCH NEXT FROM DS_Update_Cursor INTO @Hostname   

		WHILE @@FETCH_STATUS = 0   
	BEGIN   
			INSERT INTO  [dbo].[Clients_Hist]
			([Hostname],[OperatingSystem],[Architecture],[Build],[Manufacturer],[Model],[InstallDate],
				[OSUpdates],[LastLoggedOnUser],[ClientVersion],[PSVersion],[PSBuild],[Sitecode],[Domain],
				[MaxLogSize],[MaxLogHistory],[CacheSize],[ClientCertificate],[ProvisioningMode],[DNS],
				[Drivers],[Updates],[PendingReboot],[LastBootTime],[OSDiskFreeSpace],[Services],[AdminShare],
				[StateMessages],[WUAHandler],[WMI],[RefreshComplianceState],[ClientInstalled],[Version],
				[Timestamp],[HWInventory],[SWMetering],[BITS],[PatchLevel],[ClientInstalledReason],
				[LOG_Created_Date],[LOG_Created_by],[LOG_Action])
				
			 SELECT 
				[Hostname],[OperatingSystem],[Architecture],[Build],[Manufacturer],[Model],[InstallDate],
				[OSUpdates],[LastLoggedOnUser],[ClientVersion],[PSVersion],[PSBuild],[Sitecode],[Domain],
				[MaxLogSize],[MaxLogHistory],[CacheSize],[ClientCertificate],[ProvisioningMode],[DNS],
				[Drivers],[Updates],[PendingReboot],[LastBootTime],[OSDiskFreeSpace],[Services],[AdminShare],
				[StateMessages],[WUAHandler],[WMI],[RefreshComplianceState],[ClientInstalled],[Version],
				[Timestamp],[HWInventory],[SWMetering],[BITS],[PatchLevel],[ClientInstalledReason]
				,Getdate() as 'Created_Date'
				,USER as 'Created_by'
				,'INSERT' as 'Action'
				FROM INSERTED 
				where ([Hostname] = @Hostname) 

       FETCH NEXT FROM DS_Update_Cursor INTO @Hostname   
	END   
	end try
	begin catch
		execute dbo.up_GetErrorInfo
	end catch 
CLOSE DS_Update_Cursor   
DEALLOCATE DS_Update_Cursor
end
GO
ALTER TABLE [dbo].[Clients] ENABLE TRIGGER [T_TB_Clients_I]
GO
/****** Object:  Trigger [dbo].[T_TB_Clients_U]    Script Date: 2/6/2019 3:05:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************/
/*** Script Name                  : - [T_TB_Clients_U]                    ***/
/*** Script Version               : - 1.00                                ***/
/*** Script Desciption            : - erstellt Trigger for Update (Hist)  ***/
/*** Script Audience              : -                                     ***/
/*** Script Owner                 : - C-S-L K.Bilger                      ***/
/*** Scripter/Design              : - C-S-L K.Bilger                      ***/
/***                                                                      ***/
/*** Change History *********************************************************/
/*** Version (Old/New)            : - 1.00.00                             ***/
/*** Modification Date            : - 01/25/2019                          ***/
/*** By                           : - Klaus Bilger                        ***/
/*** Reason                       : -                                     ***/
/*** Comments                     : -                                     ***/
/***                                                                      ***/
/*** Version (Old/New)            : - %Version%                           ***/
/*** Modification Date            : - %DATE%                              ***/
/*** By                           : - %PERSON%                            ***/
/*** Reason                       : - %REASON%                            ***/
/*** Comments                     : - %COMMENTS%                          ***/
/***                                                                      ***/
/****************************************************************************/

CREATE TRIGGER [dbo].[T_TB_Clients_U]
   ON  [dbo].[Clients]
   AFTER Update
AS 
BEGIN
	begin try
		Declare @Hostname as varchar(100)
		DECLARE DS_Update_Cursor CURSOR FOR  
		
		SELECT Hostname FROM INSERTED
		OPEN DS_Update_Cursor   
		FETCH NEXT FROM DS_Update_Cursor INTO @Hostname   

		WHILE @@FETCH_STATUS = 0   
	BEGIN   
			INSERT INTO [dbo].[Clients_Hist]
			([Hostname],[OperatingSystem],[Architecture],[Build],[Manufacturer],[Model],[InstallDate],
				[OSUpdates],[LastLoggedOnUser],[ClientVersion],[PSVersion],[PSBuild],[Sitecode],[Domain],
				[MaxLogSize],[MaxLogHistory],[CacheSize],[ClientCertificate],[ProvisioningMode],[DNS],
				[Drivers],[Updates],[PendingReboot],[LastBootTime],[OSDiskFreeSpace],[Services],[AdminShare],
				[StateMessages],[WUAHandler],[WMI],[RefreshComplianceState],[ClientInstalled],[Version],
				[Timestamp],[HWInventory],[SWMetering],[BITS],[PatchLevel],[ClientInstalledReason],
				[LOG_Created_Date],[LOG_Created_by],[LOG_Action])
				
			 SELECT 
				[Hostname],[OperatingSystem],[Architecture],[Build],[Manufacturer],[Model],[InstallDate],
				[OSUpdates],[LastLoggedOnUser],[ClientVersion],[PSVersion],[PSBuild],[Sitecode],[Domain],
				[MaxLogSize],[MaxLogHistory],[CacheSize],[ClientCertificate],[ProvisioningMode],[DNS],
				[Drivers],[Updates],[PendingReboot],[LastBootTime],[OSDiskFreeSpace],[Services],[AdminShare],
				[StateMessages],[WUAHandler],[WMI],[RefreshComplianceState],[ClientInstalled],[Version],
				[Timestamp],[HWInventory],[SWMetering],[BITS],[PatchLevel],[ClientInstalledReason]
				,Getdate() as 'Created_Date'
				,USER as 'Created_by'
				,'Update' as 'Action'
				FROM INSERTED
				where ([Hostname] = @Hostname) 
       FETCH NEXT FROM DS_Update_Cursor INTO @Hostname   
	END   
	end try
	begin catch
		execute up_GetErrorInfo
	
	end catch 
CLOSE DS_Update_Cursor   
DEALLOCATE DS_Update_Cursor
end
GO
ALTER TABLE [dbo].[Clients] ENABLE TRIGGER [T_TB_Clients_U]
GO
USE [master]
GO
ALTER DATABASE [ClientHealth] SET  READ_WRITE 
GO
