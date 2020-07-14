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

	if exists(select 1 from Cliente where codcliente=@codcliente) --Cliente SI existe
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
	else --Cliente  NO existe
	begin
		select 'El cliente no ha sido encontrado en la Base de Datos'
	end
end

execute usp_selCliente @codcliente=100 --CLIENTE_EMPRESA
execute usp_selCliente @codcliente=500 --CLIENTE_PERSONA
execute usp_selCliente @codcliente=10000 --CLIENTE_NO_EXISTENTE

--07.06

create procedure usp_InsUbigeo(@cod_dpto char(20),@nom_dpto varchar(50),
@cod_prov char(3),@nom_prov varchar(50),@cod_dto char(2),@nom_dto varchar(100)) as
begin
	/*SI cod_dpto+cod_prov+cod_dto NO existe*/
	if not exists(select 1 from Ubigeo where cod_dpto=@cod_dpto and 
	                                         cod_prov=@cod_prov and 
											 cod_dto=@cod_dto)
	begin
	  --Insertar Ubigeo
	  insert into dbo.Ubigeo(cod_dpto,nom_dpto,cod_prov,nom_prov,cod_dto,nom_dto)
	  values (@cod_dpto,@nom_dpto,@cod_prov,@nom_prov,@cod_dto,@nom_dto)
	  --Mostrar el mensaje 'Ubigeo insertado' y el codubigeo asignado
	  select 'Ubigeo insertado' as MENSAJE,IDENT_CURRENT('dbo.Ubigeo') as CODUBIGEO
	end
	/*SI cod_dpto+cod_prov+cod_dto SI existe*/
	else
	begin
	  --Mostrar el mensaje 'Ubigeo existente' y retornar el codubigeo con valor 0
	  select 'Ubigeo existente' as MENSAJE,0 as CODUBIGEO
	end
end

execute usp_InsUbigeo @cod_dpto='01',@nom_dpto='AMAZONAS',@cod_prov='02',@nom_prov='BAGUA',
@cod_dto='01',@nom_dto='BAGUA' --INSERCION_OK

execute usp_InsUbigeo @cod_dpto='01',@nom_dpto='AMAZONAS',@cod_prov='02',@nom_prov='BAGUA',
@cod_dto='01',@nom_dto='BAGUA' --INSERCION_NO_OK

execute usp_InsUbigeo @cod_dpto='01',@nom_dpto='AMAZONAS',@cod_prov='02',@nom_prov='BAGUA',
@cod_dto='03',@nom_dto='BAGUA' --INSERCION_OK

select top 1 * from Cliente order by codcliente desc
select ident_current('dbo.Cliente')

--07.07

create procedure usp_planInter(@nombre varchar(50), @precioref decimal(6,2),@descripcion varchar(200), @estado bit) as
begin
	if not exists(select 1 from PlanInter where nombre = @nombre)
	begin
		insert into dbo.PlanInter(nombre, precioref, descripcion, estado) 
		values (@nombre, @precioref, @descripcion,@estado)
	    
		select 'Plan Internet insertado' as MENSAJE,IDENT_CURRENT('dbo.PlanInter') as CODPLAN
	end
	else
	begin
		select 'Plan Internet existente' as MENSAJE,0 as CODPLAN
	end
end

execute usp_planInter @nombre='FAMILIAR', @precioref=100.99,@descripcion='PLAN DE HASTA 3 MODEMS', @estado=1

execute usp_planInter @nombre='FAMILIAR TOTAL', @precioref=100.99,@descripcion='PLAN DE HASTA 3 MODEMS', @estado=1

--07.08

create procedure usp_ActClienteE(@codcliente int,
@codtipo int,@numdoc varchar(15),@razon_social varchar(255),@fecinicio date,
@email varchar(320),@direccion varchar(250),@codzona int,@estado bit)
as
begin 
	/*SI EXISTE CODCLIENTE+TIPO_CLIENTE*/
	if exists(select codcliente from Cliente where codcliente=@codcliente and tipo_cliente='E')
	begin
	--Actualizar Cliente Empresa
	  update Cliente
	  set    codtipo=@codtipo,
	         numdoc=@numdoc,
			 razon_social=@razon_social,
			 fec_inicio=@fecinicio,
			 email=@email,
			 direccion=@direccion,
			 codzona=@codzona,
			 estado=@estado
	  where codcliente=@codcliente and tipo_cliente='E'
	--Mostrar el mensaje 'Cliente empresa actualizado' y el codcliente actualizado
	  select 'Cliente empresa actualizado' as MENSAJE,@codcliente as CODCLIENTE
	end
	/*SI NO EXISTE CODCLIENTE+TIPO_CLIENTE*/
	else
	begin
	--Mostrar el mensaje ‘No es posible identificar al cliente empresa a actualizar’ y retornar también el codcliente
	  select 'No es posible identificar al cliente empresa a actualizar' as MENSAJE,@codcliente as CODCLIENTE
	end
end

select * from Cliente where codcliente=10
--10	3	79485452314	E	NULL	NULL	NULL	NULL	NULL	EMPRESA 10	2007-06-21	CONTACTO@EMPRESA10.pe	CA. JR. LIMA 748	5	1
--10	3	79485452320	E	NULL	NULL	NULL	NULL	NULL	RESTAURANT PAQUIRRI	2020-07-13	CONTACTO@PAQUIRRI.PE	CA. JUAN BARRETO 422	1	0
--10	3	79485452320	E	NULL	NULL	NULL	NULL	NULL	RESTAURANT PAQUIRRI	2020-07-13	INFO@PAQUIRRI.PE	CA. JUAN BARRETO 422	1	0
execute usp_ActClienteE @codcliente=10,@codtipo=3,@numdoc='79485452320',@razon_social='RESTAURANT PAQUIRRI',
@fecinicio='2020-07-13',@email='INFO@PAQUIRRI.PE',@direccion='CA. JUAN BARRETO 422',@codzona=1,@estado=0

--07.10
insert into Configuracion(variable,valor) values 
('TIPO_ERROR','TTT'),
('NUMERO_ERROR','999999999')

alter procedure usp_DelTelefono(@tipo varchar(3),@numero varchar(15))
as
begin
	/*SI EXISTE TIPO+NUMERO*/
	if exists(select numero from Telefono where numero=@numero and tipo=@tipo)
	begin
	--Eliminar teléfono
	  Delete from Telefono where numero=@numero and tipo=@tipo
	--Mostrar el mensaje 'Teléfono eliminado', el tipo y número eliminado.
	  Select 'Teléfono eliminado' as MENSAJE,@tipo as TIPO,@numero as NUMERO
	end
	/*SI NO EXISTE TIPO+NUMERO*/
	else
	begin
	--Mostrar el mensaje 'No es posible identificar al teléfono a eliminar', 
	--el tipo con valor 'TTT' y el número con valor '999999999'. 
	  set @tipo=(select valor from Configuracion where variable='TIPO_ERROR')
	  set @numero=(select valor from Configuracion where variable='NUMERO_ERROR')
	  select 'No es posible identificar al teléfono a eliminar' as MENSAJE,@tipo as TIPO,@numero as NUMERO
	end
end

--SIN_CAMBIO_CONFIGURACIONES
execute usp_DelTelefono @tipo='LLA',@numero='915703551'

update Configuracion set valor='NNN'
where variable='TIPO_ERROR'

update Configuracion set valor='000000000'
where variable='NUMERO_ERROR'

--CON_CAMBIO_CONFIGURACIONES
execute usp_DelTelefono @tipo='LLA',@numero='915703551'