--06.09

--a
create view V_UBIGEOS_UA as 
select cod_dpto,cod_prov,cod_dto from dbo.Ubigeo --29
union all
select cod_dpto,cod_prov,cod_dto from comercial.Ubigeo --24

select * from V_UBIGEOS_UA

--b
create function F_UBIGEOS_U() returns table as
return
	select cod_dpto,cod_prov,cod_dto from dbo.Ubigeo 
	union
	select cod_dpto,cod_prov,cod_dto from comercial.Ubigeo

select * from F_UBIGEOS_U()

--06.11

--a
WITH CTE_IT AS
(
select tipo,numero,codcliente,estado from dbo.Telefono --1203
intersect --19
select tipo,numero,codcliente,estado  from comercial.Telefono --50
)
select it.codcliente as CODIGO,
case 
	when c.tipo_cliente='E' then c.razon_social 
	when c.tipo_cliente='P' then c.nombres+' '+c.ape_paterno+' '+c.ape_materno
	else 'SIN DATO'
end as CLIENTE,it.tipo as TIPO,it.numero as NUMERO,it.estado as ESTADO,
/*Es la posici�n que ocupa el tel�fono dentro de cada cliente, 
ordenado por n�mero de menor a mayor*/
row_number() over (partition by it.codcliente order by it.numero asc) as POSICION
from CTE_IT it left join Cliente c on it.codcliente=c.codcliente
order by it.codcliente,it.numero