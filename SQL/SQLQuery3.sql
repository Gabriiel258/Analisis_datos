--1. Cree una base de datos que se llame operaciones utilizando un script.
CREATE DATABASE OPERACIONES ON
(NAME=N'OPERACIONES',FILENAME=N'C:\Users\donos\OneDrive\Escritorio\Sql_Ejercicios\OPERACIONES.mdf')
LOG ON 
(NAME=N'OPERACIONES_LOG',FILENAME=N'C:\Users\donos\OneDrive\Escritorio\Sql_Ejercicios\OPERACIONES_LOG.mdf')

select *
from Transacciones_final

--2. Utilizando código, construya una tabla con la siguiente estructura
--id pago | nombre pago
							 --1 | Contado
							 --2 | Crédito
							 --3 | Financiado
							 --4 | Obsequio
	--defina el campo id pago como llave primaria

CREATE TABLE Pago
(id_pago int not null primary key,
nombre_pago Nvarchar(10))

INSERT INTO Pago VALUES (1,'Contado')
INSERT INTO Pago VALUES (2,'Credito')
INSERT INTO Pago VALUES (3,'Financiado')
INSERT INTO Pago VALUES (4,'Obsequio')

--3. Utilizando código, cree las llaves primarias de cada tabla.

ALTER TABLE Municipios add constraint id_municipios primary key (id_municipios)
ALTER TABLE Transacciones_final add constraint id_transacción primary key (id_transacción)

--4. Utilizando código, defina el campo cédula como índice o como valor único
ALTER TABLE Personas add constraint cedula unique (cedula)

--5. Utilizando codigo, cree un campo en transacciones que se llame pago y asigne contado a todas las transacciones
SELECT *
FROM Transacciones_final
ALTER TABLE Transacciones_final ADD Pago int
select *
from Pago
update Transacciones_final
set Pago = 1

--6. Utilizando código, cree las llaves foráneas

alter table Personas add FOREIGN KEY (Municipio) REFERENCES  Municipios (id_municipios)
alter table Transacciones_final add foreign key (cedula) references Personas (cedula)
alter table Transacciones_final add foreign key (producto) references CodigoProductos (id_producto)
alter table Transacciones_final add foreign key (Pago) references Pago (id_pago)


/*7. Utilizando código, registre la siguiente transacción: Juan Ruíz Orjuela de Manizales con cédula de ciudadanía 1023910489, nació el 19 de diciembre de 1990, 
su celular es 3132457893 y se llevó 3 pantalones de hombre y 2 blusas, un pantalón fue obsequiado y los otros dos los pago de contado, la blusa si fue comprada a crédito.*/

select id_producto, nombre_producto
from CodigoProductos
where nombre_producto like '%BLUS%'

select*
from Transacciones_final

SELECT TOP (5) id_transacción
FROM Transacciones_final
ORDER BY id_transacción DESC;

select id_municipios
from Municipios
where nombre = 'Manizales'

INSERT INTO Personas VALUES(26,1023910489,'Juan',null,'Ruíz','Orjuela','1990-12-19',17001,3132457893,null)

INSERT INTO Transacciones_final VALUES(12347939,1023910489,'2023-06-12',435672,1,4)
INSERT INTO Transacciones_final VALUES(12347940,1023910489,'2023-06-12',435672,2,1)
INSERT INTO Transacciones_final VALUES(12347941,1023910489,'2023-06-12',273893,2,2)

--10. En la tienda todos los aretes son de obsequio, cambie el método de pago de este producto en las transacciones

Select*
from Transacciones_final
where producto = 389333

update Transacciones_final
set Pago = 4
where producto = 389333

--11. Seleccione todas las transacciones realizadas por la cédula 53135666 y ordénelas por fecha de la más reciente a la más antigua

select *
from Transacciones_final
where cedula = 53135666
order by fecha desc

--12. Elimine todas las transacciones realizadas por la anterior cédula que se hayan realizado del producto 345672 y después del 7 de octubre de 2011

select*
from Transacciones_final
where cedula = 53135666 and producto = 345672 and fecha >'2011-10-7'

delete 
from Transacciones_final
where cedula =  53135666 and producto = 345672 and fecha >'2011-10-7'


--13. Cambie todas las transacciones de la cédula 1233490932 de los productos 389333,174563,273893 a financiadas

select*
from Transacciones_final
where cedula = 1233490932  and (producto = 389333 or producto = 174563 or producto=273893)

update Transacciones_final
set Pago =3
where cedula = 1233490932 and (producto = 389333 or producto= 174563 or producto = 273893) 

