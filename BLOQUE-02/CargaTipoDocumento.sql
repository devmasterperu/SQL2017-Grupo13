--Carga de Tipo de Documento

INSERT INTO TipoDocumento(desclarga,descorta) values ('LIBRETA ELECTORAL O DNI','L.E / DNI')
go
INSERT INTO TipoDocumento(desclarga,descorta) values ('CARNET DE EXTRANJERIA','CARNET EXT.')
go
INSERT INTO TipoDocumento(desclarga,descorta) values ('REG. UNICO DE CONTRIBUYENTES','RUC')
go
INSERT INTO TipoDocumento(desclarga,descorta) values ('PASAPORTE','PASAPORTE')
go
INSERT INTO TipoDocumento(desclarga,descorta) values ('PART. DE NACIMIENTO-IDENTIDAD','P. NAC.')
go
INSERT INTO TipoDocumento(desclarga,descorta) values ('OTROS','OTROS')
go

select * from TipoDocumento