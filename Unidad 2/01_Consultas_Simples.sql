
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

-- Seleccionar empleados que no tengan jefe

select * from Employees
where ReportsTo is null;

-- Operadores logicos (or, and y not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50 dolares

select ProductName as 'Nombre',
UnitPrice as 'Precio',
UnitsInStock as 'Existencia'
from Products
where UnitPrice >=10 and UnitPrice <=50

-- Mostrar todos los pedidos realizador por clientes que no son enviados a Alemania

select * from Orders
select *
from Orders
where ShipCountry !='Germany'

select * from Orders
where NOT ShipCountry = 'Germany'

-- Seleccionar clientes de Mexico o Usa

select * from Customers;
select *
from Customers
where Country = 'Mexico' or Country = 'USA'

-- Seleccionar empleados que nacieron entre 1955 y 1958 y que viven en Londres

select * from Employees;

select *
from Employees
where (year (BirthDate) >=1955 and year (BirthDate) <=1958) and City = 'London'


-- Seleccionar pedidos con flete(Freight) mayores a 100 y enviados a Francia o España

select * from Orders

select *
from Orders
where Freight >100 and (ShipCountry = 'France' or ShipCountry = 'Spain')

-- Seleccionar las primeras cinco ordenes de compra 

select * from Orders

select top 5 * from Orders
select top 5 OrderID from Orders

-- Seleccionar los productos con precio entre 10 y 50, que no esten descontinuados y tengan mas de 20 unidades en stock

select * from Products

select *
from Products
where UnitPrice >=10 and UnitPrice <=50 and Discontinued = 0 and UnitsInStock >20

-- Seleccionar los pedidos enviados a Francia o Alemania pero con un flete menor a 50

select * from Orders

select *
from Orders
where (ShipCountry = 'Germany' or ShipCountry ='France') and Freight <50


-- Seleccionar clientes que NO sean de Mexico o USA y que tengan FAX registrado

select * from Customers

select *
from Customers
where not(Country='Mexico' or Country ='USA') and Fax is not null

select *
from Customers
where (Country<>'Mexico' and Country <>'USA') and Fax is not null

-- Seleccionar pedidos con un flete mayor a 100, enviados a Brasil o Argentina, pero NO enviados por el transportista 1

select * from Shippers
select * from Orders

select * from
Orders
where Freight >100 and (ShipCountry ='Brazil' or ShipCountry = 'Argentina') and not ShipVia= 1;



