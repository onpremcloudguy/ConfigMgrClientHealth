USE [ClientHealth]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_Split]    Script Date: 06.02.2019 16:02:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==============================================================================================================================
-- $HeadURL:                                                                         $ 
-- $LastChangedDate::                                                                $: Date of last commit 
-- $Rev::                                                                            $: Revision of last commit  
-- $Author::                                                                         $: Author of last commit
-- $Id::                                                                             $: 
-- ==============================================================================================================================
-- Beschreibung: 
--
--
-- ==============================================================================================================================


Create FUNCTION [dbo].[udf_Split](@List varchar(8000), @Splitter varchar(20) = ' ')
RETURNS @TB TABLE
(    
  position int IDENTITY PRIMARY KEY,
  value varchar(8000)   
)
AS
BEGIN
DECLARE @index int 
SET @index = -1 
WHILE (LEN(@List) > 0) 
 BEGIN  
    SET @index = CHARINDEX(@Splitter , @List)  
    IF (@index = 0) AND (LEN(@List) > 0)  
      BEGIN   
        INSERT INTO @TB VALUES (@List)
          BREAK  
      END  
    IF (@index > 1)  
      BEGIN   
        INSERT INTO @TB VALUES (LEFT(@List, @index - 1))   
        SET @List = RIGHT(@List, (LEN(@List) - @index))  
      END  
    ELSE 
      SET @List = RIGHT(@List, (LEN(@List) - @index)) 
    END
  RETURN
END
