CREATE FUNCTION getDataPascoa (@ano INT)
RETURNS SMALLDATETIME
AS
BEGIN
    DECLARE @seculo INT, @G INT, @K INT, @I INT, @H INT, @J INT, @L INT, 
	@MesDePascoa INT, @DiaDePascoa INT, @pascoa SMALLDATETIME;
 
    SET @seculo = @ano / 100
    SET @G = @ano % 19
    SET @K = ( @seculo - 17 ) / 25
    SET @I = ( @seculo - CAST(@seculo / 4 AS INT) - CAST(( @seculo - @K ) / 3 AS INT) + 19 * @G + 15 ) % 30
    SET @H = @I - CAST(@I / 28 AS INT) * ( 1 * -CAST(@I / 28 AS INT) * CAST(29 / ( @I + 1 ) AS INT) ) * CAST(( ( 21 - @G ) / 11 ) AS INT)
    SET @J = ( @ano + CAST(@ano / 4 AS INT) + @H + 2 - @seculo + CAST(@seculo / 4 AS INT) ) % 7
    SET @L = @H - @J
    SET @MesDePascoa = 3 + CAST(( @L + 40 ) / 44 AS INT)
    SET @DiaDePascoa = @L + 28 - 31 * CAST(( @MesDePascoa / 4 ) AS INT)
    SET @pascoa = CAST(@MesDePascoa AS VARCHAR(2)) + '-' + CAST(@DiaDePascoa AS VARCHAR(2)) + '-' + CAST(@ano AS VARCHAR(4))
RETURN @pascoa;
END


SELECT dbo.[getDataPascoa](2015)

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Feriado (
 dia DATETIME NOT NULL, 
 feriado VARCHAR (100)

)



CREATE PROCEDURE prAtualizaTabelaFeriado

(
	@ano INT
)

AS 
BEGIN
	DECLARE @pascoa SMALLDATETIME;
	DECLARE @dia INT;
	DECLARE @mes INT;
	DECLARE @anoPascoa INT;

	IF (@ano IS NULL)
	 BEGIN
	 --DATEPART = PEGA PARTE DA DATA 
		SET @ano = DATEPART(YEAR, GETDATE())		
	END
	SET @pascoa = dbo.getDataPascoa(@ano);
	SET @dia = DATEPART(DAY, @dia);
	SET @mes = DATEPART(MONTH, @mes);
	SET @ano = DATEPART(YEAR, @ano);

	DELETE FROM Feriado;
	 
	 INSERT INTO Feriado (dia, feriado) 
	 VALUES (@pascoa, 'Pascoa');

	 INSERT INTO Feriado (dia, feriado) 
	 VALUES (CAST ('01-01-' + CAST(@anoPascoa AS VARCHAR) + '00:00:00.000' 
	 AS DATETIME), 'Confraternização Universal');

	 INSERT INTO Feriado (dia, feriado) 
	 VALUES (DATEADD(DAY, 60, @pascoa), 'Corpus Christ');

	 INSERT INTO Feriado (dia, feriado) 
	 VALUES (DATEADD(DAY, -2, @pascoa), 'Sexta feira santa');

	 INSERT INTO Feriado (dia, feriado)
	 VALUES (DATEADD(DAY, -47, @pascoa), 'Carnaval');

END

SELECT *FROM Feriado