# Inner joins

![Inner Join](../img/img_inner_join.png)
-- Seleccionar todas las categorias y productos

select * from
Categories
inner join 
Products
on categories.CategoryID = products.CategoryID;

select categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from
Categories
inner join 
Products
on categories.CategoryID = products.CategoryID;

select c.CategoryID as 'Numero de Categoria', CategoryName as 'Nombre de Categoria', ProductName as 'Nombre del producto', UnitsInStock as 'Existencia', UnitPrice as 'Precio' 
from
Categories as c
inner join 
Products as p
on c.CategoryID = p.CategoryID;

-- Seleccionar los productos de la categoria beverages y condiments donde la existencia este entre 18 y 30


select *
from Products as p
join Categories as ca
on p.CategoryID = ca.CategoryID
where (ca.CategoryName = 'beverages' or ca.CategoryName = 'condiments')
and (p.UnitsInStock>=18 and p.UnitPrice<=30);


select *
from Products as p
join Categories as ca
on p.CategoryID = ca.CategoryID
where ca.CategoryName in ('beverages', 'condiments')
and p.UnitsInStock between 18 and 30;


-- Seleccionar los productos y sus importes realizados de marzo a junio de 1996, mostrando la fecha de la orden, el id del producto y el importe

select o.OrderID, o.OrderDate, od.ProductID,
(od.UnitPrice * od.Quantity) as importe
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-03' and '1996-31-10'


-- Mostrar el importe total de ventas de la consulta anterior

select concat ('$',' ',sum(od.Quantity * od.UnitPrice)) as importe
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-03' and '1996-31-10'

-- Consultas basicas con inner join 

-- 1. Obtener los nombres de los clientes y los paises a los que se enviaron sus pedidos

select c.CompanyName as 'Nombre del ciiente', o.ShipCountry as 'Pais de envio.'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
order by 2 desc

select c.CompanyName, o.ShipCountry
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc

-- 2. Obtener los productos y sus respectivos proveedores

select s.CompanyName, p.ProductName
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID

-- 3. Obtener pedidos y los empleados que los gestionaron
select o.OrderID, concat (e.Title, ' - ', e.FirstName, ' ', e.LastName) as Nombre 
from
Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID

-- 4. Listas los productos junto con sus precios y la categoria a la que pertenecen

select p.ProductName as 'Nombre del producto', p.UnitPrice as 'Precio',c.CategoryName 'Nombre de la categoria' 
from
Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID

-- 5. Obtener el nombre del cliente, el numero de orden y la fecha de orden

select c.CompanyName as 'Nombre del cliente', o.OrderID as 'Numero de orden', o.OrderDate as 'Fecha de orden'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID

-- 6. Listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad que se vendio

select od.OrderID as 'Numero de orden', p.ProductName as 'Nombre del producto', od.Quantity as 'Cantidad vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

select top 5 od.OrderID as 'Numero de orden', p.ProductName as 'Nombre del producto', od.Quantity as 'Cantidad vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
order by od.Quantity desc

select od.OrderID as 'Numero de orden', p.ProductName as 'Nombre del producto', od.Quantity as 'Cantidad vendida'
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
where od.OrderID = '11031'
order by od.Quantity desc


-- 7. Obtener los empleados y sus respectivos jefes
select concat(e1.FirstName, ' ', e1.LastName) as 'Empleado', concat(j1.FirstName, ' ', j1.LastName) as 'Jefe' 
from Employees as e1
inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID

-- 8. Listar los pedidos y el nombre de la empresa de transporte utilizada

select o.OrderID as 'Numero de orden', s.CompanyName as 'Empresa de transporte'
from Orders as o
inner join Shippers as s
on o.ShipVia = s.ShipperID

-- Consultas inner join intermedias

-- 9. Obtener la cantidad total de productos vendidos por categoria

select sum (Quantity) from [Order Details]

select c.CategoryName as 'Nombre de la categoria', sum (Quantity) as 'Productos vendidos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName asc

-- 10. Obtener el total de ventas por empleados

