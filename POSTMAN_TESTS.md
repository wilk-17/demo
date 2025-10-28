# Guía de Pruebas CRUD en Postman

## BASE URL
```
http://localhost:8080
```

## 1. USUARIOS (/users)

### GET - Listar todos
```
GET http://localhost:8080/users
```

### GET - Obtener por ID
```
GET http://localhost:8080/users/1
```

### POST - Crear usuario
```
POST http://localhost:8080/users
Content-Type: application/json

{
  "username": "nuevo_usuario",
  "password": "password123",
  "roleId": 3
}
```

### PUT - Actualizar usuario
```
PUT http://localhost:8080/users/1
Content-Type: application/json

{
  "username": "usuario_actualizado",
  "password": "newpassword",
  "roleId": 2
}
```

### DELETE - Eliminar usuario
```
DELETE http://localhost:8080/users/7
```

---

## 2. ROLES (/role)

### GET - Listar todos
```
GET http://localhost:8080/role
```

### POST - Crear rol
```
POST http://localhost:8080/role
Content-Type: application/json

{
  "name": "Supervisor"
}
```

**Nota**: Role solo tiene el campo `name` (string)

### PUT - Actualizar rol
```
PUT http://localhost:8080/role/6
Content-Type: application/json

{
  "name": "Supervisor Senior"
}
```

### DELETE - Eliminar rol
```
DELETE http://localhost:8080/role/6
```

---

## 3. ESTADOS (/state)

### GET - Listar todos
```
GET http://localhost:8080/state
```

### POST - Crear estado
```
POST http://localhost:8080/state
Content-Type: application/json

{
  "description": "Amazonas",
  "code": "AMA"
}
```

### PUT - Actualizar estado
```
PUT http://localhost:8080/state/9
Content-Type: application/json

{
  "description": "Amazonas",
  "code": "AMAZ"
}
```

### DELETE - Eliminar estado
```
DELETE http://localhost:8080/state/9
```

---

## 4. CIUDADES (/city)

### GET - Listar todas
```
GET http://localhost:8080/city
```

### GET - Por estado
```
GET http://localhost:8080/city/state/1
```

### POST - Crear ciudad
```
POST http://localhost:8080/city
Content-Type: application/json

{
  "description": "Nueva Ciudad",
  "stateId": 1,
  "code": "NCU"
}
```

### PUT - Actualizar ciudad
```
PUT http://localhost:8080/city/17
Content-Type: application/json

{
  "description": "Ciudad Actualizada",
  "stateId": 1,
  "code": "CAC"
}
```

### DELETE - Eliminar ciudad
```
DELETE http://localhost:8080/city/17
```

---

## 5. ORGANIZACIONES (/api/organizations)

### GET - Listar todas
```
GET http://localhost:8080/api/organizations
```

### POST - Crear organización
```
POST http://localhost:8080/api/organizations
Content-Type: application/json

{
  "historicalName": "Empresa XYZ S.A.",
  "currentName": "Grupo XYZ"
}
```

### PUT - Actualizar organización
```
PUT http://localhost:8080/api/organizations/4
Content-Type: application/json

{
  "historicalName": "Empresa ABC S.A.",
  "currentName": "Corporación ABC"
}
```

### DELETE - Eliminar organización
```
DELETE http://localhost:8080/api/organizations/4
```

---

## 6. SUCURSALES (/branch)

### GET - Listar todas
```
GET http://localhost:8080/branch
```

### GET - Por organización
```
GET http://localhost:8080/branch/organization/1
```

### POST - Crear sucursal
```
POST http://localhost:8080/branch
Content-Type: application/json

{
  "organizationId": 1,
  "cityId": 1
}
```

### PUT - Actualizar sucursal
```
PUT http://localhost:8080/branch/10
Content-Type: application/json

{
  "organizationId": 2,
  "cityId": 3
}
```

### DELETE - Eliminar sucursal
```
DELETE http://localhost:8080/branch/10
```

---

## 7. PERSONAS (/person)

### GET - Listar todas
```
GET http://localhost:8080/person
```

### POST - Crear persona
```
POST http://localhost:8080/person
Content-Type: application/json

{
  "dni": "1234567890",
  "firstName": "Carlos",
  "lastName": "Rodríguez",
  "address": "Calle 123 #45-67",
  "phone": "3001234567",
  "cityId": 1
}
```

**Campos Person**:
- `dni` (string, unique) - DNI/Cédula
- `firstName` (string, required)
- `lastName` (string, required)
- `address` (string, optional)
- `phone` (string, optional)
- `cityId` (long, optional)

