use ClientHealth 
go 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'up_GetErrorInfo')
DROP PROCEDURE up_GetErrorInfo
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'up_get_SCCM_statusMsg')
DROP PROCEDURE up_get_SCCM_statusMsg
GO

/****** Object:  StoredProcedure [dbo].[up_get_SCCM_statusMsg]    Script Date: 2/6/2019 4:50:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************/
/*** Script Name                  : - up_get_SCCM_statusMsg               ***/
/*** Script Version               : - 1.00                                ***/
/*** Script Desciption            : - new Stored Procedure                ***/
/*** Script Audience              : -                                     ***/
/*** Script Owner                 : - C-S-L K.Bilger                      ***/
/*** Scripter/Design              : - C-S-L K.Bilger                      ***/
/***                                                                      ***/
/*** Change History *********************************************************/
/*** Version (Old/New)            : - 1.00.00                             ***/
/*** Modification Date            : - 02/06/2019                          ***/
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

CREATE PROCEDURE [dbo].[up_get_SCCM_statusMsg]

AS
BEGIN
	SET NOCOUNT ON;

	-- load config to find the actiontype
	declare @Actiontype as bit = 0 
	set @Actiontype = (select CONVERT(bit, Configvalue) from dbo.SCCM_Config where ConfigItem = 'SCCM_transfer_StatusMsg_to_ClientHealtDB')

	if @Actiontype = 0 
	begin
		print 'show data only'
		Select v_s.*, pvt.AttributeTime, pvt.DeploymentID, pvt.MacAddress, pvt.PackageID 
				From CM_ABC.dbo.v_StatusMessage AS v_S LEFT JOIN
					(SELECT Recordid, AttributeTime, [400] AS PackageID, [401] AS DeploymentID, 
					Case When [426] IS NULL THEN 'MAC Address missing' ELSE [426] END  AS MacAddress
						FROM  CM_ABC.dbo.v_StatMsgAttributes PIVOT (max(AttributeValue) FOR AttributeID 
						IN ([400], [401], [408], [425], [426])) AS P) AS pvt ON v_S.RecordID = pvt.recordid
				where 
					(MachineName in (select distinct Hostname from ClientHealth.dbo.Clients)	
				or 
					MachineName in (Select distinct Hostname +'.'+ Domain from ClientHealth.dbo.Clients))
				and MessageID not in 
				(SELECT value FROM [dbo].[udf_Split] ((SELECT top 1 ConfigValue FROM [ClientHealth].[dbo].[SCCM_Config] where ConfigItem  =		'SCCM_blocked_StatusMsg') ,','))
				and Component in 
				(SELECT value FROM [dbo].[udf_Split] ((SELECT top 1 ConfigValue FROM [ClientHealth].[dbo].[SCCM_Config] where ConfigItem  = 'SCCM_ComponetsStatusMsg') ,','))
				order by v_s.Time desc 
	end 
	if @Actiontype = 1
	begin
		print 'add data to local tbl'
		INSERT INTO [dbo].[SCCM_StatusMsg]
           ([RecordID],[ModuleName],[Severity],[MessageID],[ReportFunction],[SuccessfulTransaction],[PartOfTransaction],
		   [PerClient],[MessageType],[Win32Error],[Time],[SiteCode],[TopLevelSiteCode],[MachineName],[Component],
		   [ProcessID],[ThreadID],[AttributeTime],[DeploymentID],[MacAddress],[PackageID])
		Select v_s.*, pvt.AttributeTime, pvt.DeploymentID, pvt.MacAddress, pvt.PackageID
				From CM_ABC.dbo.v_StatusMessage AS v_S LEFT JOIN
					(SELECT Recordid, AttributeTime, [400] AS PackageID, [401] AS DeploymentID, 
					Case When [426] IS NULL THEN 'MAC Address missing' ELSE [426] END  AS MacAddress
						FROM  CM_ABC.dbo.v_StatMsgAttributes PIVOT (max(AttributeValue) FOR AttributeID 
						IN ([400], [401], [408], [425], [426])) AS P) AS pvt ON v_S.RecordID = pvt.recordid
				where 
					(MachineName in (select distinct Hostname from ClientHealth.dbo.Clients)	
				or 
					MachineName in (Select distinct Hostname +'.'+ Domain from ClientHealth.dbo.Clients))
				and MessageID not in 
				(SELECT value FROM [dbo].[udf_Split] ((SELECT top 1 ConfigValue FROM [ClientHealth].[dbo].[SCCM_Config] where ConfigItem  =		'SCCM_blocked_StatusMsg') ,','))
				and Component in 
				(SELECT value FROM [dbo].[udf_Split] ((SELECT top 1 ConfigValue FROM [ClientHealth].[dbo].[SCCM_Config] where ConfigItem  = 'SCCM_ComponetsStatusMsg') ,','))
				and v_s.RecordID not in (Select tb1.RecordID from [dbo].[SCCM_StatusMsg] as tb1)

	-- show now all status messsage
	Select * from [dbo].[SCCM_StatusMsg] order by Time desc 

	end
END
GO
/****** Object:  StoredProcedure [dbo].[up_GetErrorInfo]    Script Date: 2/6/2019 4:50:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****************************************************************************/
/*** Script Name                  : - up_GetErrorInfo                     ***/
/*** Script Version               : - 1.00                                ***/
/*** Script Desciption            : - erstellt Stored Procedure           ***/
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
CREATE PROCEDURE [dbo].[up_GetErrorInfo]
AS
begin 
 declare @Error_Text as nvarchar(max), @str_line as nvarchar(max)
 set  @str_line = replicate('#*',55) 
	set @Error_Text = @str_line + char(09) +  char(13)+ char(09) +  char(13)
	set @Error_Text = @Error_Text + ' Mail erzeugt:    ' + CONVERT(varchar(25),getdate())+ char(09) +  char(13)
	if ERROR_NUMBER() is not null 
		begin 
			set @Error_Text =  @Error_Text + 'ERROR_SEVERITY:  '  + CONVERT(varchar(max),ERROR_NUMBER())+ char(09) +  char(13)
		end
	if ERROR_SEVERITY() is not null 
		begin
			set @Error_Text = @Error_Text + 'ERROR_SEVERITY:  '  + CONVERT(varchar(max),ERROR_SEVERITY())+ char(09) +  char(13)
		end
	if ERROR_STATE() is not null 
	begin
		set @Error_Text = @Error_Text + 'ERROR_STATE:     '  + CONVERT(varchar(max),ERROR_STATE())+ char(09) +  char(13)
	end
	if ERROR_PROCEDURE() is not null 
	begin
		set @Error_Text = @Error_Text + 'ERROR_PROCEDURE:   '  + CONVERT(varchar(max),ERROR_PROCEDURE())+ char(09) +  char(13)
	end
	if ERROR_LINE() is not null 
	begin
		set @Error_Text = @Error_Text + 'ERROR_LINE:      '  + CONVERT(varchar(max),ERROR_LINE())+ char(09) +  char(13)
	end
	if ERROR_MESSAGE() is not null 
	begin
		set @Error_Text = @Error_Text + 'ERROR_MESSAGE:   '  + CONVERT(varchar(max),ERROR_MESSAGE())+ char(09) +  char(13)
	end
		set @Error_Text = @Error_Text + char(09) +  char(13)
		set @Error_Text = @Error_Text + @str_line

	INSERT INTO [dbo].[LogMsg]
           ([LogMsg],[Logdate])
     VALUES
           (@Error_Text, getdate())
END

GO
