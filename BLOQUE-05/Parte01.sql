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

--05.04

select replace(upper(nombre),' ','_') as [PLAN],--REPLACE(EXPRESION,EXPRESION_BUSQUEDA,EXPRESION_ASIGNAR)
(select count(codcliente) from Contrato co where co.codplan=p.codplan) as TOTAL,
case when (select count(codcliente) from Contrato co where co.codplan=p.codplan) between 0 and 99
	 then 'Plan de baja demanda.'
	 when (select count(codcliente) from Contrato co where co.codplan=p.codplan) between 100 and 199
	 then 'Plan de mediana demanda.'
	 when (select count(codcliente) from Contrato co where co.codplan=p.codplan)>=200
	 then 'Plan de alta demanda.'
end as MENSAJE
from PlanInter p
order by TOTAL

--05.05

select
replace(razon_social,' ','-') as CLIENTE,
upper(email) as EMAIL,
(select count(numero) from Telefono t where t.codcliente=c.codcliente and t.estado=1) as [TOTAL-TEL],
case when (select count(numero) from Telefono t where t.codcliente=c.codcliente and t.estado=1) between 0 and 2
	 then 'Cliente empresa con menos de 3 teléfonos'
	 when (select count(numero) from Telefono t where t.codcliente=c.codcliente and t.estado=1) between 3 and 5
	 then 'Cliente empresa con 3 teléfonos a más y menos de 6 teléfonos'
	 when (select count(numero) from Telefono t where t.codcliente=c.codcliente and t.estado=1)>=6
	 then 'Cliente empresa con 6 teléfonos a más'
	 else 'SIN MENSAJE'
end as MENSAJE
from Cliente c
where c.tipo_cliente='E'
order by [TOTAL-TEL] desc

--05.06

select 6.50*1.00/4,round(6.50*1.00/4,2),cast(round(6.50*1.00/4,2) as decimal(6,2))

select upper(nombre) as [PLAN],
(select count(codcliente) from Contrato co where co.codplan=p.codplan) as [TOTAL-P],
(select count(codcliente) from Contrato) as TOTAL,
cast(round((select count(codcliente) from Contrato co where co.codplan=p.codplan)*100.00/(select count(codcliente) from Contrato),2)
as decimal(6,2)) as PORCENTAJE
from PlanInter p
order by [TOTAL-P] desc










