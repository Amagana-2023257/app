drop database if exists chesse;

-- Crear la base de datos "chesse" si no existe
CREATE DATABASE IF NOT EXISTS chesse;

-- Usar la base de datos "chesse"
USE chesse;

-- Tabla de Materia Prima
CREATE TABLE MateriaPrima (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    unidadMedida VARCHAR(20),
    cantidad int,
    familia VARCHAR(45),
    precio decimal(10,2),
    fechaAdquisicion DATE,
    fechaVencimiento DATE,
    PRIMARY KEY(id)
) ENGINE=InnoDB;

-- Tabla de Recetas
CREATE TABLE Recetas (
    id INT AUTO_INCREMENT,
    nombre varchar(60),
    PRIMARY KEY(id)
) ENGINE=InnoDB;

-- Tabla de DetalleReceta
CREATE TABLE DetalleReceta (
    id INT AUTO_INCREMENT ,
    idReceta INT,
    idProducto INT,
    cantidad INT,
    FOREIGN KEY (idReceta) REFERENCES Recetas(id),
    FOREIGN KEY (idProducto) REFERENCES MateriaPrima(id),
    PRIMARY KEY(id)
) ENGINE=InnoDB;

select * from DetalleReceta;


-- Tabla de Productos Finales
CREATE TABLE ProductosFinales (
    id INT AUTO_INCREMENT ,
    producto VARCHAR(20),
    cantidad INT,
    precio DECIMAL(10, 2),
    PRIMARY KEY(id)
) ENGINE=InnoDB;












-- Tabla de Sucursales
CREATE TABLE Sucursales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    ubicacion VARCHAR(100)
) ENGINE=InnoDB;

-- Tabla de Existencias por Sucursal
CREATE TABLE ExistenciasSucursal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sucursalId INT,
    productoId INT,
    materiaPrimaId INT,
    cantidad INT,
    FOREIGN KEY (sucursalId) REFERENCES Sucursales(id),
    FOREIGN KEY (productoId) REFERENCES ProductosFinales(id),
    FOREIGN KEY (materiaPrimaId) REFERENCES MateriaPrima(id)
) ENGINE=InnoDB;

-- Tabla de Usuarios
CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    puesto VARCHAR(20),
    contrasenia VARCHAR(15)
) ENGINE=InnoDB;