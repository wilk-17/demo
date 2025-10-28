# 📖 GUÍA RÁPIDA: Cómo hacer POST en Postman

## ✅ Ejemplo: Crear un Rol

### Paso 1: Configurar la Petición

1. **Abrir Postman**
2. **Crear nueva petición** (Click en "+" o "New Request")
3. **Configurar método y URL**:
   - Método: `POST` (seleccionar del dropdown)
   - URL: `http://localhost:8080/role`

### Paso 2: Configurar Headers (Encabezados)

1. Click en la pestaña **"Headers"**
2. Agregar el siguiente header:
   - Key: `Content-Type`
   - Value: `application/json`

**Nota**: Esto le indica al servidor que estamos enviando datos en formato JSON.

### Paso 3: Configurar Body (Cuerpo de la Petición)

1. Click en la pestaña **"Body"**
2. Seleccionar **"raw"** (radio button)
3. En el dropdown de la derecha, seleccionar **"JSON"**
4. Escribir el JSON en el área de texto:

```json
{
  "name": "Supervisor"
}
```

**✨ IMPORTANTE**: Role solo tiene un campo `name`. NO incluir `description` ni otros campos que no existan en el modelo.

### Paso 4: Enviar la Petición

1. Click en el botón azul **"Send"**
2. Esperar la respuesta

### Paso 5: Verificar la Respuesta

**Respuesta Exitosa (201 Created)**:
```json
{
  "id": 6,
  "name": "Supervisor"
}
```

**Respuesta de Error (400 Bad Request)**:
```json
{
  "timestamp": "2025-10-28T...",
  "status": 400,
  "error": "Bad Request",
  "path": "/role"
}
```

---

## 📋 CAMPOS POR MODELO (Para POST)

### 1. Role - `/role`
```json
{
  "name": "Nombre del rol"
}
```
- ✅ `name` - string, requerido, único

---

### 2. User - `/users`
```json
{
  "username": "usuario123",
  "password": "password123",
  "roleId": 1
}
```
- ✅ `username` - string, requerido, único
- ✅ `password` - string, requerido
- ✅ `roleId` - número (ID de rol existente)

---

### 3. State - `/state`
```json
{
  "description": "Nombre del Estado",
  "code": "COD"
}
```
- ✅ `description` - string, requerido
- ✅ `code` - string, único (ej: "ANT", "BOG")

---

### 4. City - `/city`
```json
{
  "description": "Nombre de la Ciudad",
  "code": "CIU",
  "stateId": 1
}
```
- ✅ `description` - string, requerido
- ✅ `code` - string, único
- ✅ `stateId` - número (ID de estado existente)

---

### 5. Organization - `/api/organizations`
```json
{
  "historicalName": "Empresa XYZ S.A.",
  "currentName": "Grupo XYZ"
}
```
- ✅ `historicalName` - string, requerido
- ✅ `currentName` - string, requerido

---

### 6. Branch - `/branch`
```json
{
  "organizationId": 1,
  "cityId": 1
}
```
- ✅ `organizationId` - número (ID de organización existente)
- ✅ `cityId` - número (ID de ciudad existente)

---

### 7. Person - `/person`
```json
{
  "dni": "1234567890",
  "firstName": "Juan",
  "lastName": "Pérez",
  "address": "Calle 123",
  "phone": "3001234567",
  "cityId": 1
}
```
- ✅ `dni` - string, único (opcional)
- ✅ `firstName` - string, requerido
- ✅ `lastName` - string, requerido
- ⚪ `address` - string, opcional
- ⚪ `phone` - string, opcional
- ⚪ `cityId` - número, opcional

---

### 8. Employee - `/employee`
```json
{
  "firstName": "María",
  "lastName": "González",
  "email": "maria@empresa.com",
  "phone": "3101234567",
  "position": "Vendedor",
  "hireDate": "2025-01-15",
  "salary": 2500000.00,
  "branchId": 1,
  "status": "active"
}
```
- ✅ `firstName` - string, requerido
- ✅ `lastName` - string, requerido
- ✅ `email` - string, único, requerido
- ✅ `position` - string, requerido
- ✅ `hireDate` - fecha "YYYY-MM-DD", requerido
- ✅ `branchId` - número, requerido
- ⚪ `phone` - string, opcional
- ⚪ `salary` - decimal, opcional
- ⚪ `status` - string, default "active"

---

### 9. Brand - `/brand`
```json
{
  "name": "Samsung",
  "description": "Marca de electrónica"
}
```
- ✅ `name` - string, requerido, único
- ⚪ `description` - string, opcional

---

