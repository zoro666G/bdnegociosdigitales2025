
-- Funciones de cadena

-- Las funciones de cadena permiten manipular tipos de datos como varchar, nvarchar, char, nchar

-- Funcion Len -> Devuelve la longitud de una cadena

-- Declaracion de una variable

declare @Numero int;
set @Numero = 10;
print @Numero


-- Obtener el tamaño de la cadena almacenada en la variable texto

select len(@Texto) as [Longitud]



-- Funcion left -> Extrae un determinado numero de caractes especifico desde el inicio de la cadena

select left(@Texto, 4) as Inicio

-- Funcion right -> Extrae un determinado numero de caractes especifico desde el final de la cadena

select right(@Texto, 6) as Final

-- SubString -> Extrae una parte de la cadena, donde el segundo parametro es la posicion inicial y el tercer parametro el recorrido
declare @Texto varchar(50) = 'Hola, Mundo!';
select SUBSTRING(@Texto, 7, 5)
select Companyname, len(CompanyName) as 'Numero de caracteres', left(CompanyName, 4) as Inicio, RIGHT(CompanyName, 6) as Final,
SUBSTRING(CompanyName, 7, 4) as 'Subcadena'
from Customers

-- Replace -> Remplaza una subcadena por otra
declare @Texto varchar(50) = 'Hola, Mundo!';
select REPLACE(@Texto, 'Mundo', 'Amigo')

-- Char Index
select CHARINDEX('Hola', @Texto)

-- Upper -> Convierte una cadena en mayusculas

select concat(left(@Texto,6), upper(SUBSTRING(@Texto, 7, 5)), right(@Texto, 1)) as 'Texto Nuevo'

update Customers
set CompanyName = UPPER(CompanyName)
where Country in ('Mexico', 'Germany')

-- Trim -> Quita espacios en blanco de una cadena
select trim( '     Test    ') as result;

declare @Texto varchar(50) = '    Hola, Mundo!     ';
select trim(@Texto) as result;
select * from Customers

