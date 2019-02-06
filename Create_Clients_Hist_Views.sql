USE [ClientHealth]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- check and remove older views
if exists(select 1 from sys.views where name='v_ClientData_Actual' and type='v')
drop view v_ClientData_Actual;
go
if exists(select 1 from sys.views where name='v_ClientData_ALL' and type='v')
drop view v_ClientData_ALL;
go
if exists(select 1 from sys.views where name='v_ClientData_historical' and type='v')
drop view v_ClientData_historical;
go

-- create now views 
CREATE VIEW [dbo].[v_ClientData_Actual]
AS
	SELECT  Hostname, OperatingSystem, Architecture, Build, Manufacturer, Model, InstallDate, 
			OSUpdates, LastLoggedOnUser, ClientVersion, PSVersion, PSBuild, Sitecode, Domain, MaxLogSize, 
			MaxLogHistory,CacheSize, ClientCertificate, ProvisioningMode, DNS, Drivers, Updates, PendingReboot, 
			LastBootTime, OSDiskFreeSpace, Services, AdminShare, StateMessages, WUAHandler, WMI, 
			RefreshComplianceState, ClientInstalled, Version, Timestamp, HWInventory, SWMetering, BITS, 
			PatchLevel, ClientInstalledReason
	FROM
		 dbo.Clients
GO
/****** Object:  View [dbo].[v_ClientData_ALL]    Script Date: 2/6/2019 4:49:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View [dbo].[v_ClientData_ALL]    Script Date: 2/6/2019 2:46:03 PM ******/
CREATE VIEW [dbo].[v_ClientData_ALL]
AS
	SELECT	[Hostname],[OperatingSystem],[Architecture],[Build],[Manufacturer],[Model],[InstallDate],
			[OSUpdates],[LastLoggedOnUser],[ClientVersion],[PSVersion],[PSBuild],[Sitecode],[Domain],
			[MaxLogSize],[MaxLogHistory],[CacheSize],[ClientCertificate],[ProvisioningMode],[DNS],
			[Drivers],[Updates],[PendingReboot],[LastBootTime],[OSDiskFreeSpace],[Services],[AdminShare],
			[StateMessages],[WUAHandler],[WMI],[RefreshComplianceState],[ClientInstalled],[Version],
			[Timestamp],[HWInventory],[SWMetering],[BITS],[PatchLevel],[ClientInstalledReason] 
	from 
		dbo.clients
	union 
	select 
			[Hostname],[OperatingSystem],[Architecture],[Build],[Manufacturer],[Model],[InstallDate],
			[OSUpdates],[LastLoggedOnUser],[ClientVersion],[PSVersion],[PSBuild],[Sitecode],[Domain],
			[MaxLogSize],[MaxLogHistory],[CacheSize],[ClientCertificate],[ProvisioningMode],[DNS],
			[Drivers],[Updates],[PendingReboot],[LastBootTime],[OSDiskFreeSpace],[Services],[AdminShare],
			[StateMessages],[WUAHandler],[WMI],[RefreshComplianceState],[ClientInstalled],[Version],
			[Timestamp],[HWInventory],[SWMetering],[BITS],[PatchLevel],[ClientInstalledReason] 
	from dbo.clients_hist

GO
/****** Object:  View [dbo].[v_ClientData_historical]    Script Date: 2/6/2019 4:49:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View [dbo].[v_ClientData_historical]    Script Date: 2/6/2019 2:46:03 PM ******/
CREATE VIEW [dbo].[v_ClientData_historical]
AS
	SELECT  ID, Hostname, OperatingSystem, Architecture, Build, Manufacturer, Model, InstallDate, 
			OSUpdates, LastLoggedOnUser, ClientVersion, PSVersion, PSBuild, Sitecode, Domain, MaxLogSize, 
			MaxLogHistory, CacheSize, ClientCertificate, ProvisioningMode, DNS, Drivers, Updates, PendingReboot, 
			LastBootTime, OSDiskFreeSpace, Services, AdminShare, StateMessages, WUAHandler, WMI, 
			RefreshComplianceState, ClientInstalled, Version, Timestamp, HWInventory, SWMetering, BITS, 
			PatchLevel, ClientInstalledReason, LOG_Created_Date, LOG_Created_by, LOG_Action
	FROM    dbo.Clients_Hist
GO
