--05.01

--FORMA_01
select --CE
(select count(numero) from Telefono) as TOT_TEL,--CI=>El total de teléfonos.
(select count(numero) from Telefono where tipo='LLA') as TOT_TEL_LLA,--CI=>El total de teléfonos del tipo Llamada
(select count(numero) from Telefono where tipo='SMS') as TOT_TEL_SMS,--CI=>El total de teléfonos del tipo Mensajería
(select count(numero) from Telefono where tipo='WSP') as TOT_TEL_WSP--CI=>El total de teléfonos del tipo WhatsApp

--FORMA_02
select --CE
count(numero) as TOT_TEL,--CI=>El total de teléfonos.
(select count(numero) from Telefono where tipo='LLA') as TOT_TEL_LLA,--CI=>El total de teléfonos del tipo Llamada
(select count(numero) from Telefono where tipo='SMS') as TOT_TEL_SMS,--CI=>El total de teléfonos del tipo Mensajería
(select count(numero) from Telefono where tipo='WSP') as TOT_TEL_WSP--CI=>El total de teléfonos del tipo WhatsApp
from Telefono

--05.02

--FORMA_01
select 
(select count(codcliente) from Contrato) as TOT_C,
(select count(co.codcliente) from Contrato co inner join Cliente c on co.codcliente=c.codcliente
 where c.tipo_cliente='E') as TOT_C_E,
(select count(co.codcliente) from Contrato co inner join Cliente c on co.codcliente=c.codcliente
 where c.tipo_cliente='P') as TOT_C_P,
(select count(co.codcliente) from Contrato co left join Cliente c on co.codcliente=c.codcliente
 where c.codcliente is null) as TOT_C_O

 --FORMA_02
 declare @TOT_C int=(select count(codcliente) from Contrato)

 declare @TOT_C_E int=(select count(co.codcliente) from Contrato co inner join Cliente c on co.codcliente=c.codcliente
					   where c.tipo_cliente='E')

 declare @TOT_C_P int=(select count(co.codcliente) from Contrato co inner join Cliente c on co.codcliente=c.codcliente
					   where c.tipo_cliente='P')

 declare @TOT_C_O int=(select count(co.codcliente) from Contrato co left join Cliente c on co.codcliente=c.codcliente
					   where c.codcliente is null)

select @TOT_C as TOT_C,@TOT_C_E as TOT_C_E,@TOT_C_P as TOT_C_P,@TOT_C_O as TOT_C_O