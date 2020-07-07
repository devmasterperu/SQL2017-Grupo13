--06.01

--SUBCONSULTAS_SELECT

select codplan as CODPLAN,codcliente as CODCLIENTE,
precio as PRECIO,
(select sum(precio) from Contrato _co where _co.codplan=co.codplan) as PRE_SUM,
(select avg(precio) from Contrato _co where _co.codplan=co.codplan) as PRE_PROM,
(select count(codcliente) from Contrato _co where _co.codplan=co.codplan) as PRE_TOT,
(select min(precio) from Contrato _co where _co.codplan=co.codplan) as PRE_MIN,
(select min(precio) from Contrato _co where _co.codplan=co.codplan) as PRE_MAX
from Contrato co
order by CODPLAN asc,PRECIO asc

--SUBCONSULTAS_FROM

select co.codplan as CODPLAN,codcliente as CODCLIENTE,
precio as PRECIO,
rco.PRE_SUM as PRE_SUM,
rco.PRE_PROM as PRE_PROM,
rco.PRE_TOT as PRE_TOT,
rco.PRE_MIN as PRE_MIN,
rco.PRE_MAX as PRE_MAX
from Contrato co
left join
(
	select codplan, sum(precio) as PRE_SUM,avg(precio) as PRE_PROM,count(codcliente) as PRE_TOT,
	min(precio) as PRE_MIN,max(precio) as PRE_MAX
	from Contrato
	group by codplan
) rco on co.codplan=rco.codplan
order by CODPLAN asc,PRECIO asc

--OVER+AGRUPAMIENTO

select codplan as CODPLAN,codcliente as CODCLIENTE,
precio as PRECIO,
sum(precio) over(partition by co.codplan) as PRE_SUM,
avg(precio) over(partition by co.codplan) as PRE_PROM,
count(precio) over(partition by co.codplan) as PRE_TOT,
min(precio) over(partition by co.codplan) as PRE_MIN,
max(precio) over(partition by co.codplan) as PRE_MAX
from Contrato co
order by CODPLAN asc,PRECIO asc

--VISTAS

create view V_RCO as
select codplan as CODPLAN,codcliente as CODCLIENTE,
precio as PRECIO,
sum(precio) over(partition by co.codplan) as PRE_SUM,
avg(precio) over(partition by co.codplan) as PRE_PROM,
count(precio) over(partition by co.codplan) as PRE_TOT,
min(precio) over(partition by co.codplan) as PRE_MIN,
max(precio) over(partition by co.codplan) as PRE_MAX
from Contrato co

select * from V_RCO
order by CODPLAN asc,PRECIO asc

--06.02

--TABLAS_DERIVADAS

select codcliente as [CODCLIENTE], razon_social as [RAZON SOCIAL],codzona as [COD ZONA], 
MIN(fec_inicio) over (partition by c.codzona) as [E-Min], 
MAX(fec_inicio) over (partition by c.codzona)  as [E-MAX],
COUNT(codcliente) over (partition by c.codzona) as [TotalCliente]
from Cliente c
where tipo_cliente = 'E'
order by codzona asc , fec_inicio asc;

--FUNCION_VALOR_TABLA

alter function F_RCE() returns table
as return
select codcliente as [CODCLIENTE], razon_social as [RAZON SOCIAL],codzona as [COD ZONA],c.fec_inicio as [FEC INICIO],
MIN(fec_inicio) over (partition by c.codzona) as [E-Min], 
MAX(fec_inicio) over (partition by c.codzona)  as [E-MAX],
COUNT(codcliente) over (partition by c.codzona) as [TotalCliente]
from Cliente c
where tipo_cliente = 'E'
	
select * from F_RCE()
order by [COD ZONA] asc, [FEC INICIO] asc




