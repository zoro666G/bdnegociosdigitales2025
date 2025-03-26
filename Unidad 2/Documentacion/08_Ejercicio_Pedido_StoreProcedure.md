# Ejercicio de Pedidos con Store Procedure

## Introducción

El proceso de gestión de pedidos es fundamental en muchas aplicaciones comerciales, y el uso de procedimientos almacenados puede facilitar la validación y la ejecución de operaciones complejas en la base de datos. En este ejercicio, se muestra cómo realizar un pedido mediante un procedimiento almacenado en SQL Server. El procedimiento asegura que los datos ingresados sean válidos, realiza cálculos automáticos del importe total del pedido y actualiza el stock de los productos vendidos. 

- Realizar un pedido
- Validar que el pedido no exista
- Validar que el cliente, el empleado y el producto exista
- Validad que la cantidad a vender tenga suficiente stock
- Insertar el pedido y calcular el importe(Multiplicando el precio del producto por cantidad vendida)
- Actualizar el stock del producto(restando el stock menos la cantidad vendida)

## Codigo
``` sql
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
```

## Pruebas

``` sql
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
	@Producto= '4100X',
	@Cantidad =20
```

## Conclusión
Este ejercicio demuestra cómo un procedimiento almacenado puede simplificar la gestión de pedidos al realizar múltiples validaciones y cálculos en un solo bloque de código. Con la validación de existencia de datos, control de stock y la actualización automática del inventario, el procedimiento mejora la eficiencia del sistema, evitando errores manuales y asegurando la integridad de los datos. Además, este enfoque facilita la automatización de procesos de negocio y proporciona una mayor seguridad en las operaciones de la base de datos.