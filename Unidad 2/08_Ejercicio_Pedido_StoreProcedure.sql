-- Realizar un pedido
-- Validar que el pedido no exista
-- Validar que el cliente, el empleado y el producto exista
-- Validad que la cantidad a vender tenga suficiente stock
-- Insertar el pedido y calcular el importe(Multiplicando el precio del producto por cantidad vendida)
-- Actualizar el stock del producto(restando el stock menos la cantidad vendida)

create or alter proc spu_realizar_pedido
	@Num_Pedido int,
	@Cliente int,
	@Rep int,
	@Fab char(3),
	@Producto char(5),
	@Cantidad int
	as
	begin 
	if exists (select 1 from Pedidos where Num_Pedido = @Num_Pedido)
		begin
		print ('El pedido ya existe')
		return
	end

	if not exists (select 1 from Clientes where Num_Cli = @Cliente) or
	   not exists (select 1 from Representantes where Num_Empl = @Rep) or
	   not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @Producto)

		begin
		print ('Los datos no son validos')
		return
	end

	if @Cantidad <=0
	begin
		print 'La cantidad no puede ser 0 o negativo'
		return;
	end

	declare @stockValido int
	select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto = @Producto

	if @Cantidad > @stockValido
	begin
		print 'No hay suficiente stock'
		return;
	end
	
	declare @Precio money
	declare @Importe money
	select @Precio=Precio from Productos where Id_fab = @Fab and Id_producto = @Producto
	set @Importe = @Cantidad * @Precio

	begin try

	-- Se inserto un pedido
	insert into Pedidos
	values(@Num_Pedido, GETDATE(), @Cliente, @Rep, @Fab, @Producto, @Cantidad, @Importe);

	update Productos
	set Stock = Stock - @Cantidad
	where Id_fab = @Fab and Id_producto = @Producto;

	end try
	begin catch
	print  'Error al actualizar datos'
	return;
	end catch

end;

-- CHAT GPT CORRECCION










CREATE OR ALTER PROCEDURE spu_realizar_pedido
    @Num_Pedido INT,     -- Número del pedido
    @Cliente INT,        -- ID del cliente que realiza el pedido
    @Rep INT,            -- ID del representante de ventas
    @Fab CHAR(3),        -- ID del fabricante del producto
    @Producto CHAR(5),   -- ID del producto solicitado
    @Cantidad INT        -- Cantidad de unidades pedidas
AS
BEGIN 
    -- Verificar si el pedido ya existe en la base de datos
    IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @Num_Pedido)
    BEGIN
        PRINT ('El pedido ya existe') -- Mensaje si el pedido ya está registrado
        RETURN
    END

    -- Validar si existen el cliente, el representante y el producto
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @Cliente) OR
       NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @Rep) OR
       NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @Fab AND Id_producto = @Producto)
    BEGIN
        PRINT ('Los datos no son válidos') -- Mensaje de error si los datos son incorrectos
        RETURN
    END

    -- Validar que la cantidad solicitada sea mayor a 0
    IF @Cantidad <= 0
    BEGIN
        PRINT 'La cantidad no puede ser 0 o negativa' -- Mensaje de error si la cantidad no es válida
        RETURN;
    END

    -- Verificar si hay suficiente stock disponible para el pedido
    DECLARE @stockValido INT
    SELECT @stockValido = Stock FROM Productos WHERE Id_fab = @Fab AND Id_producto = @Producto

    IF @Cantidad > @stockValido
    BEGIN
        PRINT 'No hay suficiente stock' -- Mensaje de error si no hay stock suficiente
        RETURN;
    END

    -- Obtener el precio unitario del producto y calcular el importe total del pedido
    DECLARE @Precio MONEY
    DECLARE @Importe MONEY
    SELECT @Precio = Precio FROM Productos WHERE Id_fab = @Fab AND Id_producto = @Producto
    SET @Importe = @Cantidad * @Precio -- Cálculo del importe total

    BEGIN TRY
        -- Insertar un nuevo pedido en la tabla Pedidos
        INSERT INTO Pedidos
        VALUES(@Num_Pedido, GETDATE(), @Cliente, @Rep, @Fab, @Producto, @Cantidad, @Importe);

        -- Actualizar el stock del producto restando la cantidad pedida
        UPDATE Productos
        SET Stock = Stock - @Cantidad
        WHERE Id_fab = @Fab AND Id_producto = @Producto;

    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar datos' -- Mensaje en caso de error
        RETURN;
    END CATCH
