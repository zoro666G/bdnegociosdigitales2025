
-- 1
select c.Empresa, p.Importe, p.Num_Pedido, p.Fecha_Pedido
from Pedidos as p
inner join Clientes as c
on P.Cliente = C.Num_Cli
where p.Fecha_Pedido between '1988-01-01' and '1990-12-31'

select * from Pedidos

-- 2
select r.Fecha_Contrato, r.Nombre, o.Ciudad
from Representantes as r
inner join Oficinas as o
on r.Jefe = o.Jef
where r.Fecha_Contrato between '1988-01-01' and '1990-12-31'

-- 3 
select pr.Descripcion, p.Num_Pedido, pr.Id_producto
from Pedidos as p
inner join Productos as pr
on pr.Id_fab = p.Fab and pr.Id_producto = p.Producto
where pr.Id_producto in ('2A44L', '41004', '2A44G')

--4

select p.Importe, r.Nombre, o.Ciudad, r.Ventas, SUM(p.Importe) as 'Total de ventas'
from Representantes as r
inner join Pedidos as p
on r.Num_Empl = p.Rep
inner join Oficinas as o
on o.Oficina = r.Oficina_Rep
where r.Ventas > 10000
group by p.Importe, r.Nombre, o.Ciudad, r.Ventas


-- 5

select p.Num_Pedido, p.Cliente, r.Nombre, pr.Descripcion
from Pedidos as p
inner join Productos as pr
on pr.Id_fab = p.Fab and pr.Id_producto = p.Producto
inner join Representantes as r
on r.Num_Empl = p.Rep

-- 6

select r.Jefe, r.Nombre, o.Ciudad, sum(p.Importe) as 'Total de ventas'
from Oficinas as o
inner join Representantes as r
on o.Oficina = r.Oficina_Rep
inner join Pedidos as p
on p.Rep = r.Num_Empl
group by r.Jefe, r.Nombre, o.Ciudad

-- 7

select p.Num_Pedido, c.Empresa, pr.Descripcion, p.Importe
from Pedidos as p
inner join Clientes as c
on c.Num_Cli = p.Cliente
inner join Productos as pr
on pr.Id_fab = p.Fab and pr.Id_producto = p.Producto
order by 4 desc

-- 8

select c.Empresa, r.Nombre, o.Oficina, p.Cantidad as 'Cantidad de pedidos'
from Representantes as r
inner join Oficinas as o
on o.Oficina = r.Oficina_Rep
inner join Clientes as c
on r.Num_Empl = c.Rep_Cli
inner join Pedidos as p
on r.Num_Empl = p.Rep
where p.Cantidad > 3

-- 9 

select o.Ciudad, o.Objetivo, r.Ventas, r.Num_Empl, count(distinct o.Jef)
from Representantes as r
inner join Oficinas as o
on o.Oficina = r.Oficina_Rep 
group by o.Ciudad, o.Objetivo, r.Ventas, r.Num_Empl

select * from Oficinas
-- 10

SELECT 
    o.Ciudad, r.Nombre, r.Cuota, c.Num_Cli, o.Ventas, o.Objetivo,
    (o.Ventas * 80.0 / r.Cuota) AS 'Cumplimiento (%)'
FROM Representantes AS r
inner join Oficinas as o
on o.Oficina = r.Oficina_Rep 
inner join Clientes as c
on r.Num_Empl = c.Rep_Cli
ORDER BY 'Cumplimiento (%)' 