select concat(e.FirstName, ' ', e.LastName) as 'Nombre del empleado', sum ((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount) as 'Total de ventas'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName


select * from [Order Details]

-- 11. Listar los clientes y la cantidad de pedido que han realizado

select c.CompanyName as 'Clientes', count(*) as 'Cantidad de pedidos realizados'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
group by c.CompanyName
order by 2 desc


select c.CompanyName as 'Clientes', count(*) as 'Cantidad de pedidos realizados'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
group by c.CompanyName
order by count(*) desc


-- 12. Obtener los empleados que han gestionado pedidos enviados a Alemania

select distinct concat(e.FirstName, ' ', e.LastName) as 'Empleado', o.ShipCountry as 'Pais enviado'
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'

-- 13. Listar los productos junto con el nombre del proveedor y el pais de origen

select p.ProductName as 'Productos', s.CompanyName as 'Nombre del proveedor', s.Country as 'Pais de Origen'
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
order by 1 asc

-- 14. Obtener los pedidos agrupados por pais de envio

select ShipCountry as 'Pais de envio', count(OrderID) as 'Envio'
from Orders
group by ShipCountry
order by 2 desc

-- 15. Obtener los empleados y la cantidad de territorios en los que trabajan
select concat(e.FirstName, ' ', e.LastName) as 'Nombre de empleado', count(et.TerritoryID) as 'Numero de territorio'
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by concat(e.FirstName, ' ', e.LastName)
order by 2 asc

-- 16. Listar las categorias y la cantidad de productos que contienen

select  c.CategoryName as 'Categorias', count(p.UnitsInStock) as 'Cantidad de productos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 asc

-- 17. Obtener la cantidad total de productos vendidos por proveedor

select s.CompanyName as 'Nombre del proveedor', sum(od.Quantity) as 'Cantidad total'
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName
order by 2 asc


-- 18. Obtener la cantidad de pedidos enviados por cada empresa de transporte

select c.CompanyName as 'Empresa de transporte', count(s.ShipperID) as 'Pedidos'
from Orders as o
inner join Shippers as s
on o.ShipVia = s.ShipperID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by c.CompanyName
order by 2 asc

-- 19. Obtener los clientes que han realizado pedidos con mas de un producto

select c.CompanyName, count(distinct ProductID) as 'Numero de Productos'
from 
Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 desc
-- Consultas Avanzadas

-- 20. Listar los empleados con la cantidad total de pedidos que han gestionado y a que clientes los han vendido, agrupandolos
-- por nombre completo y dentro de este nombre por cliente, ordenandolos por la cantidad de mayor pedidos

select concat(e.FirstName, ' ', e.LastName) as 'Nombre', c.CompanyName as 'Cliente', count(OrderID) as 'Numero de ordeness'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by 'Nombre' asc, 'Cliente'

select concat(e.FirstName, ' ', e.LastName) as 'Nombre', count(OrderID) as 'Numero de ordenes'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
group by e.FirstName, e.LastName
order by 'Nombre' asc

-- 21. Listar las categorias con el total de ingresos generados por sus productos

select c.CategoryName as 'Categoria', p.ProductName as 'Productos', sum(od.Quantity*od.UnitPrice) as 'Total de ingresos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName, p.ProductName
order by 1 

select c.CategoryName as 'Categoria', sum(od.Quantity*od.UnitPrice) as 'Total de ingresos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName
order by 1 

-- 22. Listar los clientes con el total ($) gastado en pedidos

select c.CompanyName as 'Clientes', sum(od.Quantity * od.UnitPrice) as 'Total'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName

-- 23. Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el total en dinero

select o.OrderID as 'Orden', o.OrderDate as 'Fecha', sum(od.UnitPrice * od.Quantity) as 'Total de dinero'
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-30-6'
group by o.OrderDate, o.OrderID

-- 24. Listar los productos con las categorias Beverages, seafood, confections
select c.CategoryName as 'Categoria', ProductName as 'Nombre del producto'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryName = 'Beverages' or c.CategoryName = 'Seafood' or c.CategoryName = 'Confections'

select c.CategoryName as 'Categoria', ProductName as 'Nombre del producto'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryName in ('Beverages', 'Seafood', 'Confections')

-- 25. Listar los clientes ubicados en Alemania y que hayan realizado pedidos antes del 1 de enero de 1997
select c.ContactName as 'Nombre del cliente', c.Country as 'Pais', o.OrderDate as 'Fecha de Orden'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
where c.Country = 'Germany' and o.OrderDate < '1997-01-01'

-- 26. Listar los clientes que han realizado pedidos con un total entre $500 y $2000
select c.CompanyName as 'Nombre del cliente', sum(od.UnitPrice*od.Quantity) as 'Total pedido'
from Orders as o
inner join Customers as c
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName
having sum(od.UnitPrice*od.Quantity) between '500' and '2000'
order by 2 asc


```
-- Left join, Right join, Full join y Cross join

















































