# Consultas de Agregado en Northwind

## Introducción
Este documento cubre consultas SQL de agregado en la base de datos **Northwind**, utilizando funciones como **SUM, AVG, COUNT, MAX, MIN** y agrupamiento de datos con la cláusula **GROUP BY**. Estas consultas permiten obtener resúmenes y estadísticas sobre los datos.

## Codigo
```sql
-- Consultas de agregado
-- NOTA: Solo devuelven un solo registro
-- sum, avg, count, count(*), max y min
-- Con * no cuenta los nulos

-- Cuantos clientes tengo
select count(*) as 'Numero de clientes'
from Customers;

-- Cuantas regiones hay
select count(distinct Region)
from Customers
where Region is not null;

select count(*)
from Orders;

select count(ShipRegion)
from Orders;

-- Selecciona el precio mas bajo de los productos
select min(UnitPrice), max(UnitPrice), avg(UnitsInStock)
from Products;

-- Seleccionar cuantos pedidos existen
select COUNT(OrderID)
from Orders;

-- Calcula el total de dinero vendido
select SUM(UnitPrice * Quantity - (UnitPrice * Quantity * Discount))
from [Order Details];

-- Calcula el total de unidades en stock de todos los productos
select SUM(UnitsInStock) as 'Total de Stock'
from Products;

-- group by

-- Seleccionar el numero de productos por categoria
select count(CategoryID),
count(*)
from Products;

select CategoryID,
count(*)
from Products
group by CategoryID;

select Categories.CategoryName, count(*) as 'Numero de productos'
from Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName;

-- Calcular el precio promedio de los productos por cada categoria
select * from Products;
select CategoryID, 
AVG(UnitPrice) as 'Precio Promedio' 
from Products
group by CategoryID;

-- Seleccionar el numero de pedidos realizados por cada empleado
select * from Orders;
select COUNT(OrderID) as 'Pedidos por empleado'
from Orders
group by EmployeeID;

select EmployeeID, COUNT(*) as 'Numero de pedidos'
from Orders
group by EmployeeID;

select  EmployeeID ,COUNT(*)
from Orders
where OrderDate between '1996-01-10' and '1996-31-12'
group by EmployeeID;

-- Seleccionar la suma total de unidades vendidas por cada producto
select * from [Order Details];
select ProductID, SUM(Quantity) as 'Numero de productos vendidos'
from [Order Details]
group by ProductID
order by 1 desc;

select OrderID, ProductID, SUM(Quantity) as 'Numero de productos vendidos'
from [Order Details]
group by OrderID, ProductID
order by 2 desc;

-- Seleccionar el numero de productos por categoria pero solo aquellos que tengan mas de 10 productos

-- Paso 1
select * from Products;

-- Paso 2
select CategoryID, UnitsInStock from Products
where CategoryID in (2,4,8)
order by CategoryID asc;

-- Paso 3
select CategoryID, sum(UnitsInStock) from Products
where CategoryID in (2,4,8)
group by CategoryID
order by CategoryID asc;

-- Paso 4
select CategoryID, sum(UnitsInStock) from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*) > 10
order by CategoryID asc;

-- Listar las ordenes agrupadas por empleados, pero que solo muestre aquellos que hayan gestionado mas de 10 pedidos
select * from Orders;
select EmployeeID from Orders
having count(*) > 10
order by EmployeeID;
```

## Conclusión
A través de las consultas realizadas en esta base de datos, se puede obtener información clave sobre las operaciones de la empresa. Las funciones de agregado permiten generar resúmenes estadísticos que ayudan a comprender aspectos importantes como el número de clientes, el total de dinero generado, las categorías de productos más importantes y el rendimiento de los empleados. Además, el uso de la cláusula GROUP BY facilita el análisis de datos agrupados por categorías, empleados o productos. Estas consultas son fundamentales para tomar decisiones informadas y optimizar el rendimiento de la empresa.
