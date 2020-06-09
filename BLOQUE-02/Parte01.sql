--02.00

--Progresión aritmética creciente

declare @t1 int=1
declare @n int=200
declare @r int=5

select @t1+(@n-1)*@r as TN

--Progresion geométrica creciente

declare @_t1 bigint=1
declare @_n bigint=63
declare @_r bigint=2

--select power(2,3),power(3,4)--power(base,potencia)

select @_t1*power(@_r,@_n-1) as TN

--Lógica de procesamiento

select codubigeo,count(codzona) as total --(V)
from Zona --(I)
where estado=1 --(II)
group by codubigeo --(III)
having count(codzona)>=4 --(IV)
order by codubigeo desc --(VI)

select codubigeo, -->(V.a)
       count(codzona) as total, -->(V.b)
	   10+count(codzona) -->(V.c)
from Zona --(I)
where estado=1 --(II)
group by codubigeo --(III)
having count(codzona)>=4 --(IV)
order by codubigeo desc --(VI)

--Alias de columna

select nom_dpto DEPARTAMENTO,nom_prov as PROVINCIA,'DISTRITO'=nom_dto,codubigeo as [MI-UBIGEO] from Ubigeo

--Alias de tabla

select nom_dpto DEPARTAMENTO,nom_prov as PROVINCIA,'DISTRITO'=nom_dto,codubigeo as [MI-UBIGEO] from Ubigeo u

select nom_dpto DEPARTAMENTO,nom_prov as PROVINCIA,'DISTRITO'=nom_dto,codubigeo as [MI-UBIGEO] from Ubigeo as u

select u.nom_dpto DEPARTAMENTO,u.nom_prov as PROVINCIA,'DISTRITO'=u.nom_dto,u.codubigeo as [MI-UBIGEO] from Ubigeo as u

select z.codubigeo from Zona as z

--Expresiones CASE 

--02.01

--a

select nom_dpto from Ubigeo --Obtener los nombres de departamento
select distinct nom_dpto from Ubigeo  --Obtener los nombres de departamento irrepetibles

--b

select codubigeo from Zona --Obtener los codigos de ubigeo de zona
select distinct codubigeo from Zona --Obtener los codigos de ubigeo de zona irrepetibles

--c

select nom_dpto,nom_prov from Ubigeo --Obtener los nombres de departamento y provincia
select distinct nom_dpto,nom_prov from Ubigeo --Obtener las combinaciones de departamento y provincia irrepetibles
select distinct nom_dpto,nom_prov,nom_dto from Ubigeo --Obtener las combinaciones de departamento,provincia y distrito irrepetibles

--02.02

select nombre as ZONA,codubigeo as [CODIGO UBIGEO],estado as ESTADO,
case 
	when estado=1 then 'Zona activa'
	when estado=0 then 'Zona inactiva'
	else 'Sin detalle' 
end as [MENSAJE ESTADO]
from Zona 
where codubigeo=1

--02.03

select cod_dpto+cod_prov+cod_dto as UBIGEO,nom_dpto as DPTO, nom_prov as PROV,nom_dto as DTO,
case
	when nom_prov='HUAURA' then 'Provincia Huaura'
	else 'Otra Provincia' 
END as MENSAJE
FROM Ubigeo

--02.04
declare @tipo_cambio decimal(6,3)=3.430

--select cast(round(10.4561,2) as decimal(6,2)) --round(numero,posicion_redondeo)

select nombre as [PLAN],precioref as PRECIO_SOL,cast(round(precioref/@tipo_cambio,2) as decimal(6,2)) as PRECIO_DOL,
case 
	when precioref>=0 and precioref<70 then '[0,70>'
	when precioref>=70 and precioref<100 then '[70,100>'
	when precioref>=100 then '[100,+>' 
	else 'Sin rango definido'
	end as RANGO_SOL
from PlanInter

