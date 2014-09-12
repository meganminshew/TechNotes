/****** Object:  UserDefinedFunction [dbo].[fn_Get_Date_To_Int]    Script Date: 4/3/2013 10:04:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[fn_Get_Date_To_Int]
(
    @d_Date DATETIME
) RETURNS INT
AS
BEGIN
    DECLARE @i_Date INT
    DECLARE @v_Date VARCHAR(12)
    
    SELECT @v_Date = CONVERT(varchar(12),@d_Date,112)
    SET @i_Date = @v_Date
    
    RETURN @i_Date
END

GO

/****** Object:  UserDefinedFunction [dbo].[fn_Get_Int_To_Date]    Script Date: 4/3/2013 10:04:26 AM ******/
CREATE FUNCTION [dbo].[fn_Get_Int_To_Date]
(
	@p_i_YYYYMMDD AS INT
) RETURNS DATE AS
BEGIN 
	DECLARE @d_Value DATE;
    DECLARE @v_YYYYMMDD VARCHAR(20);

    SET @v_YYYYMMDD = CONVERT(VARCHAR(20),@p_i_YYYYMMDD)

	--SET @d_Value =util.fn_Format_Using_Mask(@p_i_YYYYMMDD,'####-##-##')
    SET @d_Value = CONVERT(DATE, @v_YYYYMMDD, 103)

	RETURN @d_Value
END;

GO

/****** Object:  UserDefinedFunction [dbo].[fn_Get_Max_Of_Date]    Script Date: 4/3/2013 10:05:26 AM ******/
CREATE FUNCTION [dbo].[fn_Get_Max_Of_Date]
(
	@p_d_value1 DATE,
	@p_d_value2 DATE
) RETURNS DATE AS
BEGIN 
    DECLARE @i_value1 INT;
	DECLARE @i_value2 INT;
    DECLARE @i_Max_Value INT

	DECLARE @d_Max_Value DATE;

    SET @i_value1 = util.fn_Get_Date_To_Int(@p_d_value1);
	SET @i_value2 = util.fn_Get_Date_To_Int(@p_d_value2);

    SET @i_Max_Value = util.fn_Get_Max_Of_Int(@i_value1, @i_value2)

    SET @d_Max_Value = util.fn_Get_Int_To_Date(@i_Max_Value)
    	
	RETURN @d_Max_Value
END;

GO

/****** Object:  UserDefinedFunction [dbo].[fn_Get_Max_Of_Int]    Script Date: 4/3/2013 10:06:35 AM ******/
CREATE FUNCTION [dbo].[fn_Get_Max_Of_Int]
(
	@p_i_value1 AS INT,
	@p_i_value2 AS INT
) RETURNS INT AS
BEGIN 
	DECLARE @i_Max_Value INT;
    
    SET @p_i_value1 = ISNULL(@p_i_value1, @p_i_value2)
	SET @p_i_value2 = ISNULL(@p_i_value2, @p_i_value1)

	SET @i_Max_Value = ((@p_i_value1+@p_i_value2) + ABS(@p_i_value1-@p_i_value2))/2
	
	RETURN @i_Max_Value
END;

GO

/****** Object:  UserDefinedFunction [dbo].[fn_Get_Min_Of_Date]    Script Date: 4/3/2013 10:07:24 AM ******/
CREATE FUNCTION [dbo].[fn_Get_Min_Of_Date]
(
	@p_d_value1 DATE,
	@p_d_value2 DATE
) RETURNS DATE AS
BEGIN 
    DECLARE @i_value1 INT;
	DECLARE @i_value2 INT;
    DECLARE @i_Min_Value INT

	DECLARE @d_Min_Value DATE;

    SET @i_value1 = util.fn_Get_Date_To_Int(@p_d_value1);
	SET @i_value2 = util.fn_Get_Date_To_Int(@p_d_value2);

    SET @i_Min_Value = util.fn_Get_Min_Of_Int(@i_value1, @i_value2)

    SET @d_Min_Value = util.fn_Get_Int_To_Date(@i_Min_Value)
    	
	RETURN @d_Min_Value
END;

GO

/****** Object:  UserDefinedFunction [dbo].[fn_Get_Min_Of_Int]    Script Date: 4/3/2013 10:07:53 AM ******/
CREATE FUNCTION [dbo].[fn_Get_Min_Of_Int]
(
	@p_i_value1 AS INT,
	@p_i_value2 AS INT
) RETURNS INT AS
BEGIN 
	DECLARE @i_Min_Value INT;

    SET @p_i_value1 = ISNULL(@p_i_value1, @p_i_value2)
	SET @p_i_value2 = ISNULL(@p_i_value2, @p_i_value1)
    
	SET @i_Min_Value = ((@p_i_value1+@p_i_value2) - ABS(@p_i_value1-@p_i_value2))/2
	
	RETURN @i_Min_Value
END;

GO

