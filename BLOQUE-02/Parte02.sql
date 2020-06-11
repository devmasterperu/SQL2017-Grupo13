--02.06

--a
select codzona as CODZONA,nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case when estado=1 then 'Zona activa'
	 when estado=0 then 'Zona inactiva'
	 else 'Sin detalle' 
	 end as [MENSAJE ESTADO]
from Zona
where 
estado=1 --P
and
codubigeo=1 --Q
order by codzona desc --Mayor a menor

--b

select codzona as CODZONA,nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case when estado=1 then 'Zona activa'
	 when estado=0 then 'Zona inactiva'
	 else 'Sin detalle' 
	 end as [MENSAJE ESTADO]
from Zona
where 
estado=1 --P
and
codubigeo=1 --Q
order by nombre desc --Alfabéticamente Z-A

--c

select codzona as CODZONA,nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case when estado=1 then 'Zona activa'
	 when estado=0 then 'Zona inactiva'
	 else 'Sin detalle' 
	 end as [MENSAJE ESTADO]
from Zona
where 
estado=0 --P
or
codubigeo=1 --Q
order by estado asc --Menor a mayor

--d

select codzona as CODZONA,nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case when estado=1 then 'Zona activa'
	 when estado=0 then 'Zona inactiva'
	 else 'Sin detalle' 
	 end as [MENSAJE ESTADO]
from Zona
where 
estado=1 --P
or
codubigeo=1 --Q
order by codubigeo desc,nombre asc --1° nivel x codubigeo de mayor a menor, 2° nivel nombre A-Z

--e

--NUM_RES(estado=1 and codubigeo=1)+NUM_RES(NOT (estado=1 and codubigeo=1 ))=#ZONA

select codzona as CODZONA,nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case when estado=1 then 'Zona activa'
	 when estado=0 then 'Zona inactiva'
	 else 'Sin detalle' 
	 end as [MENSAJE ESTADO]
from Zona
where 
--estado=1 and codubigeo=1 
NOT (estado=1 and codubigeo=1 )
order by codzona asc --Menor a mayor
