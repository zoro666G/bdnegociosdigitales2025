# Funciones de Cadena en SQL

## Introducción
Este documento cubre el uso de **funciones de cadena** en SQL, que permiten manipular tipos de datos como `varchar`, `nvarchar`, `char` y `nchar`. Las funciones más comunes incluyen la obtención de la longitud de una cadena, la extracción de subcadenas, el reemplazo de caracteres y la conversión de texto, entre otras. A continuación se muestran ejemplos prácticos de cómo utilizar estas funciones en consultas SQL.

```sql
-- Funciones de cadena

-- Las funciones de cadena permiten manipular tipos de datos como varchar, nvarchar, char, nchar

-- Funcion Len -> Devuelve la longitud de una cadena

-- Declaracion de una variable

declare @Numero int;
set @Numero = 10;
print @Numero


-- Obtener el tama�o de la cadena almacenada en la variable texto

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
```

## Conclusión
Las funciones de cadena en SQL son herramientas poderosas para manipular y transformar datos textuales en una base de datos. Este documento ha cubierto algunas de las funciones más comunes, como `LEN`, `LEFT`, `RIGHT`, `SUBSTRING`, `REPLACE`, `CHARINDEX`, `UPPER` y `TRIM`. Estas funciones permiten realizar una variedad de operaciones, como obtener la longitud de cadenas, extraer partes específicas de un texto, realizar reemplazos y modificar el formato de las cadenas, lo que resulta muy útil en análisis y procesamiento de datos.