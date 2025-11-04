# 🧪 GUÍA DE PRUEBAS DEL SISTEMA JWT - PASO A PASO

## 📋 PREPARACIÓN

### Requisitos:
- ✅ Aplicación corriendo en `http://localhost:8080`
- ✅ Postman instalado
- ✅ Base de datos con usuarios y contraseñas encriptadas

### Usuarios disponibles para pruebas:
| Usuario | Contraseña | Rol | Descripción |
|---------|-----------|-----|-------------|
| `admin` | `admin123` | ADMINISTRADOR | Acceso completo |
| `gerente1` | `admin123` | GERENTE | Acceso limitado |
| `vendedor1` | `admin123` | VENDEDOR | Solo lectura |

---

## 🎯 PRUEBA 1: LOGIN EXITOSO

### Paso 1.1 - Login con Admin

**En Postman:**
```
POST http://localhost:8080/api/auth/login
```

**Headers:**
```
Content-Type: application/json
```

**Body (raw JSON):**
```json
{
    "username": "admin",
    "password": "admin123"
}
```

**Click en:** `Send`

### ✅ Resultado Esperado:
```json
{
    "token": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTY5ODc2ODk...",
    "type": "Bearer",
    "id": 1,
    "username": "admin",
    "roleName": "ADMINISTRADOR",
    "permissions": [
        "CREATE_USER",
        "READ_USER",
        "UPDATE_USER",
        "DELETE_USER",
        "VIEW_DASHBOARD",
        "MANAGE_PERMISSIONS",
        ...
    ]
}
```

**Status:** `200 OK`

### 📝 Verificaciones:
- [ ] Status code es 200
- [ ] El campo `token` contiene un JWT largo
- [ ] El campo `username` es "admin"
- [ ] El campo `roleName` es "ADMINISTRADOR"
- [ ] El array `permissions` contiene múltiples permisos
- [ ] El campo `type` es "Bearer"

### 🎯 Acción Importante:
**COPIA EL TOKEN COMPLETO** - Lo necesitarás para las siguientes pruebas.

---

## 🎯 PRUEBA 2: OBTENER INFORMACIÓN DEL USUARIO ACTUAL

### Paso 2.1 - Endpoint /api/auth/me

**En Postman:**
```
GET http://localhost:8080/api/auth/me
```

**Headers:**
```
Authorization: Bearer <PEGA_AQUI_TU_TOKEN>
```

**Ejemplo completo del header:**
```
Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTY5ODc2ODk2OSwi...
```

**Click en:** `Send`

### ✅ Resultado Esperado:
```json
{
    "id": 1,
    "username": "admin",
    "roleName": "ADMINISTRADOR",
    "permissions": [
        "CREATE_USER",
        "DELETE_USER",
        ...
    ],
    "enabled": true,
    "accountNonExpired": true,
    "accountNonLocked": true,
    "credentialsNonExpired": true,
    "lastLogin": "2025-10-30T21:45:00",
    "createdAt": "2025-10-30T10:00:00"
}
```

**Status:** `200 OK`

### 📝 Verificaciones:
- [ ] Status code es 200
- [ ] El campo `password` NO aparece (seguridad)
- [ ] El campo `lastLogin` tiene la fecha de tu último login
- [ ] Los campos de cuenta están en `true`

---

## 🎯 PRUEBA 3: VERIFICAR PERMISOS ESPECÍFICOS

### Paso 3.1 - Verificar si tiene permiso CREATE_USER

**En Postman:**
```
GET http://localhost:8080/api/auth/check-permission/CREATE_USER
```

**Headers:**
```
Authorization: Bearer <TU_TOKEN>
```

**Click en:** `Send`

### ✅ Resultado Esperado:
```
true
```

**Status:** `200 OK`

### Paso 3.2 - Verificar permiso que NO tiene

```
GET http://localhost:8080/api/auth/check-permission/PERMISO_INEXISTENTE
```

### ✅ Resultado Esperado:
```
false
```

---

