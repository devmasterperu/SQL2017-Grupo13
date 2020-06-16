--02.13
--a
select top 15 
estado as ESTADO,codzona as ZONA,count(codcliente) as TOT_CLIENTES,
min(ape_paterno) as MIN_APE_PAT,max(ape_paterno) as MAX_APE_PAT,
case 
	when count(codcliente) between 0 and 14 then 'INFERIOR'
	when count(codcliente) between 15 and 29 then 'MEDIO'
	when count(codcliente)>=30 then 'SUPERIOR'
	else 'SIN MENSAJE'
end as MENSAJE
from Cliente
where tipo_cliente='P'--Personas
group by estado,codzona
order by TOT_CLIENTES desc

--b

select top (15) percent -- TOP(4)=0.15*22=3.3
estado as ESTADO,codzona as ZONA,count(codcliente) as TOT_CLIENTES,
min(ape_paterno) as MIN_APE_PAT,max(ape_paterno) as MAX_APE_PAT,
case 
	when count(codcliente) between 0 and 14 then 'INFERIOR'
	when count(codcliente) between 15 and 29 then 'MEDIO'
	when count(codcliente)>=30 then 'SUPERIOR'
	else 'SIN MENSAJE'
end as MENSAJE
from Cliente
where tipo_cliente='P'--Personas
group by estado,codzona
order by TOT_CLIENTES desc

--c

select top (15) with ties --Primeros 15 incluyendo empates con la 15� posici�n
estado as ESTADO,codzona as ZONA,count(codcliente) as TOT_CLIENTES,
min(ape_paterno) as MIN_APE_PAT,max(ape_paterno) as MAX_APE_PAT,
case 
	when count(codcliente) between 0 and 14 then 'INFERIOR'
	when count(codcliente) between 15 and 29 then 'MEDIO'
	when count(codcliente)>=30 then 'SUPERIOR'
	else 'SIN MENSAJE'
end as MENSAJE
from Cliente
where tipo_cliente='P'--Personas
group by estado,codzona
order by TOT_CLIENTES desc

--d

select top (40) percent with ties --Primer 40% (9� posici�n) incluyendo empates con la �ltima posici�n del 40%
estado as ESTADO,codzona as ZONA,count(codcliente) as TOT_CLIENTES,
min(ape_paterno) as MIN_APE_PAT,max(ape_paterno) as MAX_APE_PAT,
case 
	when count(codcliente) between 0 and 14 then 'INFERIOR'
	when count(codcliente) between 15 and 29 then 'MEDIO'
	when count(codcliente)>=30 then 'SUPERIOR'
	else 'SIN MENSAJE'
end as MENSAJE
from Cliente
where tipo_cliente='P'--Personas
group by estado,codzona
order by TOT_CLIENTES desc

--02.15
declare @n int=4 --Pagina
declare @t int=20 --Tama�o de Pagina

select codcliente as COD_CLIENTE,nombres+' '+ape_paterno+' '+ape_materno as NOMBRE_COMPLETO
from Cliente
where tipo_cliente='P'
order by NOMBRE_COMPLETO asc --[A-Z]
offset @t*(@n-1) rows
fetch next @t rows only

--P�gina 1 y tama�o de p�gina 10 [Posici�n 1 � 10]
--offset 0 rows=10*(1-1)
--fetch next 10 rows only--10

--P�gina 2 y tama�o de p�gina 10 [Posici�n 11-20]
--offset 10 rows=10*(2-1)
--fetch next 10 rows only--10

--P�gina 3 y tama�o de p�gina 10 [Posici�n 21-30]
--offset 20 rows=10*(3-1)
--fetch next 10 rows only--10

--P�gina 4 y tama�o de p�gina 20 [Posici�n 61-80]
--offset 60 rows=20*(4-1)
--fetch next 20 rows only--20