--14. Hubo un error, el anterior cambio no era financiadas, era a crédito. Realice el cambio utilizando el comando in

update Transacciones_final
set Pago=2
where cedula = 1233490932 and producto in(389333, 174563 , 273893)


--15. Realice una consulta de todas las transacciones realizadas en marzo del 2012 trayendo únicamente cédula y producto. Llame a los campos documento de identidad y artículo.

select cedula 'documento de identidad', producto 'artículo'
from Transacciones_final
where fecha >= '2012-3-01' and fecha <= '2012-3-31'

--16. Consulte la cédula, primer nombre, apellido y celular de todos las personas que no tienen correo.

select cedula, primer_nombre, primer_apellido, segundo_apellido, celular
from Personas
where correo is null

--17. Consulte todas las transacciones que no se realizaron de contado

select *
from Transacciones_final
where Pago not in (1) 

--18. Cuente la cantidad de clientes

select COUNT(*)
from Personas

select COUNT(id_personas)
from Personas

--19. Halle la suma del total de productos comprados

select SUM(cantidad) as 'total'
from Transacciones_final

--20. Halle el menor, mayor y costo promedio. Nómbrelos.

select *
from CodigoProductos

select MiN(Precio) 'minimo', MAX(Precio) 'maximo', AVG(Precio) 'promedio'
from CodigoProductos

--21. Halle la cantidad de unidades que se han vendido de cada producto y llámela cantidad vendida y ordénelas de mayor a menor

select*
from Transacciones_final

select producto, SUM(cantidad) 'cantidad'
from Transacciones_final
group by (producto)
order by SUM(cantidad) desc

--cantidad de personas por municipios

select municipio, COUNT(id_personas) as 'cantidad'
from Personas
group by municipio
order by cantidad desc

--22. Consulte los 10 clientes que compraron la mayor cantidad de productos

select top(10) cedula, producto, sum (cantidad) as 'total' 
from Transacciones_final
group by cedula, producto
order by total desc

--23. De la tabla Personas, consulte los primeros nombres distintos.

select DISTINCT (primer_nombre)
from Personas

--24. Cuente la cantidad de primeros nombres distintos.

select COUNT(DISTINCT(primer_nombre)) as 'nombres distintos'
from Personas

--25. Consulte los clientes cuyo apellido empieza por p

select *
from Personas
where primer_apellido like '%p%' or segundo_apellido like '%p%' 

--26. Consulte los clientes cuyo nombre tenga 'la'

select*
from Personas
where primer_nombre like '%la%' or segundo_nombre like '%la%'

--27. Consulte todos los nombres que no tienen 'a'

select*
from Personas
where primer_nombre not like '%a%' and segundo_nombre not like '%a%'


--28. Cree una vista que contenga la cantidad de unidades que se han comprado de cada artículo

create view cantidad_productos as
(
select producto, sum(cantidad) 'cantidad'
from Transacciones_final
group by producto 
)

select*
from cantidad_productos


--29 cree dos vistas con las compras realizadas con la siguiente cedula  debe aparecer el nombre de la personas y nombre del producto


select*
from Personas

select producto, cantidad, primer_nombre
from Transacciones_final as t
join Personas as p
on t.cedula = p.cedula
where t.cedula = 53043866


--30 cuenta todas las transacciones
select COUNT(*)
from Transacciones_final

--31 cuenta todas las personas

select COUNT(*)
from Personas

--32 cree una vista de la siguiente cedula 1073507017 mostrando el nombre y la cantidad

select primer_nombre, cantidad, producto
from Transacciones_final as t
right join Personas as p
on t.cedula = p.cedula
where t.cedula = 1073507017

-- 33 crea un vista  de las compreas de andres con cedula 1233490932

create view productos_helver as

select primer_nombre, primer_apellido , producto, cantidad
from Transacciones_final as t
join Personas as p
on t.cedula = p.cedula
where t.cedula = 1233490932

select *
from productos_helver 


--34 consulte la cantidad de productos en comun entre andres y paola-1023924028

create view productos_Maria as

select primer_nombre, primer_apellido, producto, cantidad
from Transacciones_final as t
join Personas as p
on t.cedula = p.cedula
where t.cedula =1023924028

select *
from productos_Maria

--35 consulte la cantoidad de productos comunes entre helver y Maria

select h.primer_nombre ,m.producto as helver,h.producto as maria
from productos_helver as h
inner join productos_Maria as m
on h.producto = m.producto


--36 consulte la cantidad de productos que ha comprado helver y de estos cuales ha comprado maria

