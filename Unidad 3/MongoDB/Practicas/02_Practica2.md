# Consultas

1. Cargar el archivo empleados.json


2. Utilizar la base de datos curso
```
use Curso
```

3. Buscar todos los empleados que trabajen en google
- 3
```json
db.empleados.find({empresa: 'Google'})
```

4. Empleados que vivan en peru
- 4
```json
db.empleados.find({pais: 'Peru'})
```

5. Empleados que ganen mas de 8000 dolares
- 5
```json
db.empleados.find({salario: {$gt:8000}})
```

6. Empleados con ventas inferiores a 10000
- 6
```json
db.empleados.find({ventas: {$lt:10000}})
```
7. Realizar la consulta anterior pero devolviendo una sola fila
- 7
```json
db.empleados.findOne({ventas: {$lt:10000}})
```
8. Empleados que trabajan en google o en yahoo con el operador $in
- 8
```json
db.empleados.find({empresa: { $in: ['Google', 'Yahoo'] }} )
```

9. Empleados de amazon que ganen mas de 8000 dolares
- 9
```json
db.empleados.find({empresa: 'Amazon', salario: {$gt:8000}})
```

10. Empleados que trabajan en Google o en Yahoo con el operador $or
- 10
```json
db.empleados.find({$or:[{empresa:'Google'},{empresa:'Yahoo'}]})
```


11. Empleados que trabajen en Yahoo que ganen mas de 6000 o empleados que trabajen en Google que tengan ventas inferiores a 20000
- 11
```json
db.empleados.find({ $or: [{empresa: 'Yahoo', salario: {$gt:6000}},{empresa: 'Google', ventas: {$lt:20000}}]})
```


12. Visualizar el nombre, apellidos y el país de cada empleado
- 12
```json
db.empleados.find({},{ nombre: 1, apellidos: 1, pais: 1 ,_id:0})
```
