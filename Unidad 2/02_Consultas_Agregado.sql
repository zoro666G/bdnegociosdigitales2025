-- Consultas de agregado 
-- NOTA: Solo devuelven un solo registro
-- sum, avg, count, count(*), max y min
-- Con * no cuenta los nulos

-- Cuantos clientes tengo
select count(*) as 'Numero de clientes'
from Customers

-- Cuantas regiones hay
select count(distinct Region)
from Customers
where Region is not null
