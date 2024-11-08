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
