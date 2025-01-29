
--Lenguaje SQL-LMD (insert, update, delete, select - CRUD )
--Consultas Simples

use Northwind;

--Mostrar todos los clientes, proveedores, categorias, productos, ordenes, detalles de la orden, empleados con todas las columnas de datos de la empresa


select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details]

--Proyeccion

select ProductID, ProductName, UnitPrice, UnitsInStock
from products;

-- Seleccionar o mostrar el numero de empleado, su primer nombre, su cargo, ciudad y pais
select * from Employees

select EmployeeID, FirstName, Title, City, Country
from Employees;


-- Alias de columna


-- En base a la consulta anterior, visualizar el empoyeeid como numero empleado, firstname, como primerNombre,
--Title como cargo, city como ciudad, country como pais,

select EmployeeID as 'Numero Empleado', FirstName as primerNombre, Title as Cargo, City as Ciudad, Country as Pais
from Employees;

select EmployeeID as [Numero Empleado], FirstName as primerNombre, Title as Cargo, City as Ciudad, Country as Pais
from Employees;


-- Campos calculados
-- Seleccionar el importe de cada uno de los productos vendidos en una orden

select * ,(UnitPrice * Quantity) as Importe from [Order Details];

-- Seleccionar las fechas de orden, año, mes y dia, el cliente que las ordeno y el empleado que la realizo

select OrderDate as 'Fecha de Orden',
year(OrderDate) as ' Año de orden',
month(OrderDate) as ' Mes de orden',
day(OrderDate) as 'Dia de Orden',
CustomerID as ClienteID, EmployeeID as EmpleadoID
from Orders;

--Filas Duplicadas (distinct)
select * from Customers;

--Mostrar los paises en donde se tienen clientes
select distinct Country
from Customers
order by country

-- Clausula where
-- Operadores relacionales(<,>,=,<=,>=,!= o <>)
select * from Customers;

-- Seleccionar el cliente BOLID

select CustomerID as ClienteID, CompanyName as 'Nombre de compañia',  city as Ciudad, country as Pais
from Customers
where CustomerID = 'BOLID'

-- Seleccionar los clientes, mostrando su identificador, nombre de la empresa, contacto, ciudad y pais de Alemania

select CustomerID as ClienteID, 
CompanyName as 'Nombre de compañia',
ContactName as 'Nombre de contacto',
ContactTitle as 'Puesto de contacto',
City as Ciudad, 
Country as Pais
from Customers
where Country = 'Germany'

-- Seleccionar todos los clientes que no sean de Alemania

select CustomerID as ClienteID, 
CompanyName as 'Nombre de compañia',
ContactName as 'Nombre de contacto',
ContactTitle as 'Puesto de contacto',
City as Ciudad, 
Country as Pais
from Customers
where Country != 'Germany'

select CustomerID as ClienteID, 
CompanyName as 'Nombre de compañia',
ContactName as 'Nombre de contacto',
ContactTitle as 'Puesto de contacto',
City as Ciudad, 
Country as Pais
from Customers
where Country <> 'Germany'

--Seleccionar todos los productos, mostrando su nombre de producto, categoria a la que pertenece, existencia, precio
--pero solamente donde su precio sea mayor a 100

select * from Products;

select ProductName as 'Nombre del producto',
CategoryID as CategoriaID,
UnitsInStock as Existencia,
UnitPrice as 'Precio del producto'
from Products
where UnitPrice > '100'

select ProductName as 'Nombre del producto',
CategoryID as CategoriaID,
UnitsInStock as Existencia,
UnitPrice as 'Precio del producto', (UnitPrice * UnitsInStock) as 'Costo Inventario'
from Products
where UnitPrice > '100'

--Seleccionar las ordenes de compra mostrando la fecha de orden, la fecha de entrega, la fecha de envio,
--el cliente a quien se vendio de 1996

select * from Orders;

select OrderDate as 'Fecha de Orden',
RequiredDate as 'Fecha de entrega',
ShippedDate as 'Fecha de envio',
CustomerID as 'Cliente'
from Orders
where year(OrderDate) = '1996'

-- Mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5

select * from [Order Details];

select Quantity as Cantidad
from [Order Details]
where Quantity >5;

-- Mostrar el nombre completo del empleado, su numero de empleado, fecha de nacimiento, la ciudad y fecha de contratacion
-- y esta debe ser de aquellos que fueron contratados despues de 1993, los resultados en sus encabezados deben ser mostrados
-- en español

select * from Employees

select FirstName as Nombre,
LastName as Apellido,
EmployeeID as 'Empleado ID',
City as Ciudad,
HireDate as 'Fecha de contratacion'
from Employees
where YEAR(HireDate) > '1993'


select (FirstName + ' ' + LastName) as 'Nombre completo',
EmployeeID as 'Empleado ID',
City as Ciudad,
HireDate as 'Fecha de contratacion'
from Employees
where YEAR(HireDate) > '1993'

select concat(FirstName,' ', LastName) as 'Nombre completo',
EmployeeID as 'Empleado ID',
City as Ciudad,
HireDate as 'Fecha de contratacion'
from Employees
where YEAR(HireDate) > '1993'

-- Mostrar los empleados que no son dirigidos por el jefe 2
select * from Employees

select concat(FirstName,' ', LastName) as 'Nombre completo',
EmployeeID as 'Empleado ID',
City as Ciudad,
HireDate as 'Fecha de contratacion',
ReportsTo as 'Jefe'
from Employees
where ReportsTo !=2