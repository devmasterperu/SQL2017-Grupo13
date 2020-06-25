--04.11

--Crear la columna nuevo_precio
alter table Contrato add nuevo_precio decimal(6,2)
--Calcular y actualizar los nuevos precios
begin tran
	update co
	set nuevo_precio=case when co.codplan in (1,2,3,4,5,8) and periodo='Q' 
						  then 0.95*p.precioref --5% descuento 
						  when co.codplan in (1,2,3,4,5,8) and periodo='M' 
						  then 0.90*p.precioref --10% descuento 
						  else 0.98*p.precioref --2% descuento
					 end
	from Contrato co 
	join PlanInter p on co.codplan=p.codplan
rollback

--¿Quiénes son los clientes a los cuales no les conviene este nuevo precio?
select 
case 
	when c.tipo_cliente='P' then c.nombres+' '+c.ape_paterno+' '+c.ape_materno
	when c.tipo_cliente='E' then c.razon_social
	else 'SIN DATO'
end as CLIENTE,
p.nombre as [PLAN],precio as [PRECIO ACTUAL],nuevo_precio as [PRECIO NUEVO]
from Contrato as co
left join PlanInter as p on co.codplan=p.codplan
left join Cliente as c on co.codcliente=c.codcliente
where precio<nuevo_precio

