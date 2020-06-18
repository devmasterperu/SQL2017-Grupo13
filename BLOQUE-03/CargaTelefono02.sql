--Carga Telefono-2
--select * from Cliente where codcliente=1001

--Deshabilitar restricción de Teléfono

ALTER TABLE [dbo].[Telefono] NOCHECK CONSTRAINT [RefCliente6]
GO

insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380328',1001,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380329',1002,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380330',1003,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380331',1004,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380332',1005,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380333',1006,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380334',1007,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380335',1008,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380336',1009,1)
go
insert into Telefono(tipo,numero,codcliente,estado) values ('LLA ','012380337',1010,0)
go

select * from Telefono