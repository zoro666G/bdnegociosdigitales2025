# Consultas Simples y Consultas SQL-LMD en Northwind**

## Introducción
Este documento cubre consultas SQL de Manipulación de Datos (LMD), incluyendo las operaciones de **INSERT, UPDATE, DELETE y SELECT** (CRUD), junto con consultas simples en la base de datos **Northwind**.

## Codigo
```sql
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

-- Seleccionar las fechas de orden, a�o, mes y dia, el cliente que las ordeno y el empleado que la realizo

select OrderDate as 'Fecha de Orden',,
CustomerID as ClienteID, EmployeeID as EmpleadoID
from Orders;
year(OrderDate) as ' A�o de orden',
month(OrderDate) as ' Mes de orden',
day(OrderDate) as 'Dia de Orden'

--Filas Duplicadas (distinct)
-- Datos repetidos
select * from Customers;

--Mostrar los paises en donde se tienen clientes
select distinct Country
from Customers
order by country

-- Clausula where
-- Operadores relacionales(<,>,=,<=,>=,!= o <>)
select * from Customers;

-- Seleccionar el cliente BOLID

select CustomerID as ClienteID, CompanyName as 'Nombre de compa�ia',  city as Ciudad, country as Pais
from Customers
where CustomerID = 'BOLID'

-- Seleccionar los clientes, mostrando su identificador, nombre de la empresa, contacto, ciudad y pais de Alemania

select CustomerID as ClienteID, 
CompanyName as 'Nombre de compa�ia',
ContactName as 'Nombre de contacto',
ContactTitle as 'Puesto de contacto',
City as Ciudad, 
Country as Pais
from Customers
where Country = 'Germany'

-- Seleccionar todos los clientes que no sean de Alemania

select CustomerID as ClienteID, 
CompanyName as 'Nombre de compa�ia',
ContactName as 'Nombre de contacto',
ContactTitle as 'Puesto de contacto',
City as Ciudad, 
Country as Pais
from Customers
where Country != 'Germany'

select CustomerID as ClienteID, 
CompanyName as 'Nombre de compa�ia',
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
-- en espa�ol

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


-- Seleccionar pedidos con flete(Freight) mayores a 100 y enviados a Francia o Espa�a

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

-- Seleccionar empleados que NO viven en Londres o Seattle y que fueron contratados despues de 1995

select concat(FirstName, ' ' , LastName) as [Nombre Completo],
		HireDate, City, Country
from Employees
where not( City = 'London' or City = 'Seattle')
	and year(HireDate) >= 1992


select concat(FirstName, ' ' , LastName) as [Nombre Completo],
		HireDate, City, Country
from Employees
where City <> 'London' and City <> 'Seattle'
	and year(HireDate) >= 1992


select concat(FirstName, ' ' , LastName) as [Nombre Completo],
		HireDate, City, Country
from Employees
where City ! = 'London' and City ! = 'Seattle'
	and year(HireDate) >= 1992


-- Clausula IN (or)
-- Seleccionar los productos con categoria 1, 3 o 5
select * from Products

select ProductName,
CategoryID,
UnitPrice
from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5 

select ProductName,
CategoryID,
UnitPrice
from Products
where CategoryID in (1,3,5)

--Seleccionar todas las ordenes de la region RJ, T�chira y que no tengan region asignada
select * from Orders

select OrderID,
OrderDate,
ShipRegion
from Orders
where ShipRegion in ('RJ','T�chira') or ShipRegion is null

--Seleccionar las ordenes que tengan cantidades de 12, 9 y 40 y descuento de 0.15 o 0.05
select*from [Order Details]
select OrderID,
Quantity,
Discount
from [Order Details]
where Quantity in (12,9,40) and (Discount =0.15 or Discount = 0.05)

-- Clausula Between (Siempre va en el where
-- Mostrar los productos con precio entre 10 y 50
select * from Products
where UnitPrice >=10 and UnitPrice<=50;

select *
from Products
where UnitPrice between 10 and 50

-- Seleccionar todos los pedidos realizados entre el primero de enero y el 30 de junio de 1997
select* from Orders
select *
from Orders
where OrderDate >= '1997-01-01' and OrderDate <= '1997-30-06'

select *
from Orders
where OrderDate between '1997-01-01' and '1997-30-06'

--Seleccionar todos los empleados contratados entre 1992 y 1994 que trabajan en londres
select* from Employees
select *
from Employees
where YEAR(HireDate) >= 1992 and YEAR(HireDate)<=1994 and City= 'London'

select *
from Employees
where YEAR(HireDate) between 1992 and 1994 and City = 'London'

--Seleccionar pedidos con flete entre 50 y 200 enviados a Alemania y a Francia
select * from Orders
select *
from Orders
where Freight between 50 and 200 and (ShipCountry = 'Germany' or ShipCountry = 'France')

select *
from Orders
where Freight >=50 and Freight <=200 and (ShipCountry = 'Germany' or ShipCountry = 'France')

select *
from Orders
where Freight between 50 and 200 and ShipCountry in ('Germany' ,'France')

--Seleccionar todos los productos que tengan un precio entre 5 y 20 dolares y que sean de la categoria 1, 2 o 3
select * from Products
select*
from Products where UnitPrice >= 5 and UnitPrice <= 20 and (CategoryID =1 or CategoryID =2 or CategoryID =3)

select*
from Products where UnitPrice between 5 and 20 and CategoryID in (1,2,3)

--Empleados con numero de trabajador entre 3 y 7 que no trabajan en Londres ni seattle
select * from Employees
select *
from Employees
where EmployeeID between 3 and 7 and not City = 'London' and  not City = 'Seattle'

select *
from Employees
where EmployeeID between 3 and 7 and not City in ('London', 'Seattle')

select EmployeeID
from Employees

--Clausula like
-- Patrones:
	--1) % -> Representa 0 o mas caracteres en el patron de busqueda
	--2) _ -> Representa exactamente un caracter en la busqueda
	--3) [] -> Se utiliza para definir un conjunto de caracteres, buscando cualquiera de ellos en la posicion especifica
	--4) [^] -> Se utiliza para buscar caracteres que no estan dentro del conjunto especifico

-- Buscar los productos que comienzan con Cha

select *
from Products
where ProductName like 'c%'

select *
from Products
where ProductName like 'cha%' and UnitPrice =18

-- Buscar todos los productos que terminen con e 

select *
from Products
where ProductName like '%e'

-- Seleccionar todos los clientes cuyo nombre de empresa contiene "co" en cualquier parte

select *
from Customers
where CompanyName like '%co%'

-- Seleccionar los empleados cuyo nombre comienze con "A" y tenga exactamente 5 caracteres

select FirstName, LastName
from Employees
where FirstName like 'A_____' 

-- Seleccionar los productos que comienzen con A o B

select *
from Products
where ProductName like '[AB]%'

select *
from Products
where ProductName like '[A-M]%'

-- Seleccionar todos los productos que no comienzen con A o B

select *
from Products
where ProductName like '[^AB]%'

-- Seleccionar todos los productos donde el nombre comienze con A pero que no contenga la E en la que sigue

select*
from Products
where ProductName like 'a[^e]%' 

-- Clausula order by

select ProductID,
ProductName,
UnitPrice,
UnitsInStock
from Products
order by UnitPrice desc

select ProductID,
ProductName,
UnitPrice,
UnitsInStock
from Products
order by 3 desc

select ProductID,
ProductName,
UnitPrice as 'Precio',
UnitsInStock
from Products
order by 'Precio' desc

-- Seleccionar los clientes ordenados por el pais y dentro por ciudad
select CustomerID,
Country,
City
from Customers
order by  Country asc, city asc

select CustomerID,
Country,
City
from Customers
where Country in ('Brazil', 'Germany')
order by  Country asc, city desc

select CustomerID,
Country,
City
from Customers
where (Country = 'Brazil' or country ='Germany') and Region is not null
order by  Country asc, city desc

select CustomerID,
Country,
City
from Customers
where (Country = 'Brazil' or country ='Germany') and Region is not null
order by  Count, city desc
```

## Conclusión
Este documento proporciona ejemplos de consultas SQL para la manipulación y consulta de datos en la base Northwind, utilizando LMD y diversas técnicas de filtrado y ordenamiento.

