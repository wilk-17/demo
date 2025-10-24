# Sistema de Gestión - Spring Boot

Sistema de gestión empresarial desarrollado con Spring Boot y PostgreSQL, migrado desde una aplicación Flask a una arquitectura Java moderna con JPA/Hibernate.

## 📋 Tabla de Contenidos

- [Autores](#autores)
- [Descripción](#descripción)
- [Tecnologías Utilizadas](#tecnologías-utilizadas)
- [Arquitectura](#arquitectura)
- [Modelos de Datos](#modelos-de-datos)
- [Endpoints API](#endpoints-api)
- [Instalación y Configuración](#instalación-y-configuración)
- [Uso](#uso)
- [Avances del Proyecto](#avances-del-proyecto)

## 👥 Autores

- **Carlos Andrés Garzón Tafur**
- **Daniel Andrés Serrato Morales**
- **Wilkerson Zabala Urueña**

## 📖 Descripción

Sistema integral de gestión empresarial que permite administrar usuarios, organizaciones, sucursales, inventario, ventas y facturación. El proyecto fue migrado completamente desde Flask/SQLAlchemy a Spring Boot/JPA, manteniendo la integridad de la estructura de datos y mejorando la arquitectura con patrones modernos de Java.

## 🛠️ Tecnologías Utilizadas

### Backend
- **Java 17**
- **Spring Boot 3.5.6**
  - Spring Data JPA
  - Spring Web
  - Spring Boot DevTools
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

El proyecto sigue una arquitectura en capas:

```
demo/
├── src/
│   ├── main/
│   │   ├── java/com/example/demo/
│   │   │   ├── controller/      # Controladores REST y de vistas
│   │   │   ├── model/            # Entidades JPA
│   │   │   ├── repository/       # Repositorios JPA
│   │   │   └── DemoApplication.java
│   │   └── resources/
│   │       ├── templates/        # Vistas HTML con Thymeleaf
│   │       ├── static/           # Recursos estáticos
│   │       ├── application.properties
│   │       └── data.sql          # Script de datos de prueba
│   └── test/
├── pom.xml
└── README.md
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

### Relaciones Clave

- **User** → **Role**: ManyToOne
- **State** → **City**: OneToMany
- **Organization** → **Branch**: OneToMany
- **Person** → **Employee**: OneToOne
- **Branch** → **Employee**: OneToMany
- **Branch** → **InventoryItem**: OneToMany
- **SalesOrder** → **SalesOrderItem**: OneToMany
- **Invoice** → **InvoiceItem**: OneToMany

## 🔌 Endpoints API

### Usuarios
- `GET /users` - Listar todos los usuarios
- `GET /users/{id}` - Obtener usuario por ID

### Estados
- `GET /state` - Listar todos los estados
- `GET /state/{id}` - Obtener estado por ID

### Ciudades
- `GET /city` - Listar todas las ciudades
- `GET /city/{id}` - Obtener ciudad por ID

### Organizaciones
- `GET /organization` - Listar todas las organizaciones
- `GET /organization/{id}` - Obtener organización por ID

### Sucursales
- `GET /branch` - Listar todas las sucursales
- `GET /branch/{id}` - Obtener sucursal por ID

### Personas
- `GET /person` - Listar todas las personas
- `GET /person/{id}` - Obtener persona por ID

### Empleados
- `GET /employee` - Listar todos los empleados
- `GET /employee/{id}` - Obtener empleado por ID

### Marcas
- `GET /brand` - Listar todas las marcas
- `GET /brand/{id}` - Obtener marca por ID

### Categorías
- `GET /category` - Listar todas las categorías
- `GET /category/{id}` - Obtener categoría por ID

### Inventario
- `GET /inventory` - Listar todos los items de inventario
- `GET /inventory/{id}` - Obtener item por ID

### Órdenes de Venta
- `GET /sales-order` - Listar todas las órdenes
- `GET /sales-order/{id}` - Obtener orden por ID

### Items de Orden de Venta
- `GET /sales-order-item` - Listar todos los items
- `GET /sales-order-item/{id}` - Obtener item por ID

### Facturas
- `GET /invoice` - Listar todas las facturas
- `GET /invoice/{id}` - Obtener factura por ID

### Items de Factura
- `GET /invoice-item` - Listar todos los items de factura
- `GET /invoice-item/{id}` - Obtener item por ID

### Roles
- `GET /role` - Listar todos los roles
- `GET /role/{id}` - Obtener rol por ID

## 📱 Vistas HTML

- `GET /` - Página principal del sistema
- `GET /usuarios` - Gestión de usuarios (tabla con estadísticas por rol)
- `GET /estados` - Gestión de estados (tabla con búsqueda y filtros)
- `GET /ciudades` - Gestión de ciudades (tabla con búsqueda y filtros)

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

4. **Ejecutar la aplicación**

Con Maven Wrapper (Windows):
```bash
.\mvnw.cmd spring-boot:run
```

Con Maven Wrapper (Linux/Mac):
```bash
./mvnw spring-boot:run
```

5. **Acceder a la aplicación**
- URL: http://localhost:8080
- La base de datos se poblará automáticamente con datos de prueba al iniciar

## 💻 Uso

### Probar con Postman

Importar y probar los endpoints REST:
```
GET http://localhost:8080/users
GET http://localhost:8080/state
GET http://localhost:8080/city
GET http://localhost:8080/organization
```

### Acceder a las vistas web

Abrir en el navegador:
- http://localhost:8080/ - Página principal
- http://localhost:8080/usuarios - Gestión de usuarios
- http://localhost:8080/estados - Gestión de estados
- http://localhost:8080/ciudades - Gestión de ciudades

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

### Características Implementadas
- ✅ Arquitectura REST completa
- ✅ Persistencia con JPA/Hibernate
- ✅ Relaciones complejas entre entidades
- ✅ Interfaz web responsive
- ✅ Datos de prueba completos
- ✅ Manejo de errores HTTP
- ✅ Connection pooling optimizado
- ✅ Timestamps automáticos
- ✅ Validaciones de integridad referencial

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

# Thymeleaf Configuration
spring.thymeleaf.cache=false
```

## 🐛 Solución de Problemas Comunes

### Error: "Could not initialize proxy - no session"
**Solución:** Se agregó `@JsonIgnore` a todas las relaciones lazy en las entidades para evitar serialización de proxies de Hibernate.

### Error: Tabla "user" es palabra reservada
**Solución:** Se renombró la tabla a "users" usando `@Table(name = "users")`.

### Error: Frontend no carga datos
**Solución:** Verificar que las rutas del Fetch API coincidan con los `@RequestMapping` de los controladores.

## 📝 Notas de Desarrollo

- Se utiliza patrón DTO implícito: los campos FK (roleId, stateId, etc.) se serializan en JSON mientras que las relaciones @ManyToOne/@OneToMany se ignoran con @JsonIgnore
- Los timestamps se manejan automáticamente con @PrePersist y @PreUpdate
- La inicialización de datos se ejecuta automáticamente desde data.sql al arrancar la aplicación
- Se recomienda usar DTOs explícitos para proyectos de producción en lugar de @JsonIgnore

## 📄 Licencia

Este proyecto es parte del curso de Sistemas de Bases de Datos de 6to semestre.

---

**Desarrollado con ❤️ por Carlos Garzón, Daniel Serrato y Wilkerson Zabala**
