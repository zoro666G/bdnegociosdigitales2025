# MongoDB Crud

## Crear una base de datos

**Solo se crea si contiene por lo menos una coleccion**

```json
use basededatos
```
## Crear una coleccion

`use bd1
db.createCollection('Empleado')`

## Mostrar coleccioneds
`show collections`

## Insercion de un documento
db.Empleado.insertOne(
{
    nombre:'Soyla',
    apellido:'Vaca',
    edad: 32,
    ciudad: 'San Miguel de las piedras'
  }
)