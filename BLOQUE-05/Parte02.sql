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