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