# Sistema de Gestión Empresarial - Spring Boot

Sistema integral de gestión empresarial desarrollado con Spring Boot 3, PostgreSQL y autenticación JWT. Incluye sistema de permisos granulares, módulos completos de ventas, inventario, cotizaciones, asignaciones y metas de ventas con interfaz web moderna.

## 📋 Tabla de Contenidos

- [Autores](#autores)
- [Características Principales](#características-principales)
- [Descripción](#descripción)
- [Tecnologías Utilizadas](#tecnologías-utilizadas)
- [Arquitectura](#arquitectura)
- [Sistema de Autenticación y Permisos](#sistema-de-autenticación-y-permisos)
- [Modelos de Datos](#modelos-de-datos)
- [Endpoints API](#endpoints-api)
- [Instalación y Configuración](#instalación-y-configuración)
- [Uso](#uso)
- [Avances del Proyecto](#avances-del-proyecto)

## 👥 Autores

- **Carlos Andrés Garzón Tafur**
- **Daniel Andrés Serrato Morales**
- **Wilkerson Zabala Urueña**

## ✨ Características Principales

- 🔐 **Autenticación JWT** con tokens Bearer
- 👥 **Sistema de permisos granulares** basado en roles y permisos específicos
- 📊 **21 módulos completos** con CRUD, filtros y búsquedas
- 💼 **Gestión de ventas** (órdenes, facturas, cotizaciones)
- 📦 **Control de inventario** con asignaciones a empleados
- 🎯 **Metas de ventas** por empleado, sucursal y período
- 🌐 **Interfaz web responsive** con Bootstrap 5
- 🔄 **API REST completa** para todos los módulos
- ⚡ **49 permisos configurables** (READ, WRITE, DELETE por módulo)

## 📖 Descripción

Sistema integral de gestión empresarial que permite administrar usuarios, organizaciones, sucursales, inventario, ventas, facturación, cotizaciones, asignaciones de equipos y metas de ventas. Implementa un robusto sistema de autenticación JWT y autorización basada en permisos granulares, permitiendo control de acceso específico para cada módulo y operación del sistema.

## 🛠️ Tecnologías Utilizadas

### Backend
- **Java 17**
- **Spring Boot 3.5.6**
  - Spring Data JPA
  - Spring Web
  - Spring Security 6
  - Spring Boot DevTools
- **JWT (JSON Web Tokens)** - Autenticación stateless
- **BCrypt** - Encriptación de contraseñas
- **Hibernate 6.6.29** (ORM)
- **PostgreSQL 17.6** (Base de datos)
- **HikariCP** (Connection Pooling)
- **Maven** (Gestión de dependencias)

### Frontend
- **Thymeleaf** (Motor de plantillas)
- **Bootstrap 5.3.0** (Framework CSS)
- **Bootstrap Icons 1.10.0**
- **JavaScript Vanilla** (Fetch API para comunicación REST)

### Herramientas
- **Maven Wrapper** (mvnw)
- **Git** (Control de versiones)

## 🏗️ Arquitectura

El proyecto sigue una arquitectura en capas con Spring Security:

```
demo/
├── src/
│   ├── main/
│   │   ├── java/com/example/demo/
│   │   │   ├── config/           # Configuración (Security, CORS)
│   │   │   ├── controller/       # 23 Controladores REST
│   │   │   ├── model/            # 20 Entidades JPA
│   │   │   ├── repository/       # 20 Repositorios JPA
│   │   │   ├── service/          # Servicios (Auth, UserDetails)
│   │   │   ├── security/         # JWT Utils, Filters
│   │   │   ├── exception/        # Manejo global de excepciones
│   │   │   └── DemoApplication.java
│   │   └── resources/
│   │       ├── templates/        # 21 Vistas HTML
│   │       ├── static/           # CSS, JS, imágenes
│   │       │   └── js/           # auth-guard.js (JWT client)
│   │       ├── application.properties
│   │       └── data.sql
│   └── test/
├── sql/
│   └── insert_permissions.sql    # Script de permisos
├── pom.xml
└── README.md
```

## 🔐 Sistema de Autenticación y Permisos

### Arquitectura de Seguridad

El sistema implementa autenticación JWT con permisos granulares:

**Flujo de Autenticación:**
1. Usuario envía credenciales a `/api/auth/login`
2. Backend valida y genera token JWT con permisos
3. Cliente almacena token en localStorage
4. Todas las peticiones incluyen header `Authorization: Bearer <token>`
5. JwtRequestFilter valida token y carga permisos en SecurityContext
6. @PreAuthorize verifica permisos específicos en cada endpoint

**Estructura de Permisos:**
```
Usuario → Rol → Permisos
         ↓
    role_permission (tabla intermedia)
         ↓
    permission (49 permisos)
```

### Permisos Disponibles

**Por Módulo (43 permisos):**
- `READ_*` (17): Visualizar datos
- `WRITE_*` (14): Crear y modificar
- `DELETE_*` (12): Eliminar registros

**Permisos Especiales (6):**
- `MANAGE_USERS`: Gestión completa de usuarios
- `MANAGE_ROLES`: Gestión de roles
- `ADMIN_ALL`: Acceso total al sistema
- `APPROVE_ORDERS`: Aprobar órdenes de venta
- `READ_REPORTS`: Ver reportes
- `WRITE_REPORTS`: Crear reportes

### Ejemplo de Uso en Controllers

```java
@PreAuthorize("hasAuthority('READ_EMPLOYEES')")
@GetMapping
public ResponseEntity<List<Employee>> getAllEmployees() { }

@PreAuthorize("hasAuthority('WRITE_EMPLOYEES')")
@PostMapping
public ResponseEntity<Employee> createEmployee(@RequestBody Employee employee) { }

@PreAuthorize("hasAuthority('DELETE_EMPLOYEES')")
@DeleteMapping("/{id}")
public ResponseEntity<Void> deleteEmployee(@PathVariable Long id) { }
```

## 📊 Modelos de Datos

### Entidades Principales

#### 1. **User** (Usuarios)
- Gestión de usuarios del sistema
- Relación con Role (Rol de usuario)
- Campos: id, username, email, password, roleId, isActive, createdAt, updatedAt

#### 2. **Role** (Roles)
- Roles del sistema (Administrador, Gerente, Vendedor, Cajero, Almacenero)
- Relación OneToMany con User
- Campos: id, name, description

#### 3. **State** (Estados/Departamentos)
- Divisiones administrativas principales
- Relación OneToMany con City
- Campos: id, name, code

#### 4. **City** (Ciudades)
- Municipios o ciudades
- Relación ManyToOne con State
- Campos: id, name, stateId, code

#### 5. **Organization** (Organizaciones)
- Entidades empresariales principales
- Relación OneToMany con Branch
- Campos: id, name, nit, email, phone, address, cityId, createdAt, updatedAt

#### 6. **Branch** (Sucursales)
- Sucursales de las organizaciones
- Relación ManyToOne con Organization y City
- Campos: id, name, organizationId, phone, address, cityId, createdAt, updatedAt

#### 7. **Person** (Personas)
- Registro de personas (clientes, empleados)
- Relación con City
- Campos: id, firstName, lastName, documentType, documentNumber, email, phone, address, cityId

#### 8. **Employee** (Empleados)
- Empleados de las sucursales
- Relación con Person, Branch y Role
- Campos: id, personId, branchId, roleId, hireDate, salary, isActive

#### 9. **Brand** (Marcas)
- Marcas de productos
- Relación OneToMany con InventoryItem
- Campos: id, name, description

#### 10. **ItemCategory** (Categorías de Items)
- Categorías de inventario
- Relación OneToMany con InventoryItem
- Campos: id, name, description

#### 11. **InventoryItem** (Items de Inventario)
- Productos en inventario
- Relaciones con Brand, ItemCategory y Branch
- Campos: id, name, description, brandId, categoryId, price, stock, branchId, createdAt, updatedAt

#### 12. **SalesOrder** (Órdenes de Venta)
- Órdenes de venta realizadas
- Relaciones con Employee (vendedor), Person (cliente), Branch
- Campos: id, sellerId, customerId, branchId, totalAmount, orderDate, status

#### 13. **SalesOrderItem** (Items de Orden de Venta)
- Detalles de productos en órdenes de venta
- Relaciones con SalesOrder e InventoryItem
- Campos: id, orderId, itemId, quantity, unitPrice, subtotal

#### 14. **Invoice** (Facturas)
- Facturas generadas
- Relaciones con SalesOrder, Employee (cajero), Person (cliente)
- Campos: id, orderId, cashierId, customerId, totalAmount, invoiceDate, paymentMethod

#### 15. **InvoiceItem** (Items de Factura)
- Detalles de productos en facturas
- Relaciones con Invoice e InventoryItem
- Campos: id, invoiceId, itemId, quantity, unitPrice, subtotal

#### 16. **Permission** (Permisos)
- Permisos granulares del sistema
- Base para control de acceso
- Campos: id, name

#### 17. **RolePermission** (Rol-Permiso)
- Tabla intermedia entre Role y Permission
- Asignación de permisos a roles
- Campos: roleId, permissionId

#### 18. **Assignment** (Asignaciones)
- Asignación de equipos/items a empleados
- Estados: ACTIVE, RETURNED, LOST
- Campos: id, employeeId, itemId, quantity, assignedDate, returnDate, status, condition, notes

#### 19. **Quote** (Cotizaciones)
- Cotizaciones de venta
- Relaciones con Employee y Customer
- Campos: id, customerName, date, total, employeeId, createdAt

#### 20. **QuotationLine** (Líneas de Cotización)
- Detalles de líneas en cotizaciones
- Relaciones con Quote e InventoryItem
- Campos: id, quoteId, description, quantity, unitPrice, subtotal

#### 21. **QuoteItem** (Items de Cotización)
- Items específicos en cotizaciones
- Relaciones con Quote e InventoryItem
- Campos: id, quoteId, itemId, quantity, unitPrice, subtotal

#### 22. **SalesGoal** (Metas de Ventas)
- Metas de ventas por período
- Tipos: EMPLOYEE_GOAL, BRANCH_GOAL
- Períodos: MONTHLY, QUARTERLY, YEARLY
- Campos: id, goalType, targetAmount, actualAmount, period, startDate, endDate, employeeId, branchId, status

### Relaciones Clave

- **User** → **Role**: ManyToOne
- **State** → **City**: OneToMany
- **Organization** → **Branch**: OneToMany
- **Person** → **Employee**: OneToOne
- **Branch** → **Employee**: OneToMany
- **Branch** → **InventoryItem**: OneToMany
- **SalesOrder** → **SalesOrderItem**: OneToMany
- **Invoice** → **InvoiceItem**: OneToMany
- **Role** → **Permission**: ManyToMany (mediante RolePermission)
- **Employee** → **Assignment**: OneToMany
- **Quote** → **QuotationLine**: OneToMany
- **Quote** → **QuoteItem**: OneToMany

## 🔌 Endpoints API

### Autenticación (Públicos)
- `POST /api/auth/login` - Login (retorna JWT + permisos)
- `POST /api/auth/register` - Registro de usuario

### Usuarios (`MANAGE_USERS`)
- `GET /api/users` - Listar usuarios
- `GET /api/users/{id}` - Obtener usuario
- `POST /api/users` - Crear usuario
- `PUT /api/users/{id}` - Actualizar usuario
- `DELETE /api/users/{id}` - Eliminar usuario

### Roles (`MANAGE_ROLES`)
- `GET /api/roles` - Listar roles
- `GET /api/roles/{id}` - Obtener rol
- `GET /api/roles/name/{name}` - Buscar por nombre
- `POST /api/roles` - Crear rol
- `PUT /api/roles/{id}` - Actualizar rol
- `DELETE /api/roles/{id}` - Eliminar rol

### Permisos (`ADMIN_ALL`)
- `GET /api/permissions` - Listar permisos
- `GET /api/role-permissions` - Obtener permisos por rol

### Empleados (`READ_EMPLOYEES`, `WRITE_EMPLOYEES`, `DELETE_EMPLOYEES`)
- `GET /api/employees` - Listar empleados
- `GET /api/employees/{id}` - Obtener empleado
- `GET /api/employees/email/{email}` - Buscar por email
- `GET /api/employees/branch/{branchId}` - Por sucursal
- `GET /api/employees/status/{status}` - Por estado
- `POST /api/employees` - Crear empleado
- `PUT /api/employees/{id}` - Actualizar empleado
- `DELETE /api/employees/{id}` - Eliminar empleado

### Estados (`READ_STATES`, `WRITE_STATES`, `DELETE_STATES`)
- `GET /api/states` - Listar estados
- `GET /api/states/{id}` - Obtener estado
- `POST /api/states` - Crear estado
- `PUT /api/states/{id}` - Actualizar estado
- `DELETE /api/states/{id}` - Eliminar estado

### Ciudades (`READ_CITIES`, `WRITE_CITIES`, `DELETE_CITIES`)
- `GET /api/cities` - Listar ciudades
- `GET /api/cities/{id}` - Obtener ciudad
- `GET /api/cities/code/{code}` - Por código
- `GET /api/cities/state/{stateId}` - Por estado
- `POST /api/cities` - Crear ciudad
- `PUT /api/cities/{id}` - Actualizar ciudad
- `DELETE /api/cities/{id}` - Eliminar ciudad

### Organizaciones (`READ_ORGANIZATIONS`, `WRITE_ORGANIZATIONS`, `DELETE_ORGANIZATIONS`)
- `GET /api/organizations` - Listar organizaciones
- `GET /api/organizations/{id}` - Obtener organización
- `GET /api/organizations/tax-id/{taxId}` - Por NIT
- `POST /api/organizations` - Crear organización
- `PUT /api/organizations/{id}` - Actualizar organización
- `DELETE /api/organizations/{id}` - Eliminar organización

### Sucursales (`READ_BRANCHES`, `WRITE_BRANCHES`, `DELETE_BRANCHES`)
- `GET /api/branches` - Listar sucursales
- `GET /api/branches/{id}` - Obtener sucursal
- `GET /api/branches/organization/{orgId}` - Por organización
- `GET /api/branches/city/{cityId}` - Por ciudad
- `POST /api/branches` - Crear sucursal
- `PUT /api/branches/{id}` - Actualizar sucursal
- `DELETE /api/branches/{id}` - Eliminar sucursal

### Personas (`READ_PERSONS`, `WRITE_PERSONS`, `DELETE_PERSONS`)
- `GET /api/persons` - Listar personas
- `GET /api/persons/{id}` - Obtener persona
- `GET /api/persons/document/{docNumber}` - Por documento
- `GET /api/persons/city/{cityId}` - Por ciudad
- `POST /api/persons` - Crear persona
- `PUT /api/persons/{id}` - Actualizar persona

### Marcas (`READ_BRANDS`, `WRITE_BRANDS`, `DELETE_BRANDS`)
- `GET /api/brands` - Listar marcas
- `GET /api/brands/{id}` - Obtener marca
- `GET /api/brands/name/{name}` - Por nombre
- `POST /api/brands` - Crear marca
- `PUT /api/brands/{id}` - Actualizar marca
- `DELETE /api/brands/{id}` - Eliminar marca

### Categorías (`READ_CATEGORIES`, `WRITE_CATEGORIES`, `DELETE_CATEGORIES`)
- `GET /api/categories` - Listar categorías
- `GET /api/categories/{id}` - Obtener categoría
- `POST /api/categories` - Crear categoría
- `PUT /api/categories/{id}` - Actualizar categoría
- `DELETE /api/categories/{id}` - Eliminar categoría

### Inventario (`READ_INVENTORY`, `WRITE_INVENTORY`, `DELETE_INVENTORY`)
- `GET /api/inventory` - Listar items
- `GET /api/inventory/{id}` - Obtener item
- `GET /api/inventory/category/{categoryId}` - Por categoría
- `GET /api/inventory/brand/{brandId}` - Por marca
- `POST /api/inventory` - Crear item
- `PUT /api/inventory/{id}` - Actualizar item
- `DELETE /api/inventory/{id}` - Eliminar item

### Órdenes de Venta (`READ_ORDERS`, `WRITE_ORDERS`, `DELETE_ORDERS`, `APPROVE_ORDERS`)
- `GET /api/sales-orders` - Listar órdenes
- `GET /api/sales-orders/{id}` - Obtener orden
- `GET /api/sales-orders/employee/{employeeId}` - Por empleado
- `GET /api/sales-orders/status/{status}` - Por estado
- `POST /api/sales-orders` - Crear orden
- `PUT /api/sales-orders/{id}` - Actualizar orden
- `DELETE /api/sales-orders/{id}` - Eliminar orden

### Items de Orden (`READ_ORDERS`, `WRITE_ORDERS`, `DELETE_ORDERS`)
- `GET /api/sales-order-items` - Listar items
- `GET /api/sales-order-items/{id}` - Obtener item
- `GET /api/sales-order-items/order/{orderId}` - Por orden
- `GET /api/sales-order-items/item/{itemId}` - Por item
- `POST /api/sales-order-items` - Crear item
- `PUT /api/sales-order-items/{id}` - Actualizar item
- `DELETE /api/sales-order-items/{id}` - Eliminar item

### Facturas (`READ_INVOICES`, `WRITE_INVOICES`, `DELETE_INVOICES`)
- `GET /api/invoices` - Listar facturas
- `GET /api/invoices/{id}` - Obtener factura
- `GET /api/invoices/employee/{employeeId}` - Por empleado
- `POST /api/invoices` - Crear factura
- `PUT /api/invoices/{id}` - Actualizar factura
- `DELETE /api/invoices/{id}` - Eliminar factura

### Items de Factura (`READ_INVOICES`, `WRITE_INVOICES`, `DELETE_INVOICES`)
- `GET /api/invoice-items` - Listar items
- `GET /api/invoice-items/{id}` - Obtener item
- `GET /api/invoice-items/invoice/{invoiceId}` - Por factura
- `GET /api/invoice-items/item/{itemId}` - Por item
- `POST /api/invoice-items` - Crear item
- `PUT /api/invoice-items/{id}` - Actualizar item
- `DELETE /api/invoice-items/{id}` - Eliminar item

### Asignaciones (`READ_ASSIGNMENTS`, `WRITE_ASSIGNMENTS`, `DELETE_ASSIGNMENTS`)
- `GET /api/assignments` - Listar asignaciones
- `GET /api/assignments/{id}` - Obtener asignación
- `GET /api/assignments/employee/{employeeId}` - Por empleado
- `GET /api/assignments/item/{itemId}` - Por item
- `GET /api/assignments/status/{status}` - Por estado
- `POST /api/assignments` - Crear asignación
- `PUT /api/assignments/{id}` - Actualizar asignación
- `POST /api/assignments/{id}/mark-returned` - Marcar devuelto
- `POST /api/assignments/{id}/mark-lost` - Marcar perdido
- `DELETE /api/assignments/{id}` - Eliminar asignación

### Cotizaciones (`READ_QUOTES`, `WRITE_QUOTES`, `DELETE_QUOTES`)
- `GET /api/quotes` - Listar cotizaciones
- `GET /api/quotes/{id}` - Obtener cotización
- `GET /api/quotes/employee/{employeeId}` - Por empleado
- `GET /api/quotes/customer?name={name}` - Por cliente
- `GET /api/quotes/date-range?startDate={}&endDate={}` - Por rango de fechas
- `POST /api/quotes` - Crear cotización
- `PUT /api/quotes/{id}` - Actualizar cotización
- `POST /api/quotes/{id}/recalculate-total` - Recalcular total
- `DELETE /api/quotes/{id}` - Eliminar cotización

### Líneas de Cotización (`READ_QUOTES`, `WRITE_QUOTES`, `DELETE_QUOTES`)
- `GET /api/quotation-lines` - Listar líneas
- `GET /api/quotation-lines/{id}` - Obtener línea
- `GET /api/quotation-lines/quote/{quoteId}` - Por cotización
- `GET /api/quotation-lines/item/{itemId}` - Por item
- `POST /api/quotation-lines` - Crear línea
- `PUT /api/quotation-lines/{id}` - Actualizar línea
- `DELETE /api/quotation-lines/{id}` - Eliminar línea

### Items de Cotización (`READ_QUOTES`, `WRITE_QUOTES`, `DELETE_QUOTES`)
- `GET /api/quote-items` - Listar items
- `GET /api/quote-items/{id}` - Obtener item
- `GET /api/quote-items/quote/{quoteId}` - Por cotización
- `POST /api/quote-items` - Crear item
- `PUT /api/quote-items/{id}` - Actualizar item
- `DELETE /api/quote-items/{id}` - Eliminar item

### Metas de Ventas (`READ_GOALS`, `WRITE_GOALS`, `DELETE_GOALS`)
- `GET /api/sales-goals` - Listar metas
- `GET /api/sales-goals/{id}` - Obtener meta
- `GET /api/sales-goals/employee/{employeeId}` - Por empleado
- `GET /api/sales-goals/branch/{branchId}` - Por sucursal
- `GET /api/sales-goals/period/{period}` - Por período
- `GET /api/sales-goals/date-range?startDate={}&endDate={}` - Por rango
- `GET /api/sales-goals/employee/{employeeId}/period/{period}` - Específico
- `POST /api/sales-goals` - Crear meta
- `PUT /api/sales-goals/{id}` - Actualizar meta
- `DELETE /api/sales-goals/{id}` - Eliminar meta

## 📱 Vistas HTML (Frontend)

### Autenticación
- `GET /login` - Página de login

### Dashboard Principal
- `GET /` - Dashboard con 21 tarjetas de módulos

### Módulos de Configuración
- `GET /estados` - Gestión de estados
- `GET /ciudades` - Gestión de ciudades
- `GET /organizaciones` - Gestión de organizaciones
- `GET /sucursales` - Gestión de sucursales
- `GET /personas` - Gestión de personas
- `GET /roles` - Gestión de roles
- `GET /usuarios` - Gestión de usuarios
- `GET /permisos` - Gestión de permisos

### Módulos de Inventario
- `GET /marcas` - Gestión de marcas
- `GET /categorias` - Gestión de categorías
- `GET /inventario` - Gestión de inventario

### Módulos de Ventas
- `GET /empleados` - Gestión de empleados
- `GET /ordenes-venta` - Órdenes de venta
- `GET /items-orden-venta` - Items de órdenes
- `GET /facturas` - Facturas
- `GET /items-factura` - Items de facturas
- `GET /cotizaciones` - Cotizaciones
- `GET /lineas-cotizacion` - Líneas de cotización
- `GET /items-cotizacion` - Items de cotización

### Módulos Especiales
- `GET /asignaciones` - Asignaciones de equipos
- `GET /metas-ventas` - Metas de ventas

Todas las vistas incluyen:
- ✅ CRUD completo (Crear, Leer, Actualizar, Eliminar)
- ✅ Filtros y búsquedas
- ✅ Modales para visualización y edición
- ✅ Autenticación JWT
- ✅ Protección de rutas
- ✅ Diseño responsive

## 🚀 Instalación y Configuración

### Requisitos Previos
- Java 17 o superior
- PostgreSQL 17.6
- Maven (o usar el Maven Wrapper incluido)

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone <url-del-repositorio>
cd demo
```

2. **Configurar la base de datos**

Crear una base de datos en PostgreSQL:
```sql
CREATE DATABASE prueba2;
```

3. **Configurar credenciales**

Editar `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/prueba2
spring.datasource.username=postgres
spring.datasource.password=123456
```

4. **Poblar permisos (Opcional pero recomendado)**

Ejecutar el script SQL para crear todos los permisos:
```bash
psql -U postgres -d prueba2 -f sql/insert_permissions.sql
```

O copiar y ejecutar el contenido del archivo en tu cliente SQL favorito.

5. **Ejecutar la aplicación**

Con Maven Wrapper (Windows):
```bash
.\mvnw.cmd spring-boot:run
```

Con Maven Wrapper (Linux/Mac):
```bash
./mvnw spring-boot:run
```

6. **Acceder a la aplicación**
- URL: http://localhost:8080
- La base de datos se poblará automáticamente con datos de prueba al iniciar

### Credenciales de Prueba

**Usuario Administrador:**
- Username: `hugo`
- Password: `admin`
- Role: ADMIN
- Permisos: Todos los permisos del sistema

## 💻 Uso

### 1. Login y Autenticación

**Usando Postman:**
```http
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{
  "username": "hugo",
  "password": "admin"
}
```

**Respuesta:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "type": "Bearer",
  "username": "hugo",
  "role": "ADMIN",
  "permissions": [
    "READ_EMPLOYEES",
    "WRITE_EMPLOYEES",
    "DELETE_EMPLOYEES",
    "MANAGE_USERS",
    "MANAGE_ROLES",
    "ADMIN_ALL",
    ...
  ]
}
```

### 2. Usar Token en Peticiones

Incluir el header en todas las peticiones protegidas:
```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Ejemplo con Postman:**
```http
GET http://localhost:8080/api/employees
Authorization: Bearer {{token}}
```

### 3. Probar Endpoints con Postman

**Listar empleados (requiere READ_EMPLOYEES):**
```http
GET http://localhost:8080/api/employees
Authorization: Bearer {{token}}
```

**Crear empleado (requiere WRITE_EMPLOYEES):**
```http
POST http://localhost:8080/api/employees
Authorization: Bearer {{token}}
Content-Type: application/json

{
  "firstName": "Juan",
  "lastName": "Pérez",
  "email": "juan.perez@empresa.com",
  "phone": "3001234567",
  "position": "Vendedor",
  "hireDate": "2024-01-15",
  "salary": 2500000,
  "branchId": 1,
  "status": "active"
}
```

**Eliminar empleado (requiere DELETE_EMPLOYEES):**
```http
DELETE http://localhost:8080/api/employees/5
Authorization: Bearer {{token}}
```

### 4. Acceder a la Interfaz Web

1. Abrir navegador en http://localhost:8080/login
2. Ingresar credenciales (hugo / admin)
3. El sistema redirige al dashboard principal
4. Navegar por los 21 módulos disponibles

**Ejemplo de flujo:**
- Login → Dashboard → Empleados → Crear nuevo empleado
- Dashboard → Cotizaciones → Ver cotización → Líneas de cotización
- Dashboard → Asignaciones → Asignar equipo a empleado → Marcar como devuelto

## 📈 Avances del Proyecto

### Fase 1: Configuración Inicial
✅ Configuración de Spring Boot con PostgreSQL
✅ Integración de Hibernate/JPA
✅ Configuración de HikariCP para connection pooling
✅ Estructura de paquetes y arquitectura en capas

### Fase 2: Migración de Modelos
✅ Migración de 15 entidades desde Flask/SQLAlchemy a JPA
✅ Configuración de relaciones bidireccionales (ManyToOne, OneToMany)
✅ Implementación de timestamps automáticos (@PrePersist, @PreUpdate)
✅ Solución de conflictos con palabras reservadas de PostgreSQL (tabla "users")

### Fase 3: Capa de Persistencia
✅ Creación de 15 repositorios JPA (interfaces extendiendo JpaRepository)
✅ Implementación de métodos de consulta personalizados
✅ Optimización de queries con FetchType.LAZY

### Fase 4: Capa de Controladores
✅ Implementación de 18 controladores REST
✅ Endpoints CRUD para todas las entidades
✅ Controlador de vistas para servir páginas HTML
✅ Manejo de respuestas HTTP (ResponseEntity)

### Fase 5: Población de Datos
✅ Creación de script SQL con datos de prueba (data.sql)
✅ Población de 15 tablas con más de 100 registros
✅ Datos relacionales coherentes entre todas las entidades
✅ Variedad de datos para pruebas exhaustivas

### Fase 6: Frontend
✅ Integración de Thymeleaf como motor de plantillas
✅ Diseño responsive con Bootstrap 5
✅ Implementación de 4 vistas HTML dinámicas
✅ JavaScript para consumir APIs REST con Fetch
✅ Componentes interactivos (búsqueda, filtros, estadísticas)

### Fase 7: Debugging y Optimización
✅ Solución de errores de lazy loading con @JsonIgnore
✅ Prevención de loops infinitos en serialización JSON
✅ Optimización de relaciones JPA para APIs REST
✅ Corrección de endpoints y rutas de controladores
✅ Validación de funcionamiento en Postman y navegador

### Fase 8: Sistema de Autenticación JWT
✅ Implementación de Spring Security 6
✅ Configuración de JWT (generación y validación)
✅ JwtRequestFilter para validar tokens en cada petición
✅ Encriptación de contraseñas con BCrypt
✅ Endpoints de login y registro
✅ UserDetailsService personalizado
✅ Configuración de CORS para frontend

### Fase 9: Sistema de Permisos Granulares
✅ Creación de entidades Permission y RolePermission
✅ 49 permisos definidos (READ, WRITE, DELETE por módulo)
✅ Actualización de 141 anotaciones @PreAuthorize en 23 controladores
✅ Cambio de hasRole('ADMIN') a hasAuthority('PERMISSION_NAME')
✅ User.getAuthorities() carga rol y permisos
✅ JWT incluye array de permisos en respuesta
✅ Script SQL para poblar permisos (insert_permissions.sql)
✅ Asignación de permisos a roles mediante role_permission

### Fase 10: Módulos Adicionales de Negocio
✅ Asignaciones de equipos/items a empleados
✅ Cotizaciones con líneas e items
✅ Metas de ventas por empleado y sucursal
✅ Estados de asignación (ACTIVE, RETURNED, LOST)
✅ Períodos de metas (MONTHLY, QUARTERLY, YEARLY)
✅ Tipos de metas (EMPLOYEE_GOAL, BRANCH_GOAL)

### Fase 11: Frontend Completo
✅ 21 páginas HTML con Thymeleaf
✅ Dashboard principal con tarjetas de módulos
✅ CRUD completo en todas las vistas
✅ Filtros y búsquedas por múltiples criterios
✅ Modales para crear, editar y visualizar
✅ auth-guard.js para protección de rutas
✅ Inclusión de token JWT en todas las peticiones
✅ Diseño responsive con Bootstrap 5
✅ Iconos de Bootstrap Icons
✅ Manejo de errores y mensajes al usuario

### Características Implementadas
- ✅ **Seguridad completa**: JWT + Permisos granulares
- ✅ **23 controladores REST**: APIs para todos los módulos
- ✅ **20 entidades JPA**: Modelo de datos completo
- ✅ **21 vistas HTML**: Interfaz web moderna
- ✅ **49 permisos**: Control de acceso detallado
- ✅ **Arquitectura en capas**: Separación de responsabilidades
- ✅ **Persistencia JPA/Hibernate**: ORM optimizado
- ✅ **Relaciones complejas**: ManyToOne, OneToMany, ManyToMany
- ✅ **Connection pooling**: HikariCP configurado
- ✅ **Timestamps automáticos**: @PrePersist, @PreUpdate
- ✅ **Validaciones**: Integridad referencial
- ✅ **Manejo de errores**: GlobalExceptionHandler
- ✅ **CORS configurado**: Para consumo desde frontend
- ✅ **Script de datos**: Población automática de BD

## 🔧 Configuración Técnica

### application.properties
```properties
# Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/prueba2
spring.datasource.username=postgres
spring.datasource.password=123456
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA/Hibernate Configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true

# SQL Script Initialization
spring.sql.init.mode=always
spring.jpa.defer-datasource-initialization=true

# JWT Configuration
jwt.secret=5367566B59703373367639792F423F4528482B4D6251655468576D5A71347437
jwt.expiration=86400000

# Thymeleaf Configuration
spring.thymeleaf.cache=false

# CORS Configuration
cors.allowed-origins=http://localhost:4200,http://localhost:3000
cors.allowed-methods=GET,POST,PUT,DELETE,OPTIONS
cors.allowed-headers=*
cors.allow-credentials=true
```

### SecurityConfig.java - Configuración de Spring Security

```java
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    
    // Configuración de filtros JWT
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/**", "/login", "/css/**", "/js/**").permitAll()
                .anyRequest().authenticated()
            )
            .sessionManagement(session -> 
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            )
            .addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}
```

### Uso de @PreAuthorize en Controllers

```java
@RestController
@RequestMapping("/api/employees")
public class EmployeeController {
    
    @PreAuthorize("hasAuthority('READ_EMPLOYEES')")
    @GetMapping
    public ResponseEntity<List<Employee>> getAllEmployees() { }
    
    @PreAuthorize("hasAuthority('WRITE_EMPLOYEES')")
    @PostMapping
    public ResponseEntity<Employee> createEmployee(@RequestBody Employee employee) { }
    
    @PreAuthorize("hasAuthority('DELETE_EMPLOYEES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEmployee(@PathVariable Long id) { }
}
```

## 🐛 Solución de Problemas Comunes

### Error: "Could not initialize proxy - no session"
**Solución:** Se agregó `@JsonIgnore` a todas las relaciones lazy en las entidades para evitar serialización de proxies de Hibernate.

### Error: Tabla "user" es palabra reservada
**Solución:** Se renombró la tabla a "users" usando `@Table(name = "users")`.

### Error: 403 Forbidden en endpoints protegidos
**Solución:** 
1. Verificar que el token JWT esté en el header: `Authorization: Bearer <token>`
2. Verificar que el usuario tenga el permiso requerido
3. Revisar que @PreAuthorize use hasAuthority() no hasRole()

### Error: "Access Denied" después de login
**Solución:**
1. Ejecutar el script `sql/insert_permissions.sql` para poblar permisos
2. Asignar permisos al rol ADMIN en la tabla `role_permission`
3. Verificar que User.getAuthorities() cargue los permisos correctamente

### Error: Frontend no carga datos
**Solución:** 
1. Verificar que las rutas del Fetch API coincidan con los `@RequestMapping`
2. Incluir `getAuthHeaders()` en todas las peticiones fetch
3. Revisar console del navegador para errores de CORS

### Error: Token expirado
**Solución:** 
- El token JWT expira en 24 horas (configurable en `jwt.expiration`)
- Hacer login nuevamente para obtener un nuevo token
- Implementar refresh token para renovación automática

### Error: CORS blocking requests
**Solución:**
- Verificar configuración en `application.properties`
- Agregar origen del frontend a `cors.allowed-origins`
- Verificar que CorsConfig esté correctamente configurado

## 📝 Notas de Desarrollo

### Buenas Prácticas Implementadas
- **Patrón DTO implícito**: Campos FK se serializan en JSON, relaciones @ManyToOne/@OneToMany se ignoran con @JsonIgnore
- **Timestamps automáticos**: @PrePersist y @PreUpdate
- **Seguridad por capas**: JWT + @PreAuthorize + hasAuthority()
- **Separación de responsabilidades**: Controller → Service → Repository
- **Inicialización automática**: data.sql poblará la BD al iniciar

### Arquitectura de Permisos

**Flujo de Autorización:**
```
1. Usuario hace login → Genera JWT con permisos
2. Cliente incluye JWT en header Authorization
3. JwtRequestFilter valida token
4. SecurityContext se popula con authorities
5. @PreAuthorize verifica permiso específico
6. Controller ejecuta si tiene permiso
```

**Ejemplo de Verificación:**
```java
@PreAuthorize("hasAuthority('WRITE_EMPLOYEES')")
// Spring Security verifica que el usuario autenticado
// tenga el permiso 'WRITE_EMPLOYEES' en sus authorities
```

### Mejoras Futuras Sugeridas
- [ ] Implementar DTOs explícitos para mayor control
- [ ] Agregar paginación en endpoints que retornan listas
- [ ] Implementar refresh tokens para renovación automática
- [ ] Agregar auditoría de cambios (quién modificó qué y cuándo)
- [ ] Implementar caché con Redis para mejorar performance
- [ ] Agregar tests unitarios y de integración
- [ ] Documentar API con Swagger/OpenAPI
- [ ] Implementar rate limiting para prevenir abuso
- [ ] Agregar logging estructurado con SLF4J
- [ ] Implementar soft delete en lugar de hard delete

### Stack Tecnológico Completo

**Backend:**
- Java 17
- Spring Boot 3.5.6 (Web, Data JPA, Security)
- JWT (io.jsonwebtoken)
- BCrypt
- Hibernate 6.6.29
- PostgreSQL 17.6
- HikariCP
- Maven

**Frontend:**
- Thymeleaf
- Bootstrap 5.3.0
- Bootstrap Icons 1.10.0
- JavaScript ES6+ (Fetch API)
- LocalStorage (JWT persistence)

**Seguridad:**
- Spring Security 6
- JWT Tokens (24h expiration)
- BCrypt password hashing
- @PreAuthorize method security
- CORS configuration
- CSRF protection (disabled for REST APIs)

## 📊 Estadísticas del Proyecto

- **Controladores**: 23
- **Entidades JPA**: 20
- **Repositorios**: 20
- **Vistas HTML**: 21
- **Endpoints REST**: ~150
- **Permisos**: 49
- **Líneas de código**: ~8,000+
- **Tablas en BD**: 22

## 📄 Licencia

Este proyecto es parte del curso de Sistemas de Bases de Datos de 6to semestre.

---

**Desarrollado con ❤️ por Carlos Garzón, Daniel Serrato y Wilkerson Zabala**