### PUT - Actualizar persona
```
PUT http://localhost:8080/person/9
Content-Type: application/json

{
  "dni": "1234567890",
  "firstName": "Carlos Alberto",
  "lastName": "Rodríguez Pérez",
  "address": "Carrera 45 #67-89",
  "phone": "3009876543",
  "cityId": 2
}
```

### DELETE - Eliminar persona
```
DELETE http://localhost:8080/person/9
```

---

## 8. EMPLEADOS (/employee)

### GET - Listar todos
```
GET http://localhost:8080/employee
```

### GET - Por sucursal
```
GET http://localhost:8080/employee/branch/1
```

### POST - Crear empleado
```
POST http://localhost:8080/employee
Content-Type: application/json

{
  "firstName": "María",
  "lastName": "González",
  "email": "maria.gonzalez@empresa.com",
  "phone": "3101234567",
  "position": "Vendedor",
  "hireDate": "2025-01-15",
  "salary": 2500000.00,
  "branchId": 1,
  "status": "active"
}
```

**Campos Employee**:
- `firstName` (string, required)
- `lastName` (string, required)
- `email` (string, unique, required)
- `phone` (string, optional)
- `position` (string, required) - cargo/posición
- `hireDate` (date "YYYY-MM-DD", required)
- `salary` (decimal, optional)
- `branchId` (long, required)
- `status` (string, default: "active")

### PUT - Actualizar empleado
```
PUT http://localhost:8080/employee/9
Content-Type: application/json

{
  "firstName": "María José",
  "lastName": "González Pérez",
  "email": "maria.gonzalez@empresa.com",
  "phone": "3109876543",
  "position": "Gerente de Ventas",
  "hireDate": "2025-01-15",
  "salary": 3500000.00,
  "branchId": 2,
  "status": "active"
}
```

### DELETE - Eliminar empleado
```
DELETE http://localhost:8080/employee/9
```

---

## 9. MARCAS (/brand)

### GET - Listar todas
```
GET http://localhost:8080/brand
```

### POST - Crear marca
```
POST http://localhost:8080/brand
Content-Type: application/json

{
  "name": "Nike",
  "description": "Marca deportiva internacional"
}
```

**Campos Brand**:
- `name` (string, required, unique)
- `description` (string, optional)

### PUT - Actualizar marca
```
PUT http://localhost:8080/brand/11
Content-Type: application/json

{
  "name": "Nike Inc.",
  "description": "Marca líder en ropa y calzado deportivo"
}
```

### DELETE - Eliminar marca
```
DELETE http://localhost:8080/brand/11
```

---

## 10. CATEGORÍAS (/category)

### GET - Listar todas
```
GET http://localhost:8080/category
```

### POST - Crear categoría
```
POST http://localhost:8080/category
Content-Type: application/json

{
  "name": "Electrónica"
}
```

**Nota**: ItemCategory solo tiene el campo `name` (string)

### PUT - Actualizar categoría
```
PUT http://localhost:8080/category/11
Content-Type: application/json

{
  "name": "Electrónica Premium"
}
```

### DELETE - Eliminar categoría
```
DELETE http://localhost:8080/category/11
```

---

## 11. INVENTARIO (/inventory)

### GET - Listar todos los items
```
GET http://localhost:8080/inventory
```

### POST - Crear item
```
POST http://localhost:8080/inventory
Content-Type: application/json

{
  "name": "Laptop HP Pavilion",
  "description": "Laptop HP Core i7 16GB RAM",
  "quantity": 15,
  "price": 3500000.00,
  "categoryId": 1,
  "brandId": 1
}
```

**Campos InventoryItem**:
- `name` (string, required)
- `description` (string, optional)
- `quantity` (integer, default: 0)
- `price` (decimal, required)
- `categoryId` (long, optional)
- `brandId` (long, optional)

### PUT - Actualizar item
```
PUT http://localhost:8080/inventory/16
Content-Type: application/json

{
  "name": "Laptop HP Pavilion 15",
  "description": "Laptop HP Pavilion Core i7 16GB RAM SSD 512GB",
  "quantity": 20,
  "price": 3800000.00,
  "categoryId": 1,
  "brandId": 1
}
```

### DELETE - Eliminar item
```
DELETE http://localhost:8080/inventory/16
```

---

## 12. ÓRDENES DE VENTA (/sales-order)

### GET - Listar todas
```
GET http://localhost:8080/sales-order
```

### GET - Por estado
```
GET http://localhost:8080/sales-order/status/pending
```

### POST - Crear orden
```
POST http://localhost:8080/sales-order
Content-Type: application/json

{
  "customerName": "Juan Pérez",
  "orderDate": "2025-10-28",
  "total": 500000.00,
  "status": "pending",
  "employeeId": 1,
  "quoteId": null
}
```