## 🎯 PRUEBA 4: ACCEDER A ENDPOINTS PROTEGIDOS

### Paso 4.1 - Listar Clientes (requiere autenticación)

**En Postman:**
```
GET http://localhost:8080/api/clientes
```

**Headers:**
```
Authorization: Bearer <TU_TOKEN>
```

**Click en:** `Send`

### ✅ Resultado Esperado:
- **Status:** `200 OK`
- **Body:** Array con lista de clientes (puede estar vacío `[]`)

### 📝 Verificaciones:
- [ ] Con token funciona (200 OK)
- [ ] Sin token retorna 403 Forbidden

### Prueba NEGATIVA - Sin Token:
**Quita el header Authorization y envía nuevamente**

### ❌ Resultado Esperado:
- **Status:** `403 Forbidden`

---

## 🎯 PRUEBA 5: PANEL ADMINISTRATIVO (Solo ADMIN)

### Paso 5.1 - Ver Logs de Auditoría

**En Postman:**
```
GET http://localhost:8080/api/admin/activity-logs
```

**Headers:**
```
Authorization: Bearer <TU_TOKEN_DE_ADMIN>
```

**Click en:** `Send`

### ✅ Resultado Esperado:
```json
[
    {
        "id": 1,
        "userId": 1,
        "action": "LOGIN",
        "entity": "User",
        "entityId": 1,
        "description": "Usuario admin inició sesión",
        "ipAddress": "127.0.0.1",
        "createdAt": "2025-10-30T21:45:00"
    }
]
```

**Status:** `200 OK`

### 📝 Verificaciones:
- [ ] Se ve el log de tu login reciente
- [ ] El campo `action` es "LOGIN"
- [ ] El campo `userId` corresponde al ID del usuario admin

---

### Paso 5.2 - Listar Todos los Permisos

**En Postman:**
```
GET http://localhost:8080/api/admin/permissions
```

**Headers:**
```
Authorization: Bearer <TU_TOKEN_DE_ADMIN>
```

### ✅ Resultado Esperado:
```json
[
    {
        "id": 1,
        "name": "CREATE_USER",
        "description": "Crear usuarios",
        "module": "USER",
        "createdAt": "2025-10-30T21:00:00"
    },
    {
        "id": 2,
        "name": "READ_USER",
        "description": "Ver usuarios",
        "module": "USER",
        "createdAt": "2025-10-30T21:00:00"
    },
    ...
]
```

**Status:** `200 OK`

### 📝 Verificaciones:
- [ ] Aparecen 64 permisos
- [ ] Cada permiso tiene: id, name, description, module
- [ ] Los módulos incluyen: USER, CLIENT, PRODUCT, ORDER, etc.

---

## 🎯 PRUEBA 6: RESTRICCIÓN DE ROL (Debe Fallar)

### Paso 6.1 - Login como Gerente

**En Postman:**
```
POST http://localhost:8080/api/auth/login
```

**Body:**
```json
{
    "username": "gerente1",
    "password": "admin123"
}
```

**Guarda el nuevo token del gerente**

---

### Paso 6.2 - Intentar acceder al panel admin

**En Postman:**
```
GET http://localhost:8080/api/admin/activity-logs
```

**Headers:**
```
Authorization: Bearer <TOKEN_DEL_GERENTE>
```

### ❌ Resultado Esperado:
**Status:** `403 Forbidden`

**Body:**
```json
{
    "timestamp": "2025-10-30T21:50:00",
    "status": 403,
    "error": "Forbidden",
    "path": "/api/admin/activity-logs"
}
```

### 📝 Verificación:
- [ ] El gerente NO puede acceder a endpoints de admin
- [ ] Retorna 403 Forbidden

---

## 🎯 PRUEBA 7: TOKEN INVÁLIDO (Debe Fallar)

### Paso 7.1 - Token Falso

**En Postman:**
```
GET http://localhost:8080/api/clientes
```

**Headers:**
```
Authorization: Bearer token_inventado_12345
```

### ❌ Resultado Esperado:
**Status:** `403 Forbidden`

