--04.01
--a
insert into PlanInter(nombre,precioref,descripcion)
values ('GOLD IV',110.00,'Solicitado por comité junio 2020.')

select nombre,precioref,descripcion from PlanInter where nombre='GOLD IV'

--b
--c
insert into PlanInter(nombre,precioref,descripcion)
values 
('PREMIUM II',140.00,'Solicitado por comité junio 2020.'),
('PREMIUM III',160.00,'Solicitado por comité junio 2020.'),
('PREMIUM IV',180.00,'Solicitado por comité junio 2020.')

select nombre,precioref,descripcion from PlanInter 
where nombre in ('PREMIUM II','PREMIUM III','PREMIUM IV')

--d
insert into PlanInter(descripcion,precioref,nombre)
values 
('Solicitado por comité junio 2020.',190.00,'STAR I')

select nombre,precioref,descripcion from PlanInter 
where nombre='STAR I'

--e
/*Agregar a los planes la columna fechoraregistro con valor predeterminado de 
Fecha y hora actual.*/

alter table PlanInter add fechoraregistro datetime default getdate()

insert into PlanInter(nombre,precioref,descripcion)
values ('STAR II',200.00,'Solicitado por comité junio 2020.')

/*Agregar a los planes la columna estado con valor predeterminado de false.*/
alter table PlanInter add estado bit default 0

insert into PlanInter(nombre,precioref,descripcion,fechoraregistro)
values ('STAR III',210.00,'Solicitado por comité junio 2020.','2020-06-22 21:00:00.000')

select nombre,precioref,descripcion,fechoraregistro from PlanInter 

--04.02
--a
begin tran
	delete from Zona where codzona>=1013
rollback

DBCC CHECKIDENT ('Zona', RESEED,23); --RESETEAR CODZONA A 23.SGTE_VALOR SERÁ 24.

insert into Zona(nombre,estado,codubigeo)
select nombre,1,u.codubigeo 
from Zona_Carga as zc
inner join Ubigeo as u on 
rtrim(ltrim(zc.departamento))=rtrim(ltrim(u.nom_dpto)) and 
rtrim(ltrim(zc.provincia))=rtrim(ltrim(u.nom_prov)) and
rtrim(ltrim(zc.distrito))=rtrim(ltrim(u.nom_dto)) 
where estado='ACTIVO'

select codzona,nombre,estado,codubigeo from Zona

--b

begin tran
	delete from Zona where codzona>=30
rollback

DBCC CHECKIDENT ('Zona', RESEED,29); --RESETEAR CODZONA A 29.SGTE_VALOR SERÁ 30.

--create procedure usp_selzonacarga as
alter procedure usp_selzonacarga as
select nombre,0,u.codubigeo 
from Zona_Carga as zc
inner join Ubigeo as u on 
rtrim(ltrim(zc.departamento))=rtrim(ltrim(u.nom_dpto)) and 
rtrim(ltrim(zc.provincia))=rtrim(ltrim(u.nom_prov)) and
rtrim(ltrim(zc.distrito))=rtrim(ltrim(u.nom_dto)) 
where estado='INACTIVO'

insert into Zona(nombre,estado,codubigeo)
execute usp_selzonacarga

select codzona,nombre,estado,codubigeo from Zona

--c

alter procedure usp_selzonacarga as
select nombre,0,u.codubigeo 
from Zona_Carga as zc
inner join Ubigeo as u on 
rtrim(ltrim(zc.departamento))=rtrim(ltrim(u.nom_dpto)) and 
rtrim(ltrim(zc.provincia))=rtrim(ltrim(u.nom_prov)) and
rtrim(ltrim(zc.distrito))=rtrim(ltrim(u.nom_dto)) 
where estado is null --Zonas en estado desconocido

insert into Zona(nombre,estado,codubigeo)
execute usp_selzonacarga

select codzona,nombre,estado,codubigeo from Zona

--04.03

SET IDENTITY_INSERT dbo.Zona ON;  --Inserción de Codzona se habilita

insert into Zona(codzona,nombre,estado,codubigeo)--Codzona es autogenerado
values (13,'CAJATAMBO-A',1,18)
go

insert into Zona(codzona,nombre,estado,codubigeo)--Codzona es autogenerado
values (14,'CAJATAMBO-B',1,18)
go

insert into Zona(codzona,nombre,estado,codubigeo)--Codzona es autogenerado
values (15,'CAJATAMBO-C',1,18)
go

SET IDENTITY_INSERT dbo.Zona OFF;  --Inserción de Codzona se deshabilita

select codzona,nombre,estado,codubigeo from Zona
order by codzona

--04.05

begin tran --COLOCAR_SIEMPRE
	delete from Telefono
	where codcliente=18 and tipo<>'LLA'
rollback   --COLOCAR_SIEMPRE

select * from Telefono --6
where codcliente=18 and tipo<>'LLA'

--04.07

begin tran --COLOCAR_SIEMPRE
	delete co
	from Contrato co
	inner join Cliente c on co.codcliente=c.codcliente
	inner join Zona z on c.codzona=z.codzona
	inner join Ubigeo u on z.codubigeo=u.codubigeo
	where c.tipo_cliente='P' and c.estado=0 and 
		  u.cod_dpto='15' and u.cod_prov='08' and u.cod_dto='01'
rollback   --COLOCAR_SIEMPRE

select co.*
from Contrato co
	inner join Cliente c on co.codcliente=c.codcliente
	inner join Zona z on c.codzona=z.codzona
	inner join Ubigeo u on z.codubigeo=u.codubigeo
where c.tipo_cliente='P' and c.estado=0 and 
		u.cod_dpto='15' and u.cod_prov='08' and u.cod_dto='01'