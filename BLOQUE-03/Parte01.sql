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
