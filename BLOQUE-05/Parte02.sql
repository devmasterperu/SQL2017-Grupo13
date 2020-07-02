--05.08

--SUBCONSULTAS_SELECT
select upper(nombre) as [PLAN],
isnull((select count(codcliente) from Contrato co where co.codplan=p.codplan),0) as [CO-TOTAL],
isnull((select avg(precio) from Contrato co where co.codplan=p.codplan),0.00) as [CO-PROM],--Monto promedio de precios 
isnull((select min(fec_contrato) from Contrato co where co.codplan=p.codplan),'9999-12-31') as [CO-ANTIGUO],--Fecha de contrato más antigua 
isnull((select max(fec_contrato) from Contrato co where co.codplan=p.codplan),'9999-12-31') as [CO-RECIENTE]--Fecha de contrato más reciente 
from PlanInter p
order by [CO-TOTAL] desc

--SUBCONSULTAS_FROM

select upper(nombre) as [PLAN],
isnull(rp.total,0) as [CO-TOTAL],
isnull(rp.prom,0.00) as [CO-PROM],--Monto promedio de precios 
isnull(rp.min,'9999-12-31') as [CO-ANTIGUO],--Fecha de contrato más antigua 
isnull(rp.max,'9999-12-31') as [CO-RECIENTE]--Fecha de contrato más reciente 
from PlanInter p
left join
(
select codplan,count(codcliente) as total,avg(precio) as prom,min(fec_contrato) as min,max(fec_contrato) as max
from Contrato
group by codplan
) rp on p.codplan=rp.codplan
order by [CO-TOTAL] desc

--CTES
WITH CTE_RP AS
(
	select codplan,count(codcliente) as total,avg(precio) as prom,min(fec_contrato) as min,max(fec_contrato) as max
	from Contrato
	group by codplan
)
select upper(nombre) as [PLAN],
isnull(rp.total,0) as [CO-TOTAL],
isnull(rp.prom,0.00) as [CO-PROM],--Monto promedio de precios 
isnull(rp.min,'9999-12-31') as [CO-ANTIGUO],--Fecha de contrato más antigua 
isnull(rp.max,'9999-12-31') as [CO-RECIENTE]--Fecha de contrato más reciente 
from PlanInter p
left join CTE_RP rp on p.codplan=rp.codplan
order by [CO-TOTAL] desc

--VISTAS

create view v_resumen_plan as --Crear una vista
alter view v_resumen_plan as  --Modificar una vista
drop view v_resumen_plan      --Eliminar una vista
WITH CTE_RP AS
(
	select codplan,count(codcliente) as total,avg(precio) as prom,min(fec_contrato) as min,max(fec_contrato) as max
	from Contrato
	group by codplan
)
select upper(nombre) as [PLAN],
isnull(rp.total,0) as [CO-TOTAL],
isnull(rp.prom,0.00) as [CO-PROM],--Monto promedio de precios 
isnull(rp.min,'9999-12-31') as [CO-ANTIGUO],--Fecha de contrato más antigua 
isnull(rp.max,'9999-12-31') as [CO-RECIENTE],--Fecha de contrato más reciente 
getdate() as [FEC-CONSULTA]
from PlanInter p
left join CTE_RP rp on p.codplan=rp.codplan
--order by [CO-TOTAL] desc

select * from v_resumen_plan
order by [CO-TOTAL] desc

--05.10

select codcliente,count(numero) as total from Telefono group by codcliente
select codcliente,count(codcliente) as total from Contrato group by codcliente

----SUBCONSULTAS_FROM
select c.codcliente as [COD-CLIENTE],concat(nombres,' ',ape_paterno,' ',ape_materno) as CLIENTE,
isnull(rt.total,0) as [TOT-TE],
isnull(rc.total,0) as [TOT-CO]
from Cliente c
left join 
(select codcliente,count(numero) as total from Telefono group by codcliente) rt on c.codcliente=rt.codcliente
left join
(select codcliente,count(codcliente) as total from Contrato group by codcliente) rc on c.codcliente=rc.codcliente
where tipo_cliente='P'
order by [TOT-TE] asc, [TOT-CO] asc

--CTES
WITH 
CTE_RT AS (select codcliente,count(numero) as total from Telefono group by codcliente),
CTE_RC AS (select codcliente,count(codcliente) as total from Contrato group by codcliente)
select c.codcliente as [COD-CLIENTE],concat(nombres,' ',ape_paterno,' ',ape_materno) as CLIENTE,
isnull(rt.total,0) as [TOT-TE],
isnull(rc.total,0) as [TOT-CO]
from Cliente c
left join CTE_RT rt on c.codcliente=rt.codcliente
left join CTE_RC rc on c.codcliente=rc.codcliente
where tipo_cliente='P'
order by [TOT-TE] asc, [TOT-CO] asc