### 📝 Verificación:
- [ ] No permite acceso con token inválido

---

## 🎯 PRUEBA 8: GESTIÓN DE USUARIOS

### Paso 8.1 - Crear Usuario (con token de admin)

**En Postman:**
```
POST http://localhost:8080/users
```

**Headers:**
```
Authorization: Bearer <TOKEN_DE_ADMIN>
Content-Type: application/json
```

**Body:**
```json
{
    "username": "prueba_usuario",
    "password": "password123",
    "roleId": 2
}
```

### ✅ Resultado Esperado:
```json
{
    "id": 8,
    "username": "prueba_usuario",
    "roleId": 2,
    "enabled": true,
    "accountNonExpired": true,
    "accountNonLocked": true,
    "credentialsNonExpired": true
}
```

**Status:** `201 Created`

### 📝 Verificaciones:
- [ ] Status es 201 Created
- [ ] El campo `password` NO aparece en la respuesta
- [ ] El usuario se creó con contraseña encriptada
- [ ] El usuario tiene `enabled: true`

---

### Paso 8.2 - Verificar que la contraseña se encriptó

**En PostgreSQL:**
```sql
SELECT id, username, password, role_id FROM users WHERE username = 'prueba_usuario';
```

### ✅ Resultado Esperado:
- La contraseña debe empezar con `$2a$10$...` (BCrypt)
- NO debe ser `password123` en texto plano

---

### Paso 8.3 - Login con el nuevo usuario

**En Postman:**
```
POST http://localhost:8080/api/auth/login
```

**Body:**
```json
{
    "username": "prueba_usuario",
    "password": "password123"
}
```

### ✅ Resultado Esperado:
**Status:** `200 OK`
- Retorna token JWT
- Login exitoso con la contraseña que creaste

---

### Paso 8.4 - Actualizar contraseña del usuario

**En Postman:**
```
PUT http://localhost:8080/users/8
```

**Headers:**
```
Authorization: Bearer <TOKEN_DE_ADMIN>
Content-Type: application/json
```

**Body:**
```json
{
    "username": "prueba_usuario",
    "password": "nuevaPassword456",
    "roleId": 2
}
```

### ✅ Resultado Esperado:
**Status:** `200 OK`

---

### Paso 8.5 - Login con la nueva contraseña

**En Postman:**
```
POST http://localhost:8080/api/auth/login
```

**Body:**
```json
{
    "username": "prueba_usuario",
    "password": "nuevaPassword456"
}
```

### ✅ Resultado Esperado:
**Status:** `200 OK`
- Login exitoso con la nueva contraseña

### Paso 8.6 - Intentar login con contraseña antigua

**Body:**
```json
{
    "username": "prueba_usuario",
    "password": "password123"
}
```

### ❌ Resultado Esperado:
**Status:** `401 Unauthorized` o `403 Forbidden`
- La contraseña antigua ya no funciona

---

## 🎯 PRUEBA 9: ASIGNAR/REMOVER PERMISOS (Solo Admin)

### Paso 9.1 - Ver permisos actuales de un rol

**En Postman:**
```
GET http://localhost:8080/api/admin/permissions/role/2
```

**Headers:**
```
Authorization: Bearer <TOKEN_DE_ADMIN>
```

**Guarda la respuesta** - verás los permisos actuales del rol GERENTE

---

### Paso 9.2 - Asignar nuevo permiso

**En Postman:**
```
POST http://localhost:8080/api/admin/permissions/assign?roleId=2&permissionId=10
```

**Headers:**
```
Authorization: Bearer <TOKEN_DE_ADMIN>
```

### ✅ Resultado Esperado:
**Status:** `200 OK`
**Body:** `"Permission assigned successfully"`

---

### Paso 9.3 - Verificar que se asignó

**Vuelve a ejecutar:**
```
GET http://localhost:8080/api/admin/permissions/role/2
```

### ✅ Resultado Esperado:
- Ahora aparece el permiso con ID 10 en la lista

---

