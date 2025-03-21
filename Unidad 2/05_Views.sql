
-- Views

-- Sintaxis
/*create view nombreVista
as 
select columnas
from tabla
where condicion 
*/

use Northwind
go

create view VistaCategoriasTodas
as
select CategoryID, CategoryName, [Description], Picture 
from Categories
where CategoryName = 'Beverages'
go



select * from VistaCategoriasTodas
where CategoryName = 'Beverages'

-- Crear una vista que permita visualizar solamente clientes de Mexico y Brazil
go
create or alter view vistaClientesLatinos
as
select *
from Customers
where Country in ('Mexico', 'Brazil')


select CompanyName as 'Cliente',
City as 'Ciudad', Country as 'Pais'
from vistaClientesLatinos
where City = 'Sao Paulo'
order by 2 desc

select distinct vcl.Country
from Orders as o
inner join vistaClientesLatinos as vcl
on vcl.CustomerID = o.CustomerID





drop view vistaClientesLatinos
select * from vistaClientesLatinos

-- Crear una vista que contenga los datos de todas las ordenes los productos, categorias de productos, en la orden calcular el importe
go
create or alter view [dbo].[vistaordenescompra]
as
select o.OrderID as 'Numero de orden', o.OrderDate as 'Fecha de orden', o.RequiredDate as 'Fecha de requisicion',concat(e.FirstName, ' ', e.LastName) as 'Nombre del empleado',
cu.CompanyName as 'Nombre del cliente', p.ProductName as 'Nombre producto', c.CategoryName as 'Nombre de la categoria', od.UnitPrice as 'Precio de venta', od.Quantity as 'Cantidad Vendida',
(od.Quantity * od.UnitPrice) as 'Importe'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID
go

select count(distinct [Numero de orden]) as [Numero de ordenes]
from vistaordenescompra

select sum([Cantidad Vendida] * [Precio de venta]) as [importe total]
from vistaordenescompra
go

select sum([Cantidad Vendida] * [Precio de venta]) as [importe total]
from vistaordenescompra
where year([Fecha de orden]) between '1995' and '1996' 
go

create or alter view vista_ordenes_1996_1996
as
select [Nombre del Cliente] as 'Nombre Cliente', sum([Cantidad Vendida] * [Precio de venta]) as [importe total]
from vistaordenescompra
where year([Fecha de orden]) between '1995' and '1996' 
group by [Nombre del cliente]
--Solo se incluyen los clientes que tienen más de 2 órdenes
having count(*)>2
go

create schema rh

create table rh.tablarh (
	id int primary key,
	nombre nvarchar(50)
)

create or alter view rh.viewcategoriasproductos
as
select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName   
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID;
go

select * from rh.viewcategoriasproductos