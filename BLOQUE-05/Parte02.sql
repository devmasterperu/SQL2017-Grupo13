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