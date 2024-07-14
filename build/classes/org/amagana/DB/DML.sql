 
-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE USUARIOO */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
-- LOGIN
DELIMITER $$
CREATE PROCEDURE sp_login(IN _nombre VARCHAR(20), IN _contrasenia VARCHAR(15))
BEGIN
	SELECT * FROM Usuario
    WHERE nombre = _nombre AND contrasenia = _contrasenia;
END $$
DELIMITER ;

-- CREAR
DELIMITER $$
CREATE PROCEDURE sp_crear_usuario 
(
    IN _nombre VARCHAR(20),
    IN _apellido VARCHAR(20),
    IN _puesto VARCHAR(20),
    IN _contrasenia VARCHAR(15)
)
BEGIN
    INSERT INTO Usuario (nombre, apellido, puesto, contrasenia)
    VALUES (_nombre, _apellido, _puesto, _contrasenia);
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_insertar_materia_prima */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_insertar_materia_prima (
    IN _nombre VARCHAR(50),
    IN _unidadMedida VARCHAR(20),
    IN _cantidad INT,
    IN _familia VARCHAR(45),
    IN _precio DECIMAL(10,2),
    IN _fechaAdquisicion DATE,
    IN _fechaVencimiento DATE
)
BEGIN
    INSERT INTO MateriaPrima (nombre, unidadMedida, cantidad, familia, precio, fechaAdquisicion, fechaVencimiento)
    VALUES (_nombre, _unidadMedida, _cantidad, _familia, _precio, _fechaAdquisicion, _fechaVencimiento);
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_obtener_materia_prima_por_id */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_obtener_materia_prima_por_id (IN _id INT)
BEGIN
    SELECT * FROM MateriaPrima WHERE id = _id;
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_actualizar_materia_prima */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
DELIMITER $$

CREATE PROCEDURE sp_actualizar_materia_prima (
    IN _id INT,
    IN _nombre VARCHAR(50),
    IN _unidadMedida VARCHAR(20),
    IN _cantidad INT,
    IN _familia VARCHAR(45),
    IN _precio DECIMAL(10,2),
    IN _fechaAdquisicion DATE,
    IN _fechaVencimiento DATE
)
BEGIN
    UPDATE MateriaPrima
    SET nombre = _nombre,
        unidadMedida = _unidadMedida,
        cantidad = _cantidad,
        familia = _familia,
        precio = _precio,
        fechaAdquisicion = _fechaAdquisicion,
        fechaVencimiento = _fechaVencimiento
    WHERE id = _id;
END $$

DELIMITER ;


-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_eliminar_materia_prima */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_eliminar_materia_prima (IN _id INT)
BEGIN
    DELETE FROM MateriaPrima WHERE id = _id;
END $$
DELIMITER ;


-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_listar_materias_primas */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/



DELIMITER $$
CREATE PROCEDURE sp_listar_materias_primas()
BEGIN
    SELECT id, nombre, unidadMedida, cantidad, familia, precio, fechaAdquisicion, fechaVencimiento
    FROM MateriaPrima;
END $$
DELIMITER ;
call sp_listar_materias_primas();









DELIMITER $$
CREATE PROCEDURE sp_listar_proctos_finales()
BEGIN
    SELECT id, producto, cantidad, precio
    FROM ProductosFinales;
END $$
DELIMITER ;

call sp_listar_proctos_finales();

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_insertar_producto_final */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_insertar_producto_final (
    IN _producto VARCHAR(20),
    IN _cantidad INT,
    IN _precio DECIMAL(10, 2)
)
BEGIN
    INSERT INTO ProductosFinales (producto, cantidad, precio)
    VALUES (_producto, _cantidad, _precio);
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_obtener_producto_final_por_id */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_obtener_producto_final_por_id (IN _id INT)
BEGIN
    SELECT * FROM ProductosFinales WHERE id = _id;
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_actualizar_producto_final */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
DELIMITER $$
CREATE PROCEDURE sp_actualizar_producto_final (
    IN _id INT,
    IN _nuevoProducto VARCHAR(20),
    IN _nuevaCantidad INT
)
BEGIN
    UPDATE ProductosFinales
    SET producto = _nuevoProducto, cantidad = _nuevaCantidad
    WHERE id = _id;
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_eliminar_producto_final */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_eliminar_producto_final (IN _id INT)
BEGIN
    DELETE FROM ProductosFinales WHERE id = _id;