**Campos SalesOrder**:
- `customerName` (string, required)
- `orderDate` (date "YYYY-MM-DD", required)
- `total` (decimal, default: 0.00)
- `status` (string, default: "pending")
- `employeeId` (long, optional)
- `quoteId` (long, optional)

### PUT - Actualizar orden
```
PUT http://localhost:8080/sales-order/7
Content-Type: application/json

{
  "customerName": "Juan Pérez García",
  "orderDate": "2025-10-28",
  "total": 650000.00,
  "status": "completed",
  "employeeId": 1,
  "quoteId": null
}
```

### DELETE - Eliminar orden
```
DELETE http://localhost:8080/sales-order/7
```

---

## 13. ITEMS DE ORDEN (/sales-order-item)

### GET - Listar todos
```
GET http://localhost:8080/sales-order-item
```

### GET - Por orden
```
GET http://localhost:8080/sales-order-item/order/1
```

### POST - Crear item
```
POST http://localhost:8080/sales-order-item
Content-Type: application/json

{
  "salesOrderId": 1,
  "itemId": 1,
  "quantity": 5
}
```

**Campos SalesOrderItem**:
- `salesOrderId` (long, required)
- `itemId` (long, required)
- `quantity` (integer, required)

### PUT - Actualizar item
```
PUT http://localhost:8080/sales-order-item/15
Content-Type: application/json

{
  "salesOrderId": 1,
  "itemId": 1,
  "quantity": 7
}
```

### DELETE - Eliminar item
```
DELETE http://localhost:8080/sales-order-item/15
```

---

## 14. FACTURAS (/invoice)

### GET - Listar todas
```
GET http://localhost:8080/invoice
```

### POST - Crear factura
```
POST http://localhost:8080/invoice
Content-Type: application/json

{
  "customerName": "Ana María López",
  "invoiceDate": "2025-10-28",
  "total": 500000.00,
  "employeeId": 1,
  "salesOrderId": 1
}
```

**Campos Invoice**:
- `customerName` (string, required)
- `invoiceDate` (date "YYYY-MM-DD", required)
- `total` (decimal, default: 0.00)
- `employeeId` (long, optional)
- `salesOrderId` (long, optional)

### PUT - Actualizar factura
```
PUT http://localhost:8080/invoice/5
Content-Type: application/json

{
  "customerName": "Ana María López García",
  "invoiceDate": "2025-10-28",
  "total": 650000.00,
  "employeeId": 2,
  "salesOrderId": 1
}
```

### DELETE - Eliminar factura
```
DELETE http://localhost:8080/invoice/5
```

---

## 15. ITEMS DE FACTURA (/invoice-item)

### GET - Listar todos
```
GET http://localhost:8080/invoice-item
```

### GET - Por factura
```
GET http://localhost:8080/invoice-item/invoice/1
```

### POST - Crear item
```
POST http://localhost:8080/invoice-item
Content-Type: application/json

{
  "invoiceId": 1,
  "itemId": 1,
  "quantity": 3,
  "price": 100000.00
}
```

**Campos InvoiceItem**:
- `invoiceId` (long, required)
- `itemId` (long, required)
- `quantity` (integer, required)
- `price` (decimal, required)

### PUT - Actualizar item
```
PUT http://localhost:8080/invoice-item/10
Content-Type: application/json

{
  "invoiceId": 1,
  "itemId": 1,
  "quantity": 5,
  "price": 100000.00
}
```

### DELETE - Eliminar item
```
DELETE http://localhost:8080/invoice-item/10
```

---

## NOTAS IMPORTANTES:

1. **Integridad Referencial**: Al crear registros, asegúrate de que existan los IDs referenciados (roleId, stateId, cityId, etc.)

2. **Orden de Creación Recomendado**:
   - Roles
   - Estados
   - Ciudades
   - Usuarios
   - Organizaciones
   - Sucursales
   - Personas
   - Empleados
   - Marcas
   - Categorías
   - Items de Inventario
   - Órdenes de Venta
   - Items de Orden
   - Facturas
   - Items de Factura

3. **Validaciones**:
   - Los campos marcados con * son obligatorios
   - Los precios deben ser números positivos
   - Las fechas deben estar en formato "YYYY-MM-DD"

4. **Códigos de Respuesta HTTP**:
   - 200 OK: Operación exitosa (GET, PUT)
   - 201 Created: Recurso creado (POST)
   - 204 No Content: Eliminación exitosa (DELETE)
   - 404 Not Found: Recurso no encontrado
   - 400 Bad Request: Error en los datos enviados
