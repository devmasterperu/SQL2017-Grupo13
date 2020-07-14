--07.01

--Comando
declare @N1 int=5
declare @N2 int=7

select 'F(N1,N2)'=power(@N1,2)+10*@N1*@N2+power(@N2,2)

--Procedimiento Almacenado
create procedure usp_Polinomio(@N1 int,@N2 int) as
begin
	select 'F(N1,N2)'=power(@N1,2)+10*@N1*@N2+power(@N2,2)
end

exec usp_Polinomio 5,7
execute usp_Polinomio 5,7
execute usp_Polinomio @N1=5,@N2=7
execute sp_helptext 'usp_Polinomio'

--Función escalar
create function f_Polinomio(@N1 int,@N2 int) returns int as
alter function f_Polinomio(@N1 int,@N2 int) returns int as
begin
	/*return power(@N1,2)+10*@N1*@N2+power(@N2,2)*/
	declare @resultado int=(select power(@N1,2)+10*@N1*@N2+power(@N2,2))
	/*MAS COMANDOS*/
	return @resultado
end

select dbo.f_Polinomio(5,7)

--CTE+Función Escalar
WITH CTE_Numeros AS
(
select 5 as N1,7 as N2 union
select 7 as N1,9 as N2 union
select 9 as N1,11 as N2
)
select N1,N2,dbo.f_Polinomio(N1,N2) as 'F(N1,N2)' from CTE_Numeros