select b.producto,
case when sum(a.cantidad) is null then 0
else SUM(a.cantidad)
end as Helver,
SUM(b.cantidad) as maria
from productos_helver as a
right join productos_Maria as b
on a.producto = b.producto
group by b.producto


--37 realice un cruce de registros de helver y paola 

select case when a.producto is null  then b.producto
       else a.producto
	   end as 'producto',
	   case when SUM(a.cantidad) is null then 0
	   else SUM(a.cantidad)
	   end as 'helver',
	   case when SUM(b.producto) is null then 0
	   else SUM(b.producto)
	   end as 'maria'
from productos_helver as a
cross join productos_Maria as b
where b.cantidad is null or a.cantidad is null
group by a.producto , b.producto 


--38 halle el total de pago helver por cada producto
select* 
from productos_helver

select a.producto,cantidad, cantidad*Precio as 'total' 
from productos_helver as a
left join CodigoProductos as b
on a.producto = b.id_producto


--39. Consulte la cantidad de transacciones que se realizaron por cada producto. Únicamente despliegue aquellos que tuvieron 100 o más transacciones.

select*
from CodigoProductos

select*
from Transacciones_final

select a.producto,b.nombre_producto, SUM(a.cantidad) 'total transacciones'
from Transacciones_final as a
join CodigoProductos as b
on a.producto = b.id_producto
group by b.nombre_producto, a.producto
having COUNT(a.cantidad) >=100 


--40. Consulte la cedula, celular, el primer nombre y apellido de los clientes que compraron más de 100 productos.

select b.cedula,b.celular,b.primer_nombre, b.primer_apellido, SUM(a.cantidad) 'total transacciones' 
from Transacciones_final as a
join Personas as b
on a.cedula =b.cedula
group by b.cedula,b.celular,b.primer_nombre,b.primer_apellido
having COUNT(a.cantidad) >= 100

--41. Consulte cédula, celular, primer nombre y apellido de quienes compraron por lo menos un producto no obsequiado.

select*
from Pago

select b.cedula,b.cedula,b.primer_nombre,b.primer_apellido
from Transacciones_final as a
join Personas as b
on a.cedula = b.cedula
where a.Pago <> 4
group by b.cedula,b.cedula,b.primer_nombre,b.primer_apellido

--42. Consulte cédula, celular, primer nombre y apellido de quienes se les obsequio un artículo distinto al 174563.

select b.cedula,celular,primer_nombre,primer_apellido, segundo_apellido 
from Transacciones_final as a
join Personas as b
on a.cedula= b.cedula
where a.producto <> 174563
group by b.cedula,celular,primer_nombre,primer_apellido, segundo_apellido 

--43. Consulte cédula, celular, primer nombre y apellido de todas las personas que han pagado de contado pero que no sean de Bogotá.


select b.cedula,celular,primer_nombre,primer_apellido,segundo_apellido
from Transacciones_final as a
join Personas as b
on a.cedula = b.cedula
where a.Pago = 1 and b.municipio<>11001
group by b.cedula,celular,primer_nombre,primer_apellido,segundo_apellido

/*2. Realice una consulta de las transacciones realizadas por el individuo con cedula 1018484265,
   de los productos 174563 y 345672 y otra del mismo individuo pero con los productos 345672 y 382901. 
   Una estas dos consultas a través de un UNION y UNION ALL y compare los resultados.
   los campos qu deben tener son los siguientes: id,id_transaccion,cedula,fecha,producto*/

select *
from Personas
where cedula = 1018484265
---------------------------------
SELECT id_transacción, cedula, fecha, producto
FROM Transacciones_final
WHERE cedula = 1018484265 AND (producto = 174563 OR producto = 345672);
----------------------------------
SELECT id_transacción, cedula, fecha, producto
FROM Transacciones_final
WHERE cedula = 1018484265 AND (producto = 345672 OR producto = 382901);
-----------------------------------
SELECT id_transacción, cedula, fecha, producto
FROM Transacciones_final
WHERE cedula = 1018484265 AND (producto = 174563 OR producto = 345672)
UNION
SELECT id_transacción, cedula, fecha, producto
FROM Transacciones_final
WHERE cedula = 1018484265 AND (producto = 345672 OR producto = 382901);
----------------------------------
SELECT id_transacción, cedula, fecha, producto
FROM Transacciones_final
WHERE cedula = 1018484265 AND (producto = 174563 OR producto = 345672)
UNION ALL
SELECT id_transacción, cedula, fecha, producto
FROM Transacciones_final
WHERE cedula = 1018484265 AND (producto = 345672 OR producto = 382901);