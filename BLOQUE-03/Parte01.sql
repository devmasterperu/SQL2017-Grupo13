--03.01

--a
select codcliente from Cliente --LI [1000]
select codplan from PlanInter  --LD [5]

select c.codcliente,p.codplan
from Cliente as c cross join PlanInter as p --[5000]

--b
select codcliente,p.codplan,c.tipo_cliente
from Cliente as c cross join PlanInter as p --[5000]
where tipo_cliente='E'

--c
select c.codcliente,c.tipo_cliente, p.codplan, p.nombre
from Cliente as C cross join PlanInter as P
where p.nombre like '%OLD%' --Clientes persona y empresas X Planes contienen 'OLD'

select a.codcliente , b.codplan,b.nombre  from cliente as  a 
cross join  PlanInter as  b 
where tipo_cliente='P'  and  nombre like '%old%' --Clientes persona X Planes contienen 'OLD'

--03.02

--case 
--	when codubigeo=1 then '150801'
--	when codubigeo=2 then '150802'
--	when codubigeo=3 then '150803'
--	when codubigeo=17 then '150205'
--end 

select codzona as CODZONA,nombre as ZONA,estado as ESTADO,
concat(null,cod_prov,cod_dto) as UBIGEO,
'La Zona '+null+' del ubigeo '+concat(cod_dpto,cod_prov,cod_dto)+' se encuentra '+
case 
	when estado=1 then 'ACTIVA'
	when estado=0 then 'INACTIVA'
	else 'SIN ESTADO'
	end as MENSAJE
from Zona as z inner join Ubigeo as u
on z.codubigeo=u.codubigeo

--03.04
select top (100) t.descorta as TIPO_DOC,numdoc as NUM_DOC,concat(nombres,' ',ape_paterno,' ',ape_materno) as [NOMBRE COMPLETO],
fec_nacimiento as FECHA_NAC,direccion as DIRECCION,z.nombre as ZONA
from Cliente as c inner join Zona as z on c.codzona=z.codzona
inner join TipoDocumento as t on c.codtipo=t.codtipo
where tipo_cliente='P' and c.estado=1 --Clientes persona en estado 'ACTIVO'
order by [NOMBRE COMPLETO] asc
