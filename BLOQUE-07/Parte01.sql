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

--07.03

create procedure USP_REPORTE_TEL(@tipo varchar(3),@mensaje varchar(500)) as
begin
	select tipo as TIPO,numero as NUMERO,@mensaje as MENSAJE from Telefono
	where estado=1 and tipo=@tipo
end

EXECUTE USP_REPORTE_TEL @tipo= 'LLA',
@mensaje= 'Hola, no olvide realizar el pago de su servicio de Internet' 

EXECUTE USP_REPORTE_TEL @tipo= 'LLA',
@mensaje= 'Hola, no olvide que el último día de pago es el 31/07' 

EXECUTE USP_REPORTE_TEL @tipo= 'SMS',
@mensaje= 'Hola, muchas gracias por su preferencia. Tenemos excelentes promociones para usted'

EXECUTE USP_REPORTE_TEL @tipo= 'WSP', 
@mensaje= 'Hola, hasta el 15/07 recibe un 20% de descuento en tu facturación'

--07.05

create table dbo.Configuracion
(
codconfig int identity(1,1) primary key,
variable varchar(300) not null,
valor varchar(300) not null
)

insert into dbo.Configuracion(variable,valor) values
('RAZON_SOCIAL_DEVWIFI','DEV MASTER PERÚ SAC'),
('RUC_DEVWIFI','20602275320')

create procedure usp_selCliente(@codcliente int) as
alter procedure usp_selCliente(@codcliente int) as
begin
	/*Datos Generales*/
	select
	(select valor from dbo.Configuracion where variable='RAZON_SOCIAL_DEVWIFI') as [RAZON_SOCIAL_DEVWIFI],
	(select valor from dbo.Configuracion where variable='RUC_DEVWIFI') as [RUC_DEVWIFI]

	/*Datos Cliente*/
	select getdate() as [CONSULTA AL], 
	       case when tipo_cliente='E' then razon_social
	            when tipo_cliente='P' then nombres+' '+ape_paterno+' '+ape_materno
		   else 'SIN INFO'
	       end as [CLIENTE],
	       direccion as [DIRECCION],
		   z.nombre as [ZONA]
	from Cliente c left join Zona z on c.codzona=z.codzona
	where codcliente=@codcliente
end

execute usp_selCliente @codcliente=100 --CLIENTE_EMPRESA
execute usp_selCliente @codcliente=500 --CLIENTE_PERSONA