--VISTAS
create view V_RESUMEN_CLIENTE AS
WITH 
CTE_RT AS (select codcliente,count(numero) as total from Telefono group by codcliente),
CTE_RC AS (select codcliente,count(codcliente) as total from Contrato group by codcliente)
select c.codcliente as [COD-CLIENTE],concat(nombres,' ',ape_paterno,' ',ape_materno) as CLIENTE,
isnull(rt.total,0) as [TOT-TE],
isnull(rc.total,0) as [TOT-CO]
from Cliente c
left join CTE_RT rt on c.codcliente=rt.codcliente
left join CTE_RC rc on c.codcliente=rc.codcliente
where tipo_cliente='P'

select * from V_RESUMEN_CLIENTE order by [TOT-TE] asc, [TOT-CO] asc

--FUNCION_VALOR_TABLA
--declare @COD_CLIENTE int=443

--select c.codcliente as [COD-CLIENTE],concat(nombres,' ',ape_paterno,' ',ape_materno) as CLIENTE,
--isnull(rt.total,0) as [TOT-TE],
--isnull(rc.total,0) as [TOT-CO]
--from Cliente c
--left join 
--(select codcliente,count(numero) as total from Telefono group by codcliente) rt on c.codcliente=rt.codcliente
--left join
--(select codcliente,count(codcliente) as total from Contrato group by codcliente) rc on c.codcliente=rc.codcliente
--where tipo_cliente='P' and c.codcliente=@COD_CLIENTE

create function F_REPORTE_CLIENTE (@COD_CLIENTE int) returns table
as return
	WITH 
	CTE_RT AS (select codcliente,count(numero) as total from Telefono group by codcliente),
	CTE_RC AS (select codcliente,count(codcliente) as total from Contrato group by codcliente)
	select c.codcliente as [COD-CLIENTE],concat(nombres,' ',ape_paterno,' ',ape_materno) as CLIENTE,
	isnull(rt.total,0) as [TOT-TE],
	isnull(rc.total,0) as [TOT-CO]
	from Cliente c
	left join CTE_RT rt on c.codcliente=rt.codcliente
	left join CTE_RC rc on c.codcliente=rc.codcliente
	where tipo_cliente='P' and c.codcliente=@COD_CLIENTE

select * from F_REPORTE_CLIENTE(402)

create function F_REPORTE_CLIENTE_2 (@COD_CLIENTE int) returns table
as return
	select [COD-CLIENTE],CLIENTE,[TOT-TE],[TOT-CO] from V_RESUMEN_CLIENTE
	where [COD-CLIENTE]=@COD_CLIENTE

select * from F_REPORTE_CLIENTE_2(402)


--05.11

--SUBCONSULTAS_SELECT

select c.codcliente as CODIGO,c.razon_social as EMPRESA,
(select count(numero) from Telefono t where t.codcliente=c.codcliente) as [TOT-TE],
(select count(numero) from Telefono t where t.codcliente=c.codcliente and t.tipo='LLA') as [TOT-LLA],
(select count(numero) from Telefono t where t.codcliente=c.codcliente and t.tipo='SMS') as [TOT-SMS],
(select count(numero) from Telefono t where t.codcliente=c.codcliente and t.tipo='WSP') as [TOT-WSP]
from Cliente c
where c.tipo_cliente='E'
order by [TOT-TE] desc, [TOT-LLA] desc

--SUBCONSULTAS_FROM

select c.codcliente as CODIGO,c.razon_social as EMPRESA,
isnull(rlla.total,0) +isnull(rsms.total,0)+isnull(rwsp.total,0)  as [TOT-TE],
isnull(rlla.total,0) as [TOT-LLA],
isnull(rsms.total,0) as [TOT-SMS],
isnull(rwsp.total,0) as [TOT-WSP]
from Cliente c
left join 
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='LLA' group by codcliente
) rlla on c.codcliente=rlla.codcliente
left join
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='SMS' group by codcliente
) rsms on c.codcliente=rsms.codcliente
left join
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='WSP' group by codcliente
) rwsp on c.codcliente=rwsp.codcliente
where c.tipo_cliente='E'
order by [TOT-TE] desc, [TOT-LLA] desc

