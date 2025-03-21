
-- Examen Store y Vistas, Gustavo Martinez Guerra

-- 1. Vista 1
use northwind
go
create or alter view vista_informacion_ventas
as
select
o.OrderID, 
o.RequiredDate,
c.CompanyName,
concat(e.FirstName, ' ', e.LastName) AS 'Empleado',
(od.Quantity * od.UnitPrice) as 'Monto Total',
c.ContactName as 'Nombre del cliente',
c.City as 'Ciudad del cliente'
from Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join Employees as e 
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on o.OrderID = od.OrderID
go

select * from vista_informacion_ventas

-- 2. Vista 2 

go
create or alter view vista_informacion_productos
as
select
p.ProductName as 'Nombre del producto',
p.UnitPrice as 'Precio del producto',
od.Quantity as 'Cantidad Vendida',
od.UnitPrice as 'Precio de venta',
o.RequiredDate as 'Fecha del pedido',
c.CompanyName as 'Nombre del cliente',
c.Country as 'Pais del cliente'
from Products as p
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as c
on o.CustomerID = c.CustomerID
go

select * from vista_informacion_productos

-- 3. Store Procedure

go
create or alter procedure spu_actualizar_precio_producto
@ProductID int,
@NuevoPrecio money,
@Discontinued bit
as
begin
-- Verificar que el producto exista
  if not exists (select 1 from Products where ProductID = @ProductID)
    begin
        print 'Error: El producto no existe.';
        return;
    end
-- Producto no discontinuado
	if @Discontinued = 1
	begin
		print 'Error: El producto esta discontinuado.';
		return;
	end
-- Precio mayor que 0
	if @NuevoPrecio < 0
	begin
		print 'Debe ser mayor a 0';
		return
		end
	
		begin try

	insert into Products (ProductID, UnitPrice, Discontinued)
	values(@ProductID, @NuevoPrecio, @Discontinued);

		update Products
	set UnitPrice = UnitPrice + @NuevoPrecio
	where ProductID = @ProductID and Discontinued = @Discontinued;

	   print 'Precio del producto registrado correctamente.';
    end try
    begin catch
        print 'Error inesperado.';
    end catch;
end;
go

-- Pruebas

select * from Products

exec spu_actualizar_precio_producto
@ProductID = 1,
@NuevoPrecio = -10.00,
@Discontinued = 0;

-- El producto no existe
exec spu_actualizar_precio_producto
@ProductID = 90,
@NuevoPrecio = 100.00,
@Discontinued = 1;

-- El producto esta discontinuado
exec spu_actualizar_precio_producto
@ProductID = 5,
@NuevoPrecio = 100.00,
@Discontinued = 1;

exec spu_actualizar_precio_producto
@ProductID = 1,
@NuevoPrecio = 150.00,
@Discontinued = 0;



