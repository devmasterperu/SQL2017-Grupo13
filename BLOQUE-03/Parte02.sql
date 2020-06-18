--03.06

select t.tipo as TIPO,t.numero as NUMERO,t.codcliente as COD_CLIENTE,
c.razon_social as EMPRESA,z.nombre as ZONA
from Telefono as t
inner join Cliente as c on t.codcliente=c.codcliente
inner join Zona as z on c.codzona=z.codzona
where t.estado=1 and c.tipo_cliente='E'--c.estado=1
order by c.codcliente asc

--03.07

select  tipo as TIPO, numero as NUMERO, concat (c.nombres,' ',c.ape_paterno,'',c.ape_materno) as NOMBRES, c.email as EMAIL, 
z.nombre as ZONA,
concat( u.cod_dpto,u.cod_prov,u.cod_dto) as UBIGEO  
from telefono  t
inner join cliente c on t.codcliente=c.codcliente
inner join zona z on c.codzona=z.codzona --codzona VS codzona
inner join ubigeo u on z.codubigeo=u.codubigeo
where t.estado=0 and c.tipo_cliente='P'
order by c.email desc





