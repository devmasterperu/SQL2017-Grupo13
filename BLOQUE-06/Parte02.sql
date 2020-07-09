--06.05

--TABLAS_DERIVADAS

select c.codcliente as CODIGO,concat(nombres,' ', ape_paterno,' ', ape_materno) as CLIENTE,
codzona as ZONA,isnull(rt.total,0) as N_TEL,
/*Es la posición irrepetible por zona. Considerar el total de teléfonos, 
de menor a mayor, para generar la posición*/
row_number() over(partition by c.codzona order by rt.total asc) as R1,
/*Es la posición por zona que puede repetirse en caso de empates. Considerar el total de teléfonos, 
de menor a mayor, para generar la posición. Además, SI puede existir salto de posiciones en el ranking*/
rank() over(partition by c.codzona order by rt.total asc) as R2,
/*Es la posición por zona que puede repetirse en caso de empates. Considerar el total de teléfonos, 
de menor a mayor, para generar la posición. Además, NO puede existir salto de posiciones en el ranking*/
dense_rank() over(partition by c.codzona order by rt.total asc) as R3,
/*Es uno de los 4 grupos, dentro de cada zona, al que pertenece el cliente. Considerar el total de teléfonos, 
de menor a mayor, para generar la agrupación*/
ntile(4) over(partition by c.codzona order by rt.total asc) as R4
from Cliente c left join 
(
 select codcliente,count(numero) as total from Telefono
 group by codcliente
) rt on c.codcliente=rt.codcliente
where tipo_cliente='P'
order by ZONA asc, N_TEL asc

--CTES
WITH CTE_RT as (
 select codcliente,count(numero) as total from Telefono
 group by codcliente
)
select c.codcliente as CODIGO,concat(nombres,' ', ape_paterno,' ', ape_materno) as CLIENTE,
codzona as ZONA,isnull(rt.total,0) as N_TEL,
/*Es la posición irrepetible por zona. Considerar el total de teléfonos, 
de menor a mayor, para generar la posición*/
row_number() over(partition by c.codzona order by rt.total asc) as R1,
/*Es la posición por zona que puede repetirse en caso de empates. Considerar el total de teléfonos, 
de menor a mayor, para generar la posición. Además, SI puede existir salto de posiciones en el ranking*/
rank() over(partition by c.codzona order by rt.total asc) as R2,
/*Es la posición por zona que puede repetirse en caso de empates. Considerar el total de teléfonos, 
de menor a mayor, para generar la posición. Además, NO puede existir salto de posiciones en el ranking*/
dense_rank() over(partition by c.codzona order by rt.total asc) as R3,
/*Es uno de los 4 grupos, dentro de cada zona, al que pertenece el cliente. Considerar el total de teléfonos, 
de menor a mayor, para generar la agrupación*/
ntile(4) over(partition by c.codzona order by rt.total asc) as R4
from Cliente c left join CTE_RT rt on c.codcliente=rt.codcliente
where tipo_cliente='P'
order by ZONA asc, N_TEL asc