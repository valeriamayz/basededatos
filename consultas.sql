1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT codigo_oficina, ciudad FROM oficina;

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT ciudad, telefono FROM oficina WHERE pais LIKE ('Espa%');

3. Devuelve un listado con el email, nombre, apellidos completos (Por ej. Fernandez Alonso,
Mario Alfredo) de los empleados cuyo jefe tiene un código de jefe igual a 7.


SELECT email, nombre, apellido1,apellido2 FROM empleado WHERE codigo_jefe = 2;

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

SELECT puesto, nombre, apellido1,apellido2, email FROM empleado WHERE codigo_jefe IS NULL;

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas.

SELECT nombre, apellido1, apellido2 FROM empleado WHERE puesto != 'Representante Ventas' ;

6. Devuelve un listado con el nombre de todos los clientes españoles.

SELECT nombre_cliente FROM cliente WHERE pais = 'Spain';

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

SELECT DISTINCT estado FROM pedido;

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en
2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
 Utilizando la función YEAR
SELECT DISTINCT codigo_cliente FROM pago WHERE YEAR(fecha_pago) = 2008; 


 Utilizando DATE_FORMAT
SELECT DISTINCT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

 Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01'; 


9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos que no han sido entregados a tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega > fecha_esperada OR fecha_entrega IS NULL; 


10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
 Utilizando la función ADDDATE
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY); 


 Utilizando la función DATEDIFF

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2; 

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT codigo_pedido, codigo_cliente, fecha_pedido, fecha_esperada, fecha_entrega, estado FROM pedido WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = 2009; 


12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año

SELECT codigo_pedido, codigo_cliente, fecha_pedido, fecha_esperada, fecha_entrega, estado FROM pedido
WHERE MONTH(fecha_entrega) = 1;

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor.

SELECT codigo_cliente, forma_pago, id_transaccion, fecha_pago, total FROM pago WHERE forma_pago = 'Paypal' AND YEAR(fecha_pago) = 2008 ORDER BY total DESC; 


14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.

SELECT DISTINCT forma_pago FROM pago;

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta,
mostrando en primer lugar los de mayor precio.

SELECT codigo_producto, nombre, gama, cantidad_en_stock, precio_venta FROM producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC; 


16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.

SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas FROM cliente WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);


17. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de
ventas.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante
FROM cliente c  JOIN empleado e  ON c.codigo_empleado_rep_ventas = e.codigo_empleado; 


18. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas.

SELECT DISTINCT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante FROM cliente c JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN pago p ON c.codigo_cliente = p.codigo_cliente; 


19. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus
representantes de ventas.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante FROM cliente c JOIN empleado e ON 
c.codigo_empleado_rep_ventas = e.codigo_empleado LEFT JOIN pago P ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL; 



20. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad FROM cliente c JOIN empleado e  ON c.codigo_empleado_rep_ventas = e.codigo_empleado JOIN oficina o  ON e.codigo_oficina = o.codigo_oficina JOIN pago p  ON c.codigo_cliente = p.codigo_cliente; 

Consultas de 20 a 40


1. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad FROM cliente c LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente INNER JOIN empleado e  ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE p.codigo_cliente IS NULL; 



2. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.


SELECT DISTINCT o.linea_direccion1, o.linea_direccion2, c. ciudad
FROM oficina o 
INNER JOIN empleado e  ON o.codigo_oficina = e.codigo_oficina 
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
WHERE c.ciudad = 'Fuenlabrada';

3. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la
oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

4. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT e.nombre AS nombre_empleado, e.apellido1
 AS apellido_empleado, j.nombre AS nombre_jefe, j.apellido1 AS apellido_jefe
FROM empleado e
 LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

5. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

SELECT c.nombre_cliente,
FROM cliente c 
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

6. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT c.codigo_cliente, c.nombre_cliente, gp.gama FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido JOIN producto pr ON dp.codigo_producto = pr.codigo_producto JOIN gama_producto gp ON pr.gama = gp.gama GROUP BY c.codigo_cliente, gp.gama;


7. Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.


 SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL;

8. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.


SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE p.codigo_cliente IS NULL;

9. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no
han realizado ningún pedido.

SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente WHERE p.codigo_cliente IS NULL OR pd.codigo_cliente IS NULL;


10. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

SELECT e.codigo_empleado, e.nombre, e.apellido1 FROM empleado e WHERE e.codigo_oficina IS NULL; 

11. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

SELECT e.codigo_empleado, e.nombre, e.apellido1 FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE c.codigo_empleado_rep_ventas IS NULL;


12. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no
tienen un cliente asociado.

SELECT e.codigo_empleado, e.nombre, e.apellido1 FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE e.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL;


13. Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT p.codigo_producto, p.nombre FROM producto p LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto WHERE dp.codigo_producto IS NULL;


14. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto de
la gama Frutales.

SELECT o.codigo_oficina, o.ciudad, o.pais FROM oficina o LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto WHERE pr.gama = 'Frutales' AND e.codigo_empleado IS NULL;



15. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado
ningún pago.

SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente WHERE pg.codigo_cliente IS NULL;


16. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado.

SELECT e.codigo_empleado, e.nombre, e.apellido1, j.nombre AS nombre_jefe, j.apellido1 AS apellido_jefe FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado WHERE c.codigo_cliente IS NULL;


17. ¿Cuántos empleados hay en la compañía?

SELECT COUNT(*)AS cantidad_empleados FROM empleado;

18. ¿Cuántos clientes tiene cada país?

SELECT COUNT(*)AS cantidad_clientes FROM cliente GROUP BY pais;

19. ¿Cuál fue el pago medio en 2009?

SELECT AVG(total)AS forma  FROM pago WHERE fecha_pago =2009;

20. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
número de pedidos.

SELECT estado, COUNT(*) AS cantidad_pedidos FROM pedido GROUP BY estado ORDER BY cantidad_pedidos DESC;

Consultas De 40-60

1. Calcula el precio de venta del producto más caro y más barato en una misma consulta.

SELECT MAX(precio_venta) AS precio_mas_caro,MIN(precio_venta) AS precio_mas_barato FROM producto;

2. Calcula el número de clientes que tiene la empresa.

SELECT COUNT(*)AS cantidad_clientes FROM cliente;

3. ¿Cuántos clientes tiene la ciudad de Madrid?

SELECT COUNT(*)AS clientes_madrid FROM cliente WHERE ciudad = 'Madrid';

4. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

SELECT ciudad, COUNT(*)AS numero_clientes FROM cliente WHERE ciudad LIKE 'M%' GROUP BY ciudad;

5. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
cada uno.

SELECT e.nombre, e.apellido1, COUNT(c.codigo_cliente) AS numero_clientes FROM empleado e JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas GROUP BY e.codigo_empleado;


6. Calcula el número de clientes que no tiene asignado representante de ventas.

SELECT COUNT(*)AS clientes_sin_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NULL;

7. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
deberá mostrar el nombre y los apellidos de cada cliente.

SELECT c.nombre_cliente, c.apellido_contacto, MIN(p.fecha_pago) AS primer_pago, MAX(p.fecha_pago) AS ultimo_pago FROM cliente c JOIN pago p ON c.codigo_cliente = p.codigo_cliente GROUP BY c.codigo_cliente;


8. Calcula el número de productos diferentes que hay en cada uno de los pedidos.

SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS productos_diferentes FROM detalle_pedido GROUP BY codigo_pedido;


9. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los
pedidos.

SELECT codigo_pedido, SUM(cantidad) AS cantidad_total FROM detalle_pedido GROUP BY codigo_pedido;


10. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se
han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades
vendidas.

SELECT p.nombre, SUM(dp.cantidad) AS total_unidades_vendidas
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto GROUP BY p.codigo_producto ORDER BY total_unidades_vendidas DESC LIMIT 20;



11. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA
y el total facturado. La base imponible se calcula sumando el coste del producto por el número
de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el
total la suma de los dos campos anteriores.

SELECT SUM(dp.precio_unidad * dp.cantidad) AS base_imponible,
       SUM(dp.precio_unidad * dp.cantidad) * 0.21 AS iva,
       SUM(dp.precio_unidad * dp.cantidad) * 1.21 AS total_facturado
FROM detalle_pedido dp;


12. La misma información que en la pregunta anterior, pero agrupada por código de producto.

SELECT dp.codigo_producto,
       SUM(dp.precio_unidad * dp.cantidad) AS base_imponible,
       SUM(dp.precio_unidad * dp.cantidad) * 0.21 AS iva,
       SUM(dp.precio_unidad * dp.cantidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
GROUP BY dp.codigo_producto;


13. La misma información que en la pregunta anterior, pero agrupada por código de producto
filtrada por los códigos que empiecen por OR.

SELECT dp.codigo_producto,
       SUM(dp.precio_unidad * dp.cantidad) AS base_imponible,
       SUM(dp.precio_unidad * dp.cantidad) * 0.21 AS iva,
       SUM(dp.precio_unidad * dp.cantidad) * 1.21 AS total_facturado
FROM detalle_pedido dp
WHERE dp.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;


14. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará
el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

SELECT p.nombre, SUM(dp.cantidad) AS unidades_vendidas,
       SUM(dp.precio_unidad * dp.cantidad) AS total_facturado,
       SUM(dp.precio_unidad * dp.cantidad) * 1.21 AS total_facturado_con_iva
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.codigo_producto
HAVING total_facturado > 3000;


15. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente, limite_credito
FROM cliente
ORDER BY limite_credito DESC
LIMIT 1;


16. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre, precio_venta
FROM producto
ORDER BY precio_venta DESC
LIMIT 1;


17. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que
tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a
partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código del producto,
puede obtener su nombre fácilmente.)

SELECT p.nombre, SUM(dp.cantidad) AS total_unidades_vendidas
FROM producto p
JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY p.codigo_producto
ORDER BY total_unidades_vendidas DESC
LIMIT 1;


18. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin
utilizar INNER JOIN).

