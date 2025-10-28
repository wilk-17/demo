# 📋 REFERENCIA RÁPIDA - Campos de Todos los Modelos

## Tabla de Contenidos
1. [Role](#1-role)
2. [User](#2-user)
3. [State](#3-state)
4. [City](#4-city)
5. [Organization](#5-organization)
6. [Branch](#6-branch)
7. [Person](#7-person)
8. [Employee](#8-employee)
9. [Brand](#9-brand)
10. [ItemCategory](#10-itemcategory)
11. [InventoryItem](#11-inventoryitem)
12. [SalesOrder](#12-salesorder)
13. [SalesOrderItem](#13-salesorderitem)
14. [Invoice](#14-invoice)
15. [InvoiceItem](#15-invoiceitem)

---

## 1. ROLE
**Endpoint**: `/role`  
**Tabla**: `role`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| name | String(120) | Requerido, Único | Nombre del rol |

**Ejemplo JSON**:
```json
{
  "name": "Administrador"
}
```

---

## 2. USER
**Endpoint**: `/users`  
**Tabla**: `users`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| username | String(120) | Requerido, Único | Nombre de usuario |
| password | String(200) | Requerido | Contraseña |
| roleId | Long | Requerido, FK | ID del rol |

**Ejemplo JSON**:
```json
{
  "username": "admin",
  "password": "password123",
  "roleId": 1
}
```

---

## 3. STATE
**Endpoint**: `/state`  
**Tabla**: `state`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| description | String(120) | Requerido | Nombre del estado/departamento |
| code | String(20) | Único | Código del estado |

**Ejemplo JSON**:
```json
{
  "description": "Antioquia",
  "code": "ANT"
}
```

---

## 4. CITY
**Endpoint**: `/city`  
**Tabla**: `city`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| description | String(120) | Requerido | Nombre de la ciudad |
| code | String(20) | Único | Código de la ciudad |
| stateId | Long | Requerido, FK | ID del estado |

**Ejemplo JSON**:
```json
{
  "description": "Medellín",
  "code": "MED",
  "stateId": 1
}
```

---

## 5. ORGANIZATION
**Endpoint**: `/api/organizations`  
**Tabla**: `organization`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| historicalName | String(200) | Requerido | Nombre histórico de la organización |
| currentName | String(200) | Requerido | Nombre actual de la organización |

**Ejemplo JSON**:
```json
{
  "historicalName": "Compañía ABC S.A.",
  "currentName": "Grupo ABC"
}
```

---

## 6. BRANCH
**Endpoint**: `/branch`  
**Tabla**: `branch`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| organizationId | Long | Requerido, FK | ID de la organización |
| cityId | Long | Requerido, FK | ID de la ciudad |

**Ejemplo JSON**:
```json
{
  "organizationId": 1,
  "cityId": 1
}
```

---

## 7. PERSON
**Endpoint**: `/person`  
**Tabla**: `person`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| dni | String(50) | Único | DNI/Cédula |
| firstName | String(120) | Requerido | Primer nombre |
| lastName | String(120) | Requerido | Apellido |
| address | String(200) | Opcional | Dirección |
| phone | String(50) | Opcional | Teléfono |
| cityId | Long | Opcional, FK | ID de la ciudad |

**Ejemplo JSON**:
```json
{
  "dni": "1234567890",
  "firstName": "Juan",
  "lastName": "Pérez",
  "address": "Calle 123 #45-67",
  "phone": "3001234567",
  "cityId": 1
}
```

---

## 8. EMPLOYEE
**Endpoint**: `/employee`  
**Tabla**: `employee`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| firstName | String(100) | Requerido | Primer nombre |
| lastName | String(100) | Requerido | Apellido |
| email | String(100) | Requerido, Único | Email |
| phone | String(20) | Opcional | Teléfono |
| position | String(100) | Requerido | Cargo/posición |
| hireDate | LocalDate | Requerido | Fecha de contratación |
| salary | BigDecimal(10,2) | Opcional | Salario |
| branchId | Long | Requerido, FK | ID de la sucursal |
| status | String(20) | Default: "active" | Estado |
| creationDate | LocalDateTime | Auto | Fecha de creación |
| updateDate | LocalDateTime | Auto | Fecha de actualización |

**Ejemplo JSON**:
```json
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

---

## 9. BRAND
**Endpoint**: `/brand`  
**Tabla**: `brand`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| name | String(100) | Requerido, Único | Nombre de la marca |
| description | String(500) | Opcional | Descripción |
| creationDate | LocalDateTime | Auto | Fecha de creación |

**Ejemplo JSON**:
```json
{
  "name": "Samsung",
  "description": "Marca de electrónica"
}
```

---

## 10. ITEMCATEGORY
**Endpoint**: `/category`  
**Tabla**: `item_category`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| name | String(120) | Requerido | Nombre de la categoría |

**Ejemplo JSON**:
```json
{
  "name": "Electrónica"
}
```

**⚠️ IMPORTANTE**: ItemCategory NO tiene campo `description`

---

## 11. INVENTORYITEM
**Endpoint**: `/inventory`  
**Tabla**: `inventory_item`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| name | String(200) | Requerido | Nombre del producto |
| description | String(200) | Opcional | Descripción |
| quantity | Integer | Default: 0 | Cantidad en stock |
| price | BigDecimal(10,2) | Requerido | Precio |
| categoryId | Long | Opcional, FK | ID de la categoría |
| brandId | Long | Opcional, FK | ID de la marca |

**Ejemplo JSON**:
```json
{
  "name": "Laptop HP Pavilion",
  "description": "Laptop HP Core i7 16GB RAM",
  "quantity": 10,
  "price": 3500000.00,
  "categoryId": 1,
  "brandId": 1
}
```

---

## 12. SALESORDER
**Endpoint**: `/sales-order`  
**Tabla**: `sales_order`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| customerName | String(200) | Requerido | Nombre del cliente |
| orderDate | LocalDate | Requerido | Fecha de la orden |
| total | BigDecimal(12,2) | Default: 0.00 | Total de la orden |
| status | String(20) | Default: "pending" | Estado (pending/completed/cancelled) |
| employeeId | Long | Opcional, FK | ID del empleado vendedor |
| quoteId | Long | Opcional | ID de cotización |
| creationDate | LocalDateTime | Auto | Fecha de creación |
| updateDate | LocalDateTime | Auto | Fecha de actualización |

**Ejemplo JSON**:
```json
{
  "customerName": "Pedro García",
  "orderDate": "2025-10-28",
  "total": 500000.00,
  "status": "pending",
  "employeeId": 1,
  "quoteId": null
}
```

---

## 13. SALESORDERITEM
**Endpoint**: `/sales-order-item`  
**Tabla**: `sales_order_item`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| salesOrderId | Long | Requerido, FK | ID de la orden de venta |
| itemId | Long | Requerido, FK | ID del item de inventario |
| quantity | Integer | Requerido | Cantidad |

**Ejemplo JSON**:
```json
{
  "salesOrderId": 1,
  "itemId": 1,
  "quantity": 5
}
```

---

## 14. INVOICE
**Endpoint**: `/invoice`  
**Tabla**: `invoice`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| customerName | String(200) | Requerido | Nombre del cliente |
| invoiceDate | LocalDate | Requerido | Fecha de la factura |
| total | BigDecimal(12,2) | Default: 0.00 | Total de la factura |
| employeeId | Long | Opcional, FK | ID del empleado cajero |
| salesOrderId | Long | Opcional, FK | ID de la orden de venta |
| creationDate | LocalDateTime | Auto | Fecha de creación |
| updateDate | LocalDateTime | Auto | Fecha de actualización |

**Ejemplo JSON**:
```json
{
  "customerName": "Ana María López",
  "invoiceDate": "2025-10-28",
  "total": 300000.00,
  "employeeId": 1,
  "salesOrderId": 1
}
```

---

## 15. INVOICEITEM
**Endpoint**: `/invoice-item`  
**Tabla**: `invoice_item`

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id | Long | PK, Auto | ID único |
| invoiceId | Long | Requerido, FK | ID de la factura |
| itemId | Long | Requerido, FK | ID del item de inventario |
| quantity | Integer | Requerido | Cantidad |
| price | BigDecimal(10,2) | Requerido | Precio unitario |

**Ejemplo JSON**:
```json
{
  "invoiceId": 1,
  "itemId": 1,
  "quantity": 3,
  "price": 100000.00
}
```

---

## 🔑 RELACIONES (Foreign Keys)

```
User.roleId → Role.id
City.stateId → State.id
Branch.organizationId → Organization.id
Branch.cityId → City.id
Person.cityId → City.id
Employee.branchId → Branch.id
InventoryItem.categoryId → ItemCategory.id
InventoryItem.brandId → Brand.id
SalesOrder.employeeId → Employee.id
SalesOrderItem.salesOrderId → SalesOrder.id
SalesOrderItem.itemId → InventoryItem.id
Invoice.employeeId → Employee.id
Invoice.salesOrderId → SalesOrder.id
InvoiceItem.invoiceId → Invoice.id
InvoiceItem.itemId → InventoryItem.id
```

---

## 📝 NOTAS IMPORTANTES

### Campos que NO existen (errores comunes):
- ❌ Role.description - NO EXISTE (solo name)
- ❌ ItemCategory.description - NO EXISTE (solo name)
- ❌ Person.documentType - NO EXISTE (usar dni)
- ❌ Person.documentNumber - NO EXISTE (usar dni)
- ❌ Person.email - NO EXISTE (solo Employee tiene email)
- ❌ Branch.name - NO EXISTE (solo IDs)
- ❌ Branch.phone - NO EXISTE
- ❌ Branch.address - NO EXISTE
- ❌ InventoryItem.stock - Se llama `quantity`
- ❌ InventoryItem.branchId - NO EXISTE
- ❌ SalesOrder.sellerId - Se llama `employeeId`
- ❌ SalesOrder.customerId - Se llama `customerName` (string)
- ❌ SalesOrder.branchId - NO EXISTE
- ❌ SalesOrderItem.unitPrice - NO EXISTE
- ❌ SalesOrderItem.subtotal - NO EXISTE
- ❌ Invoice.cashierId - Se llama `employeeId`
- ❌ Invoice.customerId - Se llama `customerName` (string)
- ❌ Invoice.paymentMethod - NO EXISTE

### Campos con nombres específicos:
- ✅ State.description (no "name")
- ✅ City.description (no "name")
- ✅ Organization.historicalName y currentName (no "name")
- ✅ Employee.position (no "role")
- ✅ InventoryItem.quantity (no "stock")

### Fechas:
- Formato: `"YYYY-MM-DD"` (ej: "2025-10-28")
- Campos de fecha: hireDate, orderDate, invoiceDate

### Decimales:
- Usar punto (.) no coma (,)
- Ejemplos: 2500000.00, 3.14, 100.50

### Campos automáticos (no incluir en POST):
- id (siempre auto-generado)
- creationDate (auto)
- updateDate (auto)
