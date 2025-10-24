# Migración de Flask a Spring Boot - Documentación

## Resumen de la Migración

Se ha migrado exitosamente la aplicación Flask (app-multicont) a Spring Boot con JPA/Hibernate.

## Entidades Migradas

### Modelos Principales
1. **User** - Usuario del sistema
   - Campos: id, username, password, roleId
   - Relación: ManyToOne con Role

2. **Role** - Roles de usuario
   - Campos: id, name

3. **Organization** - Organizaciones
   - Campos: id, historicalName, currentName
   - Relación: OneToMany con Branch

4. **Branch** - Sucursales
   - Campos: id, organizationId, cityId
   - Relaciones: ManyToOne con Organization y City

5. **State** - Estados/Provincias
   - Campos: id, description, code
   - Relación: OneToMany con City

6. **City** - Ciudades
   - Campos: id, description, code, stateId
   - Relación: ManyToOne con State

7. **Person** - Personas
   - Campos: id, dni, firstName, lastName, address, phone, cityId
   - Relación: ManyToOne con City
   - Método computado: getFullName()

8. **Employee** - Empleados
   - Campos: id, firstName, lastName, email, phone, position, hireDate, salary, branchId, status, creationDate, updateDate
   - Relación: ManyToOne con Branch
   - Auditoría: @PrePersist y @PreUpdate para timestamps

9. **Brand** - Marcas de productos
   - Campos: id, name, description, creationDate

10. **ItemCategory** - Categorías de items
    - Campos: id, name

11. **InventoryItem** - Items de inventario
    - Campos: id, name, description, quantity, price, categoryId, brandId
    - Relaciones: ManyToOne con ItemCategory y Brand

12. **Invoice** - Facturas
    - Campos: id, customerName, invoiceDate, total, employeeId, salesOrderId, creationDate, updateDate
    - Relaciones: ManyToOne con Employee y SalesOrder, OneToMany con InvoiceItem
    - Auditoría: @PrePersist y @PreUpdate

13. **InvoiceItem** - Items de factura
    - Campos: id, invoiceId, itemId, quantity, price
    - Relaciones: ManyToOne con Invoice y InventoryItem

14. **SalesOrder** - Órdenes de venta
    - Campos: id, customerName, orderDate, total, status, employeeId, quoteId, creationDate, updateDate
    - Relaciones: ManyToOne con Employee, OneToMany con SalesOrderItem e Invoice
    - Auditoría: @PrePersist y @PreUpdate

15. **SalesOrderItem** - Items de orden de venta
    - Campos: id, salesOrderId, itemId, quantity
    - Relaciones: ManyToOne con SalesOrder y InventoryItem

## Repositorios Creados

Se han creado repositorios JPA (interfaces que extienden JpaRepository) para todas las entidades:

- UserRepository
- RoleRepository
- OrganizationRepository
- BranchRepository
- StateRepository
- CityRepository
- PersonRepository
- EmployeeRepository
- BrandRepository
- ItemCategoryRepository
- InventoryItemRepository
- InvoiceRepository
- InvoiceItemRepository
- SalesOrderRepository
- SalesOrderItemRepository

Cada repositorio incluye métodos de búsqueda personalizados según las necesidades del negocio.

## Controladores REST Creados

Se han creado controladores REST de ejemplo:

1. **UserController** (`/api/users`)
   - GET /api/users - Listar todos los usuarios
   - GET /api/users/{id} - Obtener usuario por ID
   - GET /api/users/username/{username} - Obtener usuario por username
   - POST /api/users - Crear usuario
   - PUT /api/users/{id} - Actualizar usuario
   - DELETE /api/users/{id} - Eliminar usuario

2. **OrganizationController** (`/api/organizations`)
   - CRUD completo para organizaciones

3. **InvoiceController** (`/api/invoices`)
   - CRUD completo para facturas
   - GET /api/invoices/employee/{employeeId} - Facturas por empleado

## Diferencias Clave entre Flask-SQLAlchemy y Spring Boot JPA

### 1. Decoradores vs Anotaciones
- **Flask**: `@db.Model`, columnas con `db.Column()`
- **Spring Boot**: `@Entity`, `@Table`, `@Column`, etc.

### 2. Relaciones
- **Flask**: `db.relationship()` con backref
- **Spring Boot**: `@ManyToOne`, `@OneToMany`, `@JoinColumn`

### 3. Timestamps
- **Flask**: `default=datetime.utcnow`, `onupdate=datetime.utcnow`
- **Spring Boot**: `@PrePersist`, `@PreUpdate` con LocalDateTime

### 4. Tipos de Datos
- **Flask**: `db.String`, `db.Numeric`, `db.Date`, `db.DateTime`
- **Spring Boot**: `String`, `BigDecimal`, `LocalDate`, `LocalDateTime`

### 5. Serialización
- **Flask**: Método `to_dict()` personalizado
- **Spring Boot**: Jackson automático (o DTOs personalizados)

### 6. Primary Keys
- **Flask**: `primary_key=True, autoincrement=True`
- **Spring Boot**: `@Id`, `@GeneratedValue(strategy = GenerationType.IDENTITY)`

## Configuración de Base de Datos

La configuración en `application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/prueba2
spring.datasource.username=postgres
spring.datasource.password=123456
spring.jpa.hibernate.ddl-auto=update
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
```

## Próximos Pasos

1. **Crear DTOs** (Data Transfer Objects) para separar la capa de presentación de las entidades
2. **Implementar Servicios** para la lógica de negocio
3. **Agregar Validaciones** con Bean Validation (@Valid, @NotNull, etc.)
4. **Implementar Seguridad** con Spring Security
5. **Agregar Swagger/OpenAPI** para documentación de la API
6. **Crear Tests** unitarios y de integración
7. **Migrar la lógica de negocio** de los use_cases de Flask

## Estructura del Proyecto

```
src/main/java/com/example/demo/
├── model/              # Entidades JPA
├── repository/         # Repositorios JPA
├── controller/         # Controladores REST
├── service/            # Servicios (por crear)
├── dto/                # DTOs (por crear)
└── DemoApplication.java
```

## Comandos Útiles

### Compilar el proyecto
```bash
./mvnw clean compile
```

### Ejecutar la aplicación
```bash
./mvnw spring-boot:run
```

### Ejecutar tests
```bash
./mvnw test
```

## Notas Importantes

- Las tablas se crean automáticamente con `spring.jpa.hibernate.ddl-auto=update`
- Se cambió el nombre de la tabla `user` a `users` para evitar conflictos con palabras reservadas en PostgreSQL
- Se utilizan `BigDecimal` para valores monetarios (mejor precisión que `Double`)
- Se utilizan `LocalDate` y `LocalDateTime` en lugar de `Date` (API moderna de Java)
- Las relaciones bidireccionales pueden causar problemas de serialización JSON (considerar usar `@JsonIgnore` o DTOs)
