--03.12
select isnull(c.codcliente,0) as [CLIENTE_CODCLIENTE],
case 
	when c.tipo_cliente='P'then c.nombres+' '+c.ape_paterno+' '+c.ape_materno
	when c.tipo_cliente='E'then c.razon_social
	else 'SIN DATO'
end as [CLIENTE_NOMBRE],
isnull(lower(c.email),'SIN DATO') as [CLIENTE_CORREO],
isnull(co.codcliente,0) as [CONTRATO_CODCLIENTE],
isnull(p.nombre,' SIN DATO') as [CONTRATO_PLAN],
isnull(co.fec_contrato,'9999-12-31') as [CONTRATO_FECHA]
from Cliente as c
full join Contrato as co on c.codcliente=co.codcliente
left join PlanInter as p on co.codplan=p.codplan
order by isnull(co.codcliente,0) asc