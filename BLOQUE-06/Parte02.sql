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

--06.07

--TABLAS_DERIVADAS
select c.codcliente as #,razon_social as CLIENTE, codzona as ZONA,isnull(rc.total,0) as TOTAL,
/*Es la posición irrepetible por zona. Considerar el total de contratos, de menor a mayor, 
para generar la posición*/
row_number() over (partition by codzona order by rc.total asc) as E1,
/*Es el valor previo de la razón_social evaluada, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
lag(razon_social) over (partition by codzona order by rc.total asc) as E2,
/*Es el valor siguiente de la razón_social evaluada, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
lead(razon_social) over (partition by codzona order by rc.total asc) as E3,
/*Es el primer valor de la razón_social hasta el momento de la evaluación, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
first_value(razon_social) over (partition by codzona order by rc.total asc) as E3,
/*Es el último valor de la razón_social hasta el momento de la evaluación, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
last_value(razon_social) over (partition by codzona order by rc.total asc) as E4
from Cliente c
left join
(
  select codcliente,count(codplan) as total 
  from Contrato
  group by codcliente
) rc on c.codcliente=rc.codcliente
where tipo_cliente='E'
order by ZONA asc, rc.total asc

--CTES
WITH CTE_RC AS
(
  select codcliente,count(codplan) as total 
  from Contrato
  group by codcliente
)
select c.codcliente as #,razon_social as CLIENTE, codzona as ZONA,isnull(rc.total,0) as TOTAL,
/*Es la posición irrepetible por zona. Considerar el total de contratos, de menor a mayor, 
para generar la posición*/
row_number() over (partition by codzona order by rc.total asc) as E1,
/*Es el valor previo de la razón_social evaluada, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
lag(razon_social,1,'SIN DATO') over (partition by codzona order by rc.total asc) as E2,
/*Es el valor siguiente de la razón_social evaluada, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
lead(razon_social,1,'SIN DATO') over (partition by codzona order by rc.total asc) as E3,
/*Es el primer valor de la razón_social hasta el momento de la evaluación, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
isnull(first_value(razon_social) over (partition by codzona order by rc.total asc),'SIN DATO') as E3,
/*Es el último valor de la razón_social hasta el momento de la evaluación, considerando el total de contratos (Menor a mayor) 
dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
isnull(last_value(razon_social) over (partition by codzona order by rc.total asc),'SIN DATO') as E4
from Cliente c left join CTE_RC rc 
on c.codcliente=rc.codcliente
where tipo_cliente='E'
order by ZONA asc, rc.total asc

--FUNCION_VALOR_TABLA

create function F_RESUMEN_CLIENTE() returns table
as return
	WITH CTE_RC AS
	(
	  select codcliente,count(codplan) as total 
	  from Contrato
	  group by codcliente
	)
	select c.codcliente as #,razon_social as CLIENTE, codzona as ZONA,isnull(rc.total,0) as TOTAL,
	/*Es la posición irrepetible por zona. Considerar el total de contratos, de menor a mayor, 
	para generar la posición*/
	row_number() over (partition by codzona order by rc.total asc) as E1,
	/*Es el valor previo de la razón_social evaluada, considerando el total de contratos (Menor a mayor) 
	dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
	lag(razon_social,1,'SIN DATO') over (partition by codzona order by rc.total asc) as E2,
	/*Es el valor siguiente de la razón_social evaluada, considerando el total de contratos (Menor a mayor) 
	dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
	lead(razon_social,1,'SIN DATO') over (partition by codzona order by rc.total asc) as E3,
	/*Es el primer valor de la razón_social hasta el momento de la evaluación, considerando el total de contratos (Menor a mayor) 
	dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
	isnull(first_value(razon_social) over (partition by codzona order by rc.total asc),'SIN DATO') as E4,
	/*Es el último valor de la razón_social hasta el momento de la evaluación, considerando el total de contratos (Menor a mayor) 
	dentro de cada zona. Mostrar ‘SIN DATO’ para valores desconocidos*/
	isnull(last_value(razon_social) over (partition by codzona order by rc.total asc),'SIN DATO') as E5
	from Cliente c left join CTE_RC rc 
	on c.codcliente=rc.codcliente
	where tipo_cliente='E'

	select * from F_RESUMEN_CLIENTE()
	order by ZONA asc, TOTAL asc