### Paso 9.4 - Remover el permiso

**En Postman:**
```
DELETE http://localhost:8080/api/admin/permissions/remove?roleId=2&permissionId=10
```

**Headers:**
```
Authorization: Bearer <TOKEN_DE_ADMIN>
```

### ✅ Resultado Esperado:
**Status:** `200 OK`
**Body:** `"Permission removed successfully"`

---

## 📊 CHECKLIST COMPLETO DE PRUEBAS

### Autenticación:
- [ ] Login exitoso con credenciales correctas
- [ ] Login fallido con credenciales incorrectas
- [ ] Token JWT se genera correctamente
- [ ] Token se puede usar en siguientes peticiones
- [ ] Endpoint `/api/auth/me` retorna datos del usuario
- [ ] Verificación de permisos funciona

### Seguridad:
- [ ] Sin token retorna 403 Forbidden
- [ ] Token inválido retorna 403 Forbidden
- [ ] Usuario sin rol ADMIN no puede acceder a `/api/admin/**`
- [ ] Contraseñas NO aparecen en respuestas GET
- [ ] Contraseñas se encriptan automáticamente en POST/PUT

### Panel Administrativo:
- [ ] Admin puede ver logs de auditoría
- [ ] Admin puede ver todos los permisos
- [ ] Admin puede asignar permisos a roles
- [ ] Admin puede remover permisos de roles
- [ ] No admin NO puede acceder a estos endpoints

### Gestión de Usuarios:
- [ ] Crear usuario encripta contraseña automáticamente
- [ ] Actualizar usuario con nueva contraseña funciona
- [ ] Actualizar usuario sin password no cambia la contraseña
- [ ] Login funciona después de actualizar contraseña
- [ ] Contraseña antigua deja de funcionar después de actualizar

### Audit Logs:
- [ ] Login genera entrada en activity_logs
- [ ] Los logs muestran: usuario, acción, timestamp, IP

---

## 🔧 IMPORTAR COLECCIÓN EN POSTMAN

1. Abre Postman
2. Clic en **Import**
3. Arrastra el archivo `Postman_Collection_JWT_Tests.json`
4. La colección aparecerá con todas las pruebas organizadas
5. Las variables `token`, `userId`, `username` se configuran automáticamente al hacer login

---

## 🎬 ORDEN RECOMENDADO DE PRUEBAS

1. ✅ **PRUEBA 1** - Login exitoso (guarda el token)
2. ✅ **PRUEBA 2** - Obtener usuario actual
3. ✅ **PRUEBA 3** - Verificar permisos
4. ✅ **PRUEBA 4** - Acceder a endpoints protegidos
5. ✅ **PRUEBA 5** - Panel administrativo
6. ✅ **PRUEBA 6** - Restricción de rol (login como gerente)
7. ✅ **PRUEBA 7** - Token inválido
8. ✅ **PRUEBA 8** - Gestión de usuarios
9. ✅ **PRUEBA 9** - Asignar/remover permisos

---

## 🐛 ERRORES COMUNES Y SOLUCIONES

### Error: 403 Forbidden
**Causa:** Token no válido o expirado
**Solución:** Haz login nuevamente y obtén un token nuevo

### Error: 401 Unauthorized
**Causa:** Credenciales incorrectas
**Solución:** Verifica username y password

### Error: El password aparece como NULL en la BD
**Causa:** Ya no debería pasar (está solucionado)
**Solución:** Ejecuta `DatabaseMigration` nuevamente

### Error: No puedo acceder a /api/admin/*
**Causa:** No tienes rol ADMINISTRADOR
**Solución:** Haz login con usuario `admin`

---

## 📈 PRÓXIMOS PASOS

Una vez completadas todas las pruebas:
1. [ ] Crear frontend en Angular
2. [ ] Implementar guards en Angular para proteger rutas
3. [ ] Crear interceptor HTTP para agregar token automáticamente
4. [ ] Diseñar dashboard administrativo visual
5. [ ] Implementar gestión de permisos desde la UI
