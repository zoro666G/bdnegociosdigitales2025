# Consultas SQL para la Creación y Manipulación de Datos

## Introducción
Este documento describe cómo se pueden crear y manipular datos en una nueva tabla llamada **`products_new`** utilizando consultas SQL avanzadas. Estas consultas incluyen la creación de tablas, inserción de datos, la gestión de claves primarias y la carga de datos de manera eficiente. El objetivo es mejorar la organización de la base de datos, realizar análisis y generar reportes detallados.

## Codigo
```sql
-- 1. Crear la tabla `products_new` con información combinada de varias tablas
select p.ProductID, p.ProductName
, [cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join Categories as c on p.CategoryID = c.CategoryID
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as o on o.OrderID = od.OrderID
inner join Customers as [cu] on [cu].CustomerID = o.CustomerID;

-- 2. Crear la tabla `products_new` solo con la estructura (sin datos)
select top 0 p.ProductID, p.ProductName as [producto]
, [cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join Categories as c on p.CategoryID = c.CategoryID
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as o on o.OrderID = od.OrderID
inner join Customers as [cu] on [cu].CustomerID = o.CustomerID;

-- 3. Crear la tabla `products_new` con alias para las columnas
select top 0 0 as [productbk], p.ProductID, p.ProductName as [producto]
, [cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join Categories as c on p.CategoryID = c.CategoryID
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as o on o.OrderID = od.OrderID
inner join Customers as [cu] on [cu].CustomerID = o.CustomerID;

-- 4. Insertar los datos en la tabla `products_new` sin la columna `productbk`
insert into products_new
select 0 as [bkproduct], p.ProductID, p.ProductName
, [cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE()
from Products as p 
inner join Categories as c on p.CategoryID = c.CategoryID
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as o on o.OrderID = od.OrderID
inner join Customers as [cu] on [cu].CustomerID = o.CustomerID;

-- 5. Añadir la clave primaria a la tabla `products_new`
alter table products_new
add constraint pk_products_new
primary key (productbk);

-- 6. Crear la tabla `products_new` con una columna de tipo identidad
drop table products_new;

select top 0 p.ProductID, p.ProductName as [producto]
, [cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join Categories as c on p.CategoryID = c.CategoryID
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as o on o.OrderID = od.OrderID
inner join Customers as [cu] on [cu].CustomerID = o.CustomerID;

-- 7. Agregar una columna de identidad `productbk` a `products_new`
alter table products_new
add productbk int not null identity(1,1);

-- 8. Añadir la clave primaria a la columna `productbk`
alter table products_new
add constraint pk_products_new
primary key (productbk);

-- 9. Insertar los datos nuevamente en la tabla `products_new` incluyendo la nueva columna de identidad
insert into products_new (ProductID,producto,Customer, Category, UnitPrice, Discontinued, inserted_date)
select p.ProductID, p.ProductName
, [cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date' 
from Products as p 
inner join Categories as c on p.CategoryID = c.CategoryID
inner join [Order Details] as od on od.ProductID = p.ProductID
inner join Orders as o on o.OrderID = od.OrderID
inner join Customers as [cu] on [cu].CustomerID = o.CustomerID;

-- 10. Ver el contenido de la tabla `products_new`
select * from products_new;

-- 11. Realizar una consulta LEFT JOIN entre `Products` y `products_new`
SELECT pn.ProductID, pn.producto, pn.Customer, pn.Category, pn.UnitPrice, pn.Discontinued, pn.inserted_date, p.ProductID, p.ProductName
FROM Products as p
left JOIN products_new AS pn
ON p.ProductID = pn.ProductID
WHERE ProductName <> 'Elote Feliz';

-- 12. Realizar una carga delta: insertar los datos que no están en `products_new`
insert into products_new (ProductID,producto,Customer, Category, UnitPrice, Discontinued, inserted_date)
select p.ProductID, p.ProductName
, [cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
from Products as p 
left join Categories as c on p.CategoryID = c.CategoryID
left join [Order Details] as od on od.ProductID = p.ProductID
```
## Conclusión
Este documento describe cómo crear, manipular y gestionar una nueva tabla en una base de datos utilizando SQL avanzado. Las consultas incluidas permiten combinar, insertar y gestionar datos, utilizando prácticas recomendadas como el uso de claves primarias y la carga de datos incrementales. Estas consultas son útiles para tareas de análisis y generación de reportes en sistemas de bases de datos.