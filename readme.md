# MODULO DE GESTIÓN DE ALMACEN

## Descripción

Este es un sistema de gestión de inventarios diseñado para optimizar el control de productos en almacenes, gestionar compras y ventas, y administrar permisos de usuarios. El sistema utiliza MySQL como base de datos principal, integrando procedimientos almacenados para mejorar el rendimiento y la seguridad de las transacciones.

La aplicación está desarrollada en Next.js para el backend, utilizando Sequelize como ORM, y permite la interacción con la base de datos a través de una API REST, que se prueba y gestiona con Postman.

## Características Principales

✔ Gestión de Productos → Creación, actualización y eliminación de productos.
✔ Gestión de Inventario → Registro de stock en almacenes con validación de cantidades.
✔ Gestión de Compras → Creación de órdenes de compra y actualización automática del inventario.
✔ Gestión de Ventas → Registro de ventas con afectación directa al inventario.
✔ Control de Usuarios y Roles → Sistema de permisos basado en roles (Administrador, Operador, Vendedor y Auditor).
✔ Reportes Dinámicos → Generación de reportes de inventario, productos por almacén y ventas detalladas.
✔ Base de Datos Optimizada → Uso de procedimientos almacenados y consultas eficientes para mejorar el rendimiento.

## Tecnologías usadas

- **Node.js**: Plataforma para ejecutar JavaScript en el servidor.
- **Express**: Framework para manejar las rutas y solicitudes HTTP.
- **MongoDB**: Base de datos NoSQL para almacenar los datos de los hábitos.
- **Mongoose**: Librería para modelar datos de MongoDB con Node.js.
- **Workbench MySQL**: Bases de datos relacionales.
- **Control de Versiones**: Git & GitHub
- **ORM**: Sequelize.



# Backend:
## Instrucciones para levantar el proyecto

1. **Clonar el repositorio:**

   Clona el repositorio en tu máquina local:

   ```bash
   git clone https://github.com/<tu-usuario>/gestion_inventario.git

2. **Instalar dependencias:**
npm install

3. **Configurar la base de datos (archivo .env):**
MONGO_URI=  <uri de MongodB>
PORT=3001

4. **Levantar el servidor:**
npm start