END $$
DELIMITER ;











-- PROCEDIMIENTO ALMACENADO: Insertar una nueva receta
DELIMITER $$
CREATE PROCEDURE sp_insertar_receta (
    IN _nombreReceta VARCHAR(60)
)
BEGIN
    INSERT INTO Recetas (nombre)
    VALUES (_nombreReceta);
END $$
DELIMITER ;


-- PROCEDIMIENTO ALMACENADO: Obtener una receta por su ID
DELIMITER $$
CREATE PROCEDURE sp_obtener_receta_por_id (IN _id INT)
BEGIN
    -- Seleccionar la receta cuyo ID coincide con el parámetro proporcionado
    SELECT * FROM Recetas WHERE id = _id;
END $$
DELIMITER ;


-- PROCEDIMIENTO ALMACENADO: Actualizar una receta por su ID
DELIMITER $$
CREATE PROCEDURE sp_actualizar_receta (
    IN _id INT,
    IN _nombre VARCHAR(60),
    IN _nuevaMateriaPrima TEXT
)
BEGIN
    -- Actualizar la receta cuyo ID coincide con el parámetro proporcionado
    UPDATE Recetas
    SET nombre = _nombre,
        materiaPrima = _nuevaMateriaPrima
    WHERE id = _id;
END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_eliminar_receta (IN _id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback si ocurre algún error
        ROLLBACK;
    END;

    -- Iniciar transacción
    START TRANSACTION;

    -- Eliminar detalles de receta relacionados
    DELETE FROM DetalleReceta WHERE idReceta = _id;

    -- Eliminar la receta cuyo ID coincide con el parámetro proporcionado
    DELETE FROM Recetas WHERE id = _id;

    -- Confirmar la transacción
    COMMIT;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_listar_recetas()
BEGIN
    SELECT id, nombre
    FROM Recetas;
END $$

DELIMITER ;

-- Creación del procedimiento almacenado para insertar detalles de receta
DELIMITER $$

CREATE PROCEDURE sp_insertar_detalle_receta (
    IN p_idReceta INT,
    IN p_idProducto INT,
    IN p_cantidad INT
)
BEGIN
    -- Insertar detalle de receta
    INSERT INTO DetalleReceta (idReceta, idProducto, cantidad)
    VALUES (p_idReceta, p_idProducto, p_cantidad);
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE sp_buscar_receta_por_nombre(
    IN _nombre VARCHAR(60)
)
BEGIN
    SELECT *
    FROM Recetas
    WHERE nombre = _nombre;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE sp_mostrar_detalles_receta(IN idRecetaParam INT)
BEGIN
    -- Consulta para seleccionar los detalles de receta que corresponden al idRecetaParam
    SELECT dr.id, dr.idReceta, dr.idProducto, dr.cantidad
    FROM DetalleReceta dr
    WHERE dr.idReceta = idRecetaParam;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_restar_cantidad_materia_prima(
    IN idMateriaPrima INT,
    IN cantidadRestar INT
)
BEGIN
    DECLARE cantidadActual INT;

    -- Obtener la cantidad actual de la materia prima
    SELECT cantidad INTO cantidadActual
    FROM MateriaPrima
    WHERE id = idMateriaPrima;

    -- Restar la cantidad especificada
    IF cantidadActual IS NOT NULL THEN
        UPDATE MateriaPrima
        SET cantidad = cantidadActual - cantidadRestar
        WHERE id = idMateriaPrima;
    END IF;
    
END $$

DELIMITER ;














-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_insertar_sucursal */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_insertar_sucursal (
    IN _nombre VARCHAR(50),
    IN _ubicacion VARCHAR(100)
)
BEGIN
    INSERT INTO Sucursales (nombre, ubicacion)
    VALUES (_nombre, _ubicacion);
END $$
DELIMITER ;


-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_obtener_sucursal_por_id */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
DELIMITER $$
CREATE PROCEDURE sp_obtener_sucursal_por_id (IN _id INT)
BEGIN
    SELECT * FROM Sucursales WHERE id = _id;
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_actualizar_sucursal */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_actualizar_sucursal (
    IN _id INT,
    IN _nuevoNombre VARCHAR(50),
    IN _nuevaUbicacion VARCHAR(100)
)
BEGIN
    UPDATE Sucursales
    SET nombre = _nuevoNombre, ubicacion = _nuevaUbicacion
    WHERE id = _id;
END $$
DELIMITER ;


-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_eliminar_sucursal */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_eliminar_sucursal (IN _id INT)
BEGIN
    DELETE FROM Sucursales WHERE id = _id;
END $$
DELIMITER ;


-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_insertar_existencia */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_insertar_existencia (
    IN _sucursalId INT,
    IN _productoId INT,
    IN _materiaPrimaId INT,
    IN _cantidad INT
)
BEGIN
    INSERT INTO ExistenciasSucursal (sucursalId, productoId, materiaPrimaId, cantidad)
    VALUES (_sucursalId, _productoId, _materiaPrimaId, _cantidad);
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_obtener_existencia_por_id */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_obtener_existencia_por_id (IN _id INT)
BEGIN
    SELECT * FROM ExistenciasSucursal WHERE id = _id;
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_actualizar_existencia */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_actualizar_existencia (
    IN _id INT,
    IN _nuevoProductoId INT,
    IN _nuevaCantidad INT
)
BEGIN
    UPDATE ExistenciasSucursal
    SET productoId = _nuevoProductoId, cantidad = _nuevaCantidad
    WHERE id = _id;
END $$
DELIMITER ;

-- //*/*/*/*/*/*/*/*/*/*/*/*/*/*/* PROCEDIMIENTOS ALMACENADOS DE sp_eliminar_existencia */*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

DELIMITER $$
CREATE PROCEDURE sp_eliminar_existencia (IN _id INT)
BEGIN
    DELETE FROM ExistenciasSucursal WHERE id = _id;
END $$
DELIMITER ;



CALL sp_insertar_materia_prima('Harina', 'kg', 100, 'Ingredientes', 3.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Agua', 'litro', 200, 'Ingredientes', 0.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Levadura', 'sobre', 50, 'Ingredientes', 1.49, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Aceite', 'litro', 80, 'Ingredientes', 5.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Azúcar', 'kg', 120, 'Ingredientes', 2.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Sal', 'kg', 150, 'Ingredientes', 1.49, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Tomate', 'unidad', 60, 'Vegetales', 0.79, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Cebolla', 'unidad', 70, 'Vegetales', 0.69, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Chile Pimiento', 'unidad', 40, 'Vegetales', 1.29, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Margarina', 'unidad', 50, 'Ingredientes', 3.49, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Queso', 'kg', 90, 'Ingredientes', 7.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Cajas', 'unidad', 200, 'Empaques', 0.50, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Servilletas', 'paquete', 100, 'Empaques', 1.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Pimienta', 'unidad', 30, 'Especias', 2.49, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Picante', 'botella', 40, 'Salsas', 1.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Peperoni', 'kg', 50, 'Ingredientes', 8.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Jamón', 'kg', 60, 'Ingredientes', 9.99, '2024-06-14', '2025-06-14');
CALL sp_insertar_materia_prima('Piña', 'unidad', 30, 'Frutas', 1.49, '2024-06-14', '2025-06-14');

CALL sp_insertar_sucursal('Sucursal A', 'Ubicación A');
CALL sp_insertar_sucursal('Sucursal B', 'Ubicación B');

CALL sp_crear_usuario('a', 'Perez', 'Administrador', '1');


set global time_zone = '-6:00';
