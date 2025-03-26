# Consultas con Inner Join y Avanzadas

## Introducción
Este documento cubre diversas consultas SQL en la base de datos **Northwind** usando la cláusula **INNER JOIN**, así como ejemplos avanzados de combinaciones de tablas para obtener datos relacionados entre sí. Estas consultas están orientadas a recuperar información relevante de categorías, productos, pedidos, empleados y más, facilitando análisis y reportes complejos.

## Codigo
```sql
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
where o.OrderDate between '1996-01-03' and '1996-31-10';

-- Mostrar el importe total de ventas de la consulta anterior
select concat ('$',' ',sum(od.Quantity * od.UnitPrice)) as importe
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-01-03' and '1996-31-10';

-- Consultas básicas con inner join
-- 1. Obtener los nombres de los clientes y los paises a los que se enviaron sus pedidos
select c.CompanyName as 'Nombre del cliente', o.ShipCountry as 'Pais de envio.'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
order by 2 desc;

-- 2. Obtener los productos y sus respectivos proveedores
select s.CompanyName, p.ProductName
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID;

-- 3. Obtener pedidos y los empleados que los gestionaron
select o.OrderID, concat (e.Title, ' - ', e.FirstName, ' ', e.LastName) as Nombre 
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID;

-- 4. Listar los productos junto con sus precios y la categoria a la que pertenecen
select p.ProductName as 'Nombre del producto', p.UnitPrice as 'Precio',c.CategoryName 'Nombre de la categoria' 
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID;

-- Consultas intermedias
-- 9. Obtener la cantidad total de productos vendidos por categoria
select c.CategoryName as 'Nombre de la categoria', sum (Quantity) as 'Productos vendidos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName asc;

-- 10. Obtener el total de ventas por empleados
select concat(e.FirstName, ' ', e.LastName) as 'Nombre del empleado', sum ((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount) as 'Total de ventas'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName;

-- 11. Listar los clientes y la cantidad de pedido que han realizado
select c.CompanyName as 'Clientes', count(*) as 'Cantidad de pedidos realizados'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
group by c.CompanyName
order by 2 desc;

-- 12. Obtener los empleados que han gestionado pedidos enviados a Alemania
select distinct concat(e.FirstName, ' ', e.LastName) as 'Empleado', o.ShipCountry as 'Pais enviado'
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany';

-- 13. Listar los productos junto con el nombre del proveedor y el pais de origen
select p.ProductName as 'Productos', s.CompanyName as 'Nombre del proveedor', s.Country as 'Pais de Origen'
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
order by 1 asc;

-- Consultas avanzadas
-- 20. Listar los empleados con la cantidad total de pedidos que han gestionado y a que clientes los han vendido, agrupandolos
select concat(e.FirstName, ' ', e.LastName) as 'Nombre', c.CompanyName as 'Cliente', count(OrderID) as 'Numero de ordeness'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by 'Nombre' asc, 'Cliente';

-- 21. Listar las categorias con el total de ingresos generados por sus productos
select c.CategoryName as 'Categoria', p.ProductName as 'Productos', sum(od.Quantity*od.UnitPrice) as 'Total de ingresos'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName, p.ProductName
order by 1;

-- 22. Listar los clientes con el total ($) gastado en pedidos
select c.CompanyName as 'Clientes', sum(od.Quantity * od.UnitPrice) as 'Total'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName;

-- 23. Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el total en dinero
select o.OrderID as 'Orden', o.OrderDate as 'Fecha', sum(od.UnitPrice * od.Quantity) as 'Total de dinero'
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-30-6'
group by o.OrderDate, o.OrderID;

-- 24. Listar los productos con las categorias Beverages, seafood, confections
select c.CategoryName as 'Categoria', ProductName as 'Nombre del producto'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryName in ('Beverages', 'Seafood', 'Confections');

-- 25. Listar los clientes ubicados en Alemania y que hayan realizado pedidos antes del 1 de enero de 1997
select c.ContactName as 'Nombre del cliente', c.Country as 'Pais', o.OrderDate as 'Fecha de Orden'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
where c.Country = 'Germany' and o.OrderDate < '1997-01-01';

-- 26. Listar los clientes que han realizado pedidos con un total entre $500 y $2000
select c.CompanyName as 'Nombre del cliente', sum(od.UnitPrice*od.Quantity) as 'Total pedido'
from Orders as o
inner join Customers as c
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName
having sum(od.UnitPrice*od.Quantity) between '500' and '2000'
order by 2 asc;
```

## Conclusión
Este documento proporciona ejemplos de consultas SQL utilizando **INNER JOIN** y otras técnicas avanzadas para extraer datos complejos de la base de datos Northwind, incluyendo información sobre productos, clientes, empleados y más. Estas consultas son útiles para realizar análisis detallados y generar reportes informativos.
