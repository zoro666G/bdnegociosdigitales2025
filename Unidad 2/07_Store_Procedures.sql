-- Store Procedure

-- Crear un store para seleccionar todos los clientes .
go 
create or alter procedure spu_mostrar_clientes
as
begin
	select * from Customers;
end;
go

-- Ejecutar un store en transact
execute spu_mostrar_clientes

-- Crear un store procedure que muestre los clientes por pais
-- Parametros de entrada
go
Create or alter proc spu_customersporpais
--Parametros
@pais nvarchar(15),
@pais2 nvarchar(15)
-- Parametro de entrada
as
begin
	select * from Customers
	where Country in (@pais, @pais2);
end;

-- Fin del store

-- Ejecuta un store procedure
declare @p1 nvarchar(15) = 'Spain';
declare @p2 nvarchar(15) = 'Germany';

execute spu_customersporpais @p1, @p2;

-- Generar un reporte que permita visualizar los datos de compra de un determinado cliente, en un rango de fechas, mostrando el monto total de compras
-- por producto

select * from vistaordenescompra 
go

create or alter proc spu_informe_ventas_clientes
-- Parametros
@nombre nvarchar(40) = 'Berglunds snabbköp', -- Parametro de entrada con valor por default
@fechaInicial datetime,
@fechaFinal datetime
-- Parametro de entrada
as
begin
select [Nombre producto],[Nombre del cliente], sum(importe) as 'Monto Total' 
from vistaordenescompra
where [Nombre del cliente] = @nombre and [Fecha de orden] between @fechaInicial and @fechaFinal
group by [Nombre producto], [Nombre del cliente]
end;
go

-- Ejecucion de un store con parametros de entrada
select getdate() --año, mes, dia
execute spu_informe_ventas_clientes 'Berglunds snabbköp', '1996-04-07', '1997-01-01'

-- Ejecucion de un store procedure con parametros en diferente posicion 

execute spu_informe_ventas_clientes @fechaFinal= '1997-01-01', @nombre=' Berglunds snabbköp', @fechaInicial = '1996-04-07' ;

-- Ejecucion de un store procedure con parametros de entrada con un campo que tiene un valor por default

execute spu_informe_ventas_clientes @fechaInicial = '1996-04-07', @fechaFinal= '1997-01-01';
go
-- Store procedure con parametros de salida

create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), -- Parametro de entrada
@totalCustomers int output -- Parametro de salida
as
begin
	select @totalCustomers = count(*) from Customers
	where CustomerID = @customerid;
end;
go

declare @numero int;
exec spu_obtener_numero_clientes @customerid = 'ANATR',
@totalCustomers = @numero output;
print @numero;
go

-- Crear un store procedure que permita saber si un alumno aprobo o reprobo

create or alter proc spu_comparar_calificacion
@calif decimal (10,2) -- Parametro de entrada
as
begin
	if @calif>=0 and @calif<=10
	begin
		if @calif>=8
		print 'La calificacion es aprovatoria'
		else
		print 'La calificacion es reprobatoria'
	end
	else
	   print 'Calificacion no valida'
end;
go

exec spu_comparar_calificacion @calif = 10
go
-- Crear un sp que permita verificar si un cliente existe antes de devolver su informacion

create or alter proc spu_obtener_cliente_siexiste
@numeroCliente nchar(5)
as
begin
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
end;
go

exec spu_obtener_cliente_siexiste @numeroCliente = 'AROUT'

select 1 from Customers where CustomerID = 'AROUT' 

-- Crear un store procedure que permita insertar un cliente, pero se debe verificar primero que no exista


create or alter proc spu_agregar_cliente
	@id nchar(5),
	@nombre varchar(40),
	@city nvarchar(15) = 'San Miguel'
	as
	begin
	if exists (select 1 from Customers where CustomerID = @id)
		begin
		print ('El Cliente ya existe')
		return 1
	end
	insert into Customers (CustomerID, CompanyName)
	values (@id,@nombre);
	print ('Cliente insertado exitosamente');
	return 0;
end;
	go


execute spu_agregar_cliente 'AlFKI', 'Patito de Hule'
execute spu_agregar_cliente 'AlFKC', 'Patito de Hule'
go

create or alter procedure spu_agregar_cliente_try_catch
	@id nchar(5),
	@nombre varchar(40),
	@city nvarchar(15) = 'San Miguel'
	as
	begin
		begin try
		insert into Customers (CustomerID, CompanyName)
	values (@id,@nombre);
	print ('Cliente insertado exitosamente');
		end try
		begin catch
		print ('El Cliente ya existe')
		end catch
	end;
	go
	execute spu_agregar_cliente_try_catch 'AlFKC', 'Muñeca Vieja'

	-- Manejo de ciclos en store procedures

	-- Imprimir el numero de veces que indique el usuario

	create or alter procedure spu_imprimir
	@numero int
	as
	begin

		if @numero <=0
		begin
		print ('El numero no puede ser 0 o negativo')
			return
		end
		declare @i int
		set @i = 1
		while(@i<=@numero)
		begin
			print concat('Numero ' , @i)
			set @i = @i +1
		end
	end;
	go
	execute spu_imprimir @numero = 120