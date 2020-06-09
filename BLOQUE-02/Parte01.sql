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