--CTES
WITH CTE_RLLA AS
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='LLA' group by codcliente
),CTE_RSMS AS
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='SMS' group by codcliente
),CTE_WSP AS 
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='WSP' group by codcliente
) 
select c.codcliente as CODIGO,c.razon_social as EMPRESA,
isnull(rlla.total,0) +isnull(rsms.total,0)+isnull(rwsp.total,0)  as [TOT-TE],
isnull(rlla.total,0) as [TOT-LLA],
isnull(rsms.total,0) as [TOT-SMS],
isnull(rwsp.total,0) as [TOT-WSP]
from Cliente c
left join CTE_RLLA as rlla on c.codcliente=rlla.codcliente
left join CTE_RSMS as rsms on c.codcliente=rsms.codcliente
left join CTE_WSP as rwsp on c.codcliente=rwsp.codcliente
where c.tipo_cliente='E'
order by [TOT-TE] desc, [TOT-LLA] desc

--VISTAS
create view V_RESUMEN_TELEFONOS as
WITH CTE_RLLA AS
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='LLA' group by codcliente
),CTE_RSMS AS
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='SMS' group by codcliente
),CTE_WSP AS 
(
	select codcliente,count(numero) as total from Telefono 
	where tipo='WSP' group by codcliente
) 
select c.codcliente as CODIGO,c.razon_social as EMPRESA,
isnull(rlla.total,0) +isnull(rsms.total,0)+isnull(rwsp.total,0)  as [TOT-TE],
isnull(rlla.total,0) as [TOT-LLA],
isnull(rsms.total,0) as [TOT-SMS],
isnull(rwsp.total,0) as [TOT-WSP]
from Cliente c
left join CTE_RLLA as rlla on c.codcliente=rlla.codcliente
left join CTE_RSMS as rsms on c.codcliente=rsms.codcliente
left join CTE_WSP as rwsp on c.codcliente=rwsp.codcliente
where c.tipo_cliente='E'

select * from V_RESUMEN_TELEFONOS
order by [TOT-TE] desc, [TOT-LLA] desc

--FUNCION_VALOR_TABLA

create function F_RESUMEN_TELEFONOS(@CODIGO int) returns table as
return
	WITH CTE_RLLA AS
	(
		select codcliente,count(numero) as total from Telefono 
		where tipo='LLA' group by codcliente
	),CTE_RSMS AS
	(
		select codcliente,count(numero) as total from Telefono 
		where tipo='SMS' group by codcliente
	),CTE_WSP AS 
	(
		select codcliente,count(numero) as total from Telefono 
		where tipo='WSP' group by codcliente
	) 
	select c.codcliente as CODIGO,c.razon_social as EMPRESA,
	isnull(rlla.total,0) +isnull(rsms.total,0)+isnull(rwsp.total,0)  as [TOT-TE],
	isnull(rlla.total,0) as [TOT-LLA],
	isnull(rsms.total,0) as [TOT-SMS],
	isnull(rwsp.total,0) as [TOT-WSP]
	from Cliente c
	left join CTE_RLLA as rlla on c.codcliente=rlla.codcliente
	left join CTE_RSMS as rsms on c.codcliente=rsms.codcliente
	left join CTE_WSP as rwsp on c.codcliente=rwsp.codcliente
	where c.tipo_cliente='E' and c.codcliente=@CODIGO

select * from F_RESUMEN_TELEFONOS(39)

--FUNCION_VALOR_TABLA+VISTA
create function F_RESUMEN_TELEFONOS_2(@CODIGO int) returns table as
return 
	select [CODIGO],[EMPRESA],[TOT-TE],[TOT-LLA],[TOT-SMS],[TOT-WSP] 
	from V_RESUMEN_TELEFONOS
	where CODIGO=@CODIGO

select * from F_RESUMEN_TELEFONOS_2(38)

--05.13

--Precio promedio de los contratos activos
select avg(precio)
from Contrato
where estado=1

--SUBCONSULTA_WHERE
select 
case when c.tipo_cliente='E' then c.razon_social
	 when c.tipo_cliente='P' then concat(c.nombres,' ',c.ape_paterno,' ',c.ape_materno)
	 else 'SIN DATO'
end as CLIENTE,
isnull(p.nombre,'SIN DATO') as [PLAN],
isnull(co.fec_contrato,'9999-12-31') as FECHA,
isnull(co.precio,0.00) as PRECIO,
cast(round((select avg(precio) from Contrato where estado=1),2) as decimal(8,2)) as PROMEDIO,
EOMONTH(getdate()) as F_CIERRE--OBTENER_ULTIMO_DIA_MES_FECHA
from Contrato co
left join PlanInter p on co.codplan=p.codplan
left join Cliente c on co.codcliente=c.codcliente
where precio>(select avg(precio) from Contrato where estado=1)