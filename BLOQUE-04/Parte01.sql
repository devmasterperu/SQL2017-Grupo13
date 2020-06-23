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