### 10. ItemCategory - `/category`
```json
{
  "name": "Electrónica"
}
```
- ✅ `name` - string, requerido

**Nota**: ItemCategory solo tiene el campo `name`, NO tiene description

---

### 11. InventoryItem - `/inventory`
```json
{
  "name": "Laptop HP",
  "description": "Laptop HP Core i7",
  "quantity": 10,
  "price": 3500000.00,
  "categoryId": 1,
  "brandId": 1
}
```
- ✅ `name` - string, requerido
- ✅ `price` - decimal, requerido
- ⚪ `description` - string, opcional
- ⚪ `quantity` - número, default 0
- ⚪ `categoryId` - número, opcional
- ⚪ `brandId` - número, opcional

---

### 12. SalesOrder - `/sales-order`
```json
{
  "customerName": "Pedro García",
  "orderDate": "2025-10-28",
  "total": 500000.00,
  "status": "pending",
  "employeeId": 1
}
```
- ✅ `customerName` - string, requerido
- ✅ `orderDate` - fecha "YYYY-MM-DD", requerido
- ⚪ `total` - decimal, default 0.00
- ⚪ `status` - string, default "pending"
- ⚪ `employeeId` - número, opcional
- ⚪ `quoteId` - número, opcional

---

### 13. SalesOrderItem - `/sales-order-item`
```json
{
  "salesOrderId": 1,
  "itemId": 1,
  "quantity": 5
}
```
- ✅ `salesOrderId` - número, requerido
- ✅ `itemId` - número, requerido
- ✅ `quantity` - número, requerido

---

### 14. Invoice - `/invoice`
```json
{
  "customerName": "Laura Martínez",
  "invoiceDate": "2025-10-28",
  "total": 300000.00,
  "employeeId": 1,
  "salesOrderId": 1
}
```
- ✅ `customerName` - string, requerido
- ✅ `invoiceDate` - fecha "YYYY-MM-DD", requerido
- ⚪ `total` - decimal, default 0.00
- ⚪ `employeeId` - número, opcional
- ⚪ `salesOrderId` - número, opcional

---

### 15. InvoiceItem - `/invoice-item`
```json
{
  "invoiceId": 1,
  "itemId": 1,
  "quantity": 3,
  "price": 100000.00
}
```
- ✅ `invoiceId` - número, requerido
- ✅ `itemId` - número, requerido
- ✅ `quantity` - número, requerido
- ✅ `price` - decimal, requerido

---

## 🚨 ERRORES COMUNES Y SOLUCIONES

### Error 400 Bad Request
**Causa**: Datos inválidos o campos incorrectos
**Solución**: 
- Verificar que todos los campos requeridos estén presentes
- No incluir campos que no existen en el modelo
- Verificar tipos de datos (números sin comillas, strings con comillas)

### Error 404 Not Found
**Causa**: URL incorrecta
**Solución**: Verificar que la URL sea exacta

### Error 500 Internal Server Error
**Causa**: Violación de integridad referencial
**Solución**: 
- Asegurarse que los IDs referenciados existen (roleId, stateId, etc.)
- Verificar que no estés duplicando valores únicos (username, email, dni)

### Error 409 Conflict
**Causa**: Valor único duplicado
**Solución**: Cambiar el valor del campo único (name, email, dni, etc.)

---

## 💡 TIPS IMPORTANTES

1. **Siempre configura Content-Type: application/json** en Headers
2. **Usa "raw" y "JSON"** en Body
3. **No incluyas el campo `id`** al crear (se genera automáticamente)
4. **Verifica que existan los IDs** antes de referenciarlos
5. **Formato de fechas**: siempre "YYYY-MM-DD"
6. **Números decimales**: usa punto (.) no coma (,)
7. **Strings**: siempre entre comillas dobles
8. **Booleanos**: true/false sin comillas

---

## 🔄 SECUENCIA RECOMENDADA DE PRUEBAS

Para evitar errores de integridad referencial, crea en este orden:

1. **Roles** → No depende de nadie
2. **Estados** → No depende de nadie
3. **Ciudades** → Necesita stateId
4. **Usuarios** → Necesita roleId
5. **Organizaciones** → No depende de nadie
6. **Sucursales** → Necesita organizationId, cityId
7. **Marcas** → No depende de nadie
8. **Categorías** → No depende de nadie
9. **Personas** → Opcional cityId
10. **Empleados** → Necesita branchId
11. **Inventario** → Opcional categoryId, brandId
12. **Órdenes** → Opcional employeeId
13. **Items Orden** → Necesita salesOrderId, itemId
14. **Facturas** → Opcional employeeId, salesOrderId
15. **Items Factura** → Necesita invoiceId, itemId
