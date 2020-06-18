select * from PlanInter
where codplan=6

ALTER TABLE [dbo].[Contrato] NOCHECK CONSTRAINT [RefPlanInter7]
GO

insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,73,'2019-09-21','Q',65,'192.168.130.174','RED-969',hashbytes('SHA1','Password1'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,318,'2019-08-21','M',100,'192.168.111.127','RED-970',hashbytes('SHA1','Password2'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,417,'2019-08-12','Q',65,'192.168.158.135','RED-971',hashbytes('SHA1','Password3'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,585,'2019-05-15','M',65,'192.168.10.134','RED-972',hashbytes('SHA1','Password4'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,43,'2019-04-28','Q',100,'192.168.52.118','RED-973',hashbytes('SHA1','Password5'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,227,'2019-12-02','M',90,'192.168.129.128','RED-974',hashbytes('SHA1','Password6'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,631,'2019-03-09','Q',45,'192.168.99.182','RED-975',hashbytes('SHA1','Password7'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,759,'2019-11-01','Q',55,'192.168.138.4','RED-976',hashbytes('SHA1','Password8'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,635,'2019-06-15','M',55,'192.168.12.248','RED-977',hashbytes('SHA1','Password9'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,297,'2019-09-21','Q',65,'192.168.104.201','RED-978',hashbytes('SHA1','Password10'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,982,'2019-01-15','M',45,'192.168.122.218','RED-979',hashbytes('SHA1','Password11'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,497,'2019-03-29','Q',45,'192.168.143.203','RED-980',hashbytes('SHA1','Password12'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,95,'2019-08-15','M',65,'192.168.96.47','RED-981',hashbytes('SHA1','Password13'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,334,'2019-06-30','M',45,'192.168.76.194','RED-982',hashbytes('SHA1','Password14'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,251,'2019-02-01','Q',65,'192.168.197.248','RED-983',hashbytes('SHA1','Password15'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (6,550,'2019-04-19','M',90,'192.168.51.77','RED-984',hashbytes('SHA1','Password16'),getdate(),1)
go

select * from Contrato
where codplan=6