SELECT c.codigo_cliente, c.nombre_cliente
FROM cliente c WHERE c.limite_credito > (SELECT COALESCE(SUM(p.total), 0) FROM pago p WHERE p.codigo_cliente = c.codigo_cliente);

SELECT nombre_cliente, COALESCE(limite_credito, 0) AS limite_credito
FROM cliente;


19. Devuelve el producto que más unidades tiene en stock.

SELECT nombre, cantidad_en_stock
FROM producto
ORDER BY cantidad_en_stock DESC
LIMIT 1;


20. Devuelve el producto que menos unidades tiene en stock.

SELECT nombre, cantidad_en_stock
FROM producto
ORDER BY cantidad_en_stock ASC
LIMIT 1;


Consultas de 60 a 80

1. Listar los nombres de los clientes que tienen asignado el representante Lorena Pauxton
(suponiendo que no puede haber representantes con el mismo nombre).

SELECT c.nombre_cliente, e.nombre AS 'nombre_rep', e.apellido1 AS 'apellido_rep' FROM cliente c JOIN empleado e 
ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE e.nombre = 'Lorena' AND e.apellido1 ='Paxton';

2. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados
que tiene.

SELECT o.ciudad, e.nombre AS 'nombre_empleado', e.apellido1 AS 'apellido_empleado' FROM oficina o JOIN  empleado e ON e.codigo_oficina = o.codigo_oficina;

3. Listar a los vendedores que no trabajan en oficinas dirigidas por el empleado 108.

SELECT nombre, apellido1 FROM empleado WHERE codigo_jefe != 108;

4. Listar los productos (idfab, idproducto y descripción) para los cuales no se ha recibido ningún
pedido de 25000 o más.

SELECT p.codigo_producto, p.nombre, p.descripcion FROM producto p  WHERE p.codigo_producto NOT IN (SELECT dp.codigo_producto FROM detalle_pedido dp WHERE dp.precio_unidad * dp.cantidad >= 25000);

5. Listar los clientes asignados a Ana Bustamante que no han remitido un pedido superior a 3000 pts.

SELECT c.nombre_cliente
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE e.nombre = 'Ana' AND e.apellido1 = 'Bustamante'
AND c.codigo_cliente NOT IN (
    SELECT codigo_cliente
    FROM pedido
    WHERE codigo_pedido IN (
        SELECT codigo_pedido
        FROM detalle_pedido
        WHERE precio_unidad * cantidad > 3000
    )
);


6. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el
número de teléfono de la oficina del representante de ventas, de aquellos clientes que no
hayan realizado ningún pago.

SELECT c.nombre_cliente, e.nombre AS nombre_rep, e.apellido1 AS apellido_rep, o.telefono
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente NOT IN (
    SELECT codigo_cliente
    FROM pago
);


7. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer
apellido de su representante de ventas y la ciudad donde está su oficina.

SELECT c.nombre_cliente, e.nombre AS nombre_rep, e.apellido1 AS apellido_rep, o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;


8. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no
sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT codigo_empleado_rep_ventas
    FROM cliente
);


9. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto
Soria.

SELECT e.nombre, e.apellido1, e.email
FROM empleado e
WHERE e.codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);


10. Devuelve el nombre del cliente con mayor límite de crédito. (utilizar ALL, ANY)

SELECT nombre_cliente
FROM cliente
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);


11. Devuelve el nombre del producto que tenga el precio de venta más caro. (utilizar ALL, ANY)

SELECT nombre
FROM producto
WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);


12. Devuelve el producto que menos unidades tiene en stock. (utilizar ALL, ANY)

SELECT nombre
FROM producto
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM producto);


13. Devuelve el nombre, apellido1 y cargo de los empleados que no representan a ningún cliente.
(Utilizar IN, NOT IN)

SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);


14. Devuelve un listado que muestre solamente a los 
clientes que no han realizado ningún pago.
(Utilizar IN, NOT IN)

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);


15. Devuelve un listado que muestre solamente a los clientes que sí han realizado algún pago.
(Utilizar IN, NOT IN)


SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);


16. Devuelve un listado de los productos que nunca han aparecido en un pedido. (Utilizar IN, NOT
IN)

SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);


17. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no
sean representante de ventas de ningún cliente.(Utilizar IN, NOT IN)

SELECT e.nombre, e.apellido1, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);


18. Devuelve un listado que muestre solamente a los clientes que no han realizado ningún pago.
(Utilizar EXISTS y NOT EXISTS)

SELECT nombre_cliente
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);


19. Devuelve un listado que muestre solamente a los clientes que sí han realizado algún pago.
(Utilizar EXISTS y NOT EXISTS)

SELECT nombre_cliente
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM pago p
    WHERE p.codigo_cliente = c.codigo_cliente
);


20. Devuelve un listado de los productos que nunca han aparecido en un pedido. (Utilizar EXISTS y
NOT EXISTS)
SELECT nombre
FROM producto p
WHERE NOT EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    WHERE dp.codigo_producto = p.codigo_producto
);


21. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados
alfabéticamente de menor a mayor.

SELECT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) = 2008
ORDER BY c.nombre_cliente ASC;

