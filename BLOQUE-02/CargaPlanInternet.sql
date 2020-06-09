
--Carga de planes de internet

insert into PlanInter(nombre,precioref,descripcion) values ('PLAN TOTAL I',50,'Plan anterior ESTANDAR I')
go --Guardar en la tabla PlanInter(nombre,precioref,descripcion) valores (...)
insert into PlanInter(nombre,precioref,descripcion) values ('PLAN TOTAL II',60,'Plan anterior ESTANDAR II')
go
insert into PlanInter(nombre,precioref,descripcion) values ('GOLD I',70,'Plan nuevo')
go
insert into PlanInter(nombre,precioref,descripcion) values ('GOLD II',90,'Plan nuevo')
go
insert into PlanInter(nombre,precioref,descripcion) values ('GOLD III',100,'Plan nuevo')
go

select * from PlanInter
