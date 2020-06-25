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

select codplan,periodo,precio,nuevo_precio from Contrato

select codplan,nombre,precioref from PlanInter