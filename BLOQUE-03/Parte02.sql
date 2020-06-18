--03.06

select t.tipo as TIPO,t.numero as NUMERO,t.codcliente as COD_CLIENTE,
c.razon_social as EMPRESA,z.nombre as ZONA
from Telefono as t
inner join Cliente as c on t.codcliente=c.codcliente
inner join Zona as z on c.codzona=z.codzona
where t.estado=1 and c.tipo_cliente='E'--c.estado=1
order by c.codcliente asc

