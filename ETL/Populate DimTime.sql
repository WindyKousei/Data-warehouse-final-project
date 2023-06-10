DECLARE @hour INT
DECLARE @minute INT
DECLARE @second INT
SET @hour = 0
WHILE @hour < 24
BEGIN
	SET @minute = 0
	WHILE @minute < 60
	BEGIN
		SET @second = 0
		WHILE @second < 60
		BEGIN
			INSERT INTO [dbo].[DimTime]
			(
				[TimeKey],
				[FullTime],
				[FullTimeString],
				[Hour],
				[HourMinString],
				[HourFullString],
				[Minute],
				[MinuteFullString],
				[Second]
			)
			SELECT (@hour * 10000) + (@minute * 100) + @second AS 'TimeKey',
				   CONVERT(
							  TIME,
							  RIGHT('0' + CONVERT(VARCHAR(2), @hour), 2) + ':'
							  + RIGHT('0' + CONVERT(VARCHAR(2), @minute), 2) + ':'
							  + RIGHT('0' + CONVERT(VARCHAR(2), @second), 2)
						  ) AS 'FullTime',
				   RIGHT('0' + CONVERT(VARCHAR(2), @hour), 2) + ':' + RIGHT('0' + CONVERT(VARCHAR(2), @minute), 2)
				   + ':' + RIGHT('0' + CONVERT(VARCHAR(2), @second), 2) 'FullTimeString',
				   @hour AS 'Hour',
				   RIGHT('0' + CONVERT(VARCHAR(2), @hour), 2) + ':00' AS 'HourMinString',
				   RIGHT('0' + CONVERT(VARCHAR(2), @hour), 2) + ':00:00' AS 'HourFullString',
				   @minute AS 'Minute',
				   RIGHT('0' + CONVERT(VARCHAR(2), @hour), 2) + ':' + RIGHT('0' + CONVERT(VARCHAR(2), @minute), 2)
				   + ':00' AS 'MinuteFullString',
				   @second AS 'Second'
			SET @second = @second + 1
		END
		SET @minute = @minute + 1
	END
	SET @hour = @hour + 1
END