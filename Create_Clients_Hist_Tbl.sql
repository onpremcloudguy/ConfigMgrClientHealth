USE [ClientHealth]
GO
/****** Object:  Table [dbo].[Clients_Hist]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'Clients_Hist')
CREATE TABLE [dbo].[Clients_Hist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Hostname] [varchar](100) NOT NULL,
	[OperatingSystem] [varchar](100) NOT NULL,
	[Architecture] [varchar](10) NOT NULL,
	[Build] [varchar](100) NOT NULL,
	[Manufacturer] [varchar](100) NOT NULL,
	[Model] [varchar](100) NOT NULL,
	[InstallDate] [smalldatetime] NULL,
	[OSUpdates] [smalldatetime] NULL,
	[LastLoggedOnUser] [varchar](100) NOT NULL,
	[ClientVersion] [varchar](100) NOT NULL,
	[PSVersion] [float] NULL,
	[PSBuild] [int] NULL,
	[Sitecode] [varchar](3) NULL,
	[Domain] [varchar](100) NOT NULL,
	[MaxLogSize] [int] NULL,
	[MaxLogHistory] [int] NULL,
	[CacheSize] [int] NULL,
	[ClientCertificate] [varchar](50) NULL,
	[ProvisioningMode] [varchar](50) NULL,
	[DNS] [varchar](100) NULL,
	[Drivers] [varchar](100) NULL,
	[Updates] [varchar](100) NULL,
	[PendingReboot] [varchar](50) NULL,
	[LastBootTime] [smalldatetime] NULL,
	[OSDiskFreeSpace] [float] NULL,
	[Services] [varchar](200) NOT NULL,
	[AdminShare] [varchar](50) NULL,
	[StateMessages] [varchar](50) NULL,
	[WUAHandler] [varchar](50) NULL,
	[WMI] [varchar](50) NULL,
	[RefreshComplianceState] [smalldatetime] NULL,
	[ClientInstalled] [smalldatetime] NULL,
	[Version] [varchar](10) NULL,
	[Timestamp] [datetime] NULL,
	[HWInventory] [smalldatetime] NULL,
	[SWMetering] [varchar](50) NULL,
	[BITS] [varchar](50) NULL,
	[PatchLevel] [int] NULL,
	[ClientInstalledReason] [varchar](200) NULL,
	[LOG_Created_Date] [datetime] NULL,
	[LOG_Created_by] [varchar](50) NULL,
	[LOG_Action] [varchar](50) NULL,
 CONSTRAINT [PK__Clients___3214EC278B487331] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogMsg]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'LogMsg')
CREATE TABLE [dbo].[LogMsg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LogMsg] [nvarchar](max) NOT NULL,
	[Logdate] [datetime] NOT NULL,
 CONSTRAINT [PK_LogMsg] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_ClientStatMsg]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'ref_ClientStatMsg')
CREATE TABLE [dbo].[ref_ClientStatMsg](
	[MessageID] [nvarchar](50) NULL,
	[MessageString] [nvarchar](max) NULL,
	[Severity] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_ProvStatMsg]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'ref_ProvStatMsg')
CREATE TABLE [dbo].[ref_ProvStatMsg](
	[MessageID] [nvarchar](50) NULL,
	[MessageString] [nvarchar](max) NULL,
	[Severity] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_ServerStatMsg]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'ref_serverStatMsg')
CREATE TABLE [dbo].[ref_ServerStatMsg](
	[MessageID] [nvarchar](50) NULL,
	[MessageString] [nvarchar](max) NULL,
	[Severity] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_Theme]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'Report_Theme')
CREATE TABLE [dbo].[Report_Theme](
	[Theme] [nvarchar](50) NOT NULL,
	[BG_01] [varchar](20) NOT NULL,
	[FG_01] [varchar](20) NOT NULL,
	[BG_02] [varchar](20) NOT NULL,
	[FG_02] [varchar](20) NOT NULL,
	[BG_03] [varchar](20) NOT NULL,
	[FG_03] [varchar](20) NOT NULL,
	[BG_04] [varchar](20) NOT NULL,
	[FG_04] [varchar](20) NOT NULL,
	[BG_red] [varchar](20) NOT NULL,
	[BG_green] [varchar](20) NOT NULL,
	[BG_header] [varchar](20) NOT NULL,
	[FG_header] [varchar](20) NOT NULL,
	[BG_footer] [varchar](20) NOT NULL,
	[FG_Footer] [varchar](20) NOT NULL,
	[BG_Info] [varchar](20) NULL,
 CONSTRAINT [PK_TB_Report_Theme] PRIMARY KEY CLUSTERED 
(
	[Theme] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCCM_Config]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'SCCM_Config')
CREATE TABLE [dbo].[SCCM_Config](
	[ID] [bigint] NOT NULL,
	[ConfigItem] [nvarchar](50) NOT NULL,
	[ConfigValue] [nvarchar](2000) NOT NULL,
	[Note] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCCM_StatusMsg]    Script Date: 2/6/2019 4:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'SCCM_StatusMsg')
CREATE TABLE [dbo].[SCCM_StatusMsg](
	[RecordID] [bigint] NOT NULL,
	[ModuleName] [nvarchar](128) NOT NULL,
	[Severity] [int] NULL,
	[MessageID] [int] NOT NULL,
	[ReportFunction] [int] NULL,
	[SuccessfulTransaction] [int] NULL,
	[PartOfTransaction] [int] NULL,
	[PerClient] [int] NULL,
	[MessageType] [int] NULL,
	[Win32Error] [int] NULL,
	[Time] [datetime] NOT NULL,
	[SiteCode] [nvarchar](3) NOT NULL,
	[TopLevelSiteCode] [nvarchar](3) NULL,
	[MachineName] [nvarchar](128) NOT NULL,
	[Component] [nvarchar](128) NOT NULL,
	[ProcessID] [int] NULL,
	[ThreadID] [int] NULL,
	[AttributeTime] [datetime] NULL,
	[DeploymentID] [nvarchar](255) NULL,
	[MacAddress] [nvarchar](255) NULL,
	[PackageID] [nvarchar](255) NULL
) ON [PRIMARY]
GO
