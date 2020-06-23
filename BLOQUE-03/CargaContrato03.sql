USE DevWifi13Ed
go
ALTER TABLE [dbo].[Contrato] NOCHECK CONSTRAINT [RefCliente8]
GO
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (1,1001,'2019-03-29','M',55,'192.168.196.107','RED-954',hashbytes('SHA1','Password1'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (2,1001,'2019-06-01','Q',45,'192.168.57.38','RED-955',hashbytes('SHA1','Password2'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (3,1001,'2019-05-11','M',100,'192.168.170.165','RED-956',hashbytes('SHA1','Password3'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (4,1002,'2019-09-20','Q',45,'192.168.161.29','RED-957',hashbytes('SHA1','Password4'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (5,1002,'2019-05-22','M',100,'192.168.11.98','RED-958',hashbytes('SHA1','Password5'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (1,1002,'2019-02-16','Q',100,'192.168.202.146','RED-959',hashbytes('SHA1','Password6'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (2,1003,'2019-11-24','Q',65,'192.168.211.84','RED-960',hashbytes('SHA1','Password7'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (3,1004,'2019-10-11','Q',90,'192.168.28.231','RED-961',hashbytes('SHA1','Password8'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (4,1005,'2019-09-22','M',90,'192.168.208.181','RED-962',hashbytes('SHA1','Password9'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (5,1006,'2019-01-08','Q',100,'192.168.146.84','RED-963',hashbytes('SHA1','Password10'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (1,1007,'2019-04-06','M',100,'192.168.250.251','RED-964',hashbytes('SHA1','Password11'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (2,1008,'2019-12-09','Q',100,'192.168.213.104','RED-965',hashbytes('SHA1','Password12'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (3,1009,'2019-07-10','M',90,'192.168.39.33','RED-966',hashbytes('SHA1','Password13'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (4,1010,'2019-10-19','Q',100,'192.168.220.93','RED-967',hashbytes('SHA1','Password14'),getdate(),1)
go
insert into contrato(codplan,codcliente,fec_contrato,periodo,precio,ip_router,ssis_red_wifi,contrasena,fechora_registro,estado) values (5,1011,'2019-01-15','M',55,'192.168.239.3','RED-968',hashbytes('SHA1','Password15'),getdate(),1)
go
