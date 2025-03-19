# Ejercicio de Pedidos con Store Procedure

- Realizar un pedido
- Validar que el pedido no exista
- Validar que el cliente, el empleado y el producto exista
- Validad que la cantidad a vender tenga suficiente stock
- Insertar el pedido y calcular el importe(Multiplicando el precio del producto por cantidad vendida)
- Actualizar el stock del producto(restando el stock menos la cantidad vendida)

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