END;



execute spu_realizar_pedido 
@Num_Pedido = 113070,
    @Cliente = 2000,
	@Rep= 106,
	@Fab= 'REI',
	@Producto= '2A44L',
	@Cantidad =0

	execute spu_realizar_pedido 
	@Num_Pedido = 113070,
    @Cliente = 2117,
	@Rep= 111,
	@Fab= 'REI',
	@Producto= '2A44L',
	@Cantidad =20

	execute spu_realizar_pedido 
	@Num_Pedido = 113070,
    @Cliente = 2000,
	@Rep= 106,
	@Fab= 'REI',
	@Producto= '2A44L',
	@Cantidad =20

	execute spu_realizar_pedido 
	@Num_Pedido = 113070,
    @Cliente = 2117,
	@Rep= 101,
	@Fab= 'ACI',
	@Producto= '4100W',
	@Cantidad =0

select * from Pedido

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100x'

-- NORTHWIND








USE Northwind;
GO

CREATE OR ALTER PROCEDURE spu_realizar_pedido_northwind
    @OrderID INT,              -- ID del Pedido
    @CustomerID NCHAR(5),      -- Cliente que realiza el pedido
    @EmployeeID INT,           -- Empleado que gestiona el pedido
    @ProductID INT,            -- Producto vendido
    @Quantity INT              -- Cantidad de productos comprados
AS
BEGIN
    -- Verificar si el pedido ya existe
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'Error: El pedido ya existe.';
        RETURN;
    END

    -- Verificar si el cliente y el empleado existen
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        PRINT 'Error: El cliente no existe.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
    BEGIN
        PRINT 'Error: El empleado no existe.';
        RETURN;
    END

    -- Verificar si el producto existe
    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        PRINT 'Error: El producto no existe.';
        RETURN;
    END

    -- Validar que la cantidad ingresada sea mayor a 0
    IF @Quantity <= 0
    BEGIN
        PRINT 'Error: La cantidad debe ser mayor a 0.';
        RETURN;
    END

    -- Verificar si hay suficiente stock del producto
    DECLARE @StockDisponible INT;
    SELECT @StockDisponible = UnitsInStock FROM Products WHERE ProductID = @ProductID;

    IF @Quantity > @StockDisponible
    BEGIN
        PRINT 'Error: No hay suficiente stock. Disponible: ' + CAST(@StockDisponible AS NVARCHAR);
        RETURN;
    END

    -- Obtener el precio del producto
    DECLARE @Precio MONEY;
    SELECT @Precio = UnitPrice FROM Products WHERE ProductID = @ProductID;

    -- Calcular el importe total
    DECLARE @ImporteTotal MONEY;
    SET @ImporteTotal = @Quantity * @Precio;

    -- Manejo de errores con TRY...CATCH
    BEGIN TRY
        -- Insertar el pedido en la tabla Orders
        INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
        VALUES (@OrderID, @CustomerID, @EmployeeID, GETDATE());

        -- Insertar el detalle del pedido en la tabla Order Details
        INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
        VALUES (@OrderID, @ProductID, @Precio, @Quantity, 0);

        -- Actualizar el stock del producto
        UPDATE Products
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID;

        PRINT 'Pedido registrado correctamente con un total de $' + CAST(@ImporteTotal AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT 'Error al procesar el pedido.';
    END CATCH;
END;
GO

EXEC spu_realizar_pedido_northwind 
    @OrderID = 11080, 
    @CustomerID = 'ALFKI', 
    @EmployeeID = 1, 
    @ProductID = 1, 
    @Quantity = 5;

  select * from Orders
  where OrderID = 11080 and CustomerID = 'ALFKI'