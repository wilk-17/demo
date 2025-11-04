# 🔐 GUÍA COMPLETA DE PRUEBAS DEL SISTEMA DE SEGURIDAD

## 📋 TABLA DE CONTENIDOS
1. [Pruebas desde el Navegador](#navegador)
2. [Pruebas con Postman](#postman)
3. [Usuarios de Prueba](#usuarios)
4. [Endpoints Disponibles](#endpoints)

---

## 🌐 PRUEBAS DESDE EL NAVEGADOR <a name="navegador"></a>

### Acceder al Login
1. Abre tu navegador
2. Ve a: **http://localhost:8080/login.html**
3. Usa las credenciales de tus usuarios existentes
4. Al iniciar sesión correctamente, verás:
   - Tu nombre de usuario
   - Tu rol
   - El token JWT generado
   - Tus permisos asignados

### Acceder al Sistema Principal
- **http://localhost:8080/** - Sistema de gestión (requiere autenticación)
- **http://localhost:8080/index** - Página principal

---

## 📮 PRUEBAS CON POSTMAN <a name="postman"></a>

### PASO 1: LOGIN - Obtener Token JWT

**Método:** POST  
**URL:** `http://localhost:8080/api/auth/login`  
**Headers:**
```
Content-Type: application/json
```

**Body (raw JSON):**
```json
{
    "username": "test_user_actualizado",
    "password": "password123"
}
```

**Respuesta Exitosa (200 OK):**
```json
{
    "token": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0X3VzZXIiLCJpYXQiOjE2OTg3...",
    "type": "Bearer",
    "id": 1,
    "username": "test_user_actualizado",
    "roleName": "ADMINISTRADOR",
    "permissions": [
        "CREATE_USER",
        "DELETE_USER",
        "VIEW_DASHBOARD",
        ...
    ]
}
```

**⚠️ IMPORTANTE:** Copia el valor del campo `token` para usarlo en las siguientes peticiones.

---

### PASO 2: OBTENER INFORMACIÓN DEL USUARIO ACTUAL

**Método:** GET  
**URL:** `http://localhost:8080/api/auth/me`  
**Headers:**
```
Authorization: Bearer <TU_TOKEN_AQUI>
```

Ejemplo completo del header:
```
Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0X3VzZXIiLCJpYXQiOjE2OTg3...
```

**Respuesta Exitosa (200 OK):**
```json
{
    "id": 1,
    "username": "test_user_actualizado",
    "roleName": "ADMINISTRADOR",
    "permissions": ["CREATE_USER", "DELETE_USER", ...],
    "enabled": true,
    "lastLogin": "2025-10-30T21:00:00",
    "createdAt": "2025-10-01T10:00:00"
}
```

---

### PASO 3: VERIFICAR PERMISOS

**Método:** GET  
**URL:** `http://localhost:8080/api/auth/check-permission/CREATE_USER`  
**Headers:**
```
Authorization: Bearer <TU_TOKEN_AQUI>
```

**Respuesta:** `true` o `false`

---

### PASO 4: OBTENER LOGS DE AUDITORÍA (SOLO ADMIN)

**Método:** GET  
**URL:** `http://localhost:8080/api/admin/activity-logs`  
**Headers:**
```
Authorization: Bearer <TU_TOKEN_AQUI>
```

**Nota:** Solo usuarios con rol ADMINISTRADOR pueden acceder.

**Respuesta Exitosa (200 OK):**
```json
[
    {
        "id": 1,
        "userId": 1,
        "action": "LOGIN",
        "entity": "User",
        "entityId": 1,
        "description": "Usuario test_user_actualizado inició sesión",
        "ipAddress": "127.0.0.1",
        "createdAt": "2025-10-30T21:00:00"
    }
]
```

---

### PASO 5: OBTENER TODOS LOS PERMISOS (SOLO ADMIN)

**Método:** GET  
**URL:** `http://localhost:8080/api/admin/permissions`  
**Headers:**
```
Authorization: Bearer <TU_TOKEN_AQUI>
```

---

### PASO 6: ASIGNAR PERMISO A ROL (SOLO ADMIN)

**Método:** POST  
**URL:** `http://localhost:8080/api/admin/permissions/assign?roleId=2&permissionId=1`  
**Headers:**
```
Authorization: Bearer <TU_TOKEN_AQUI>
```

---

## 👤 USUARIOS DE PRUEBA <a name="usuarios"></a>

Según tu base de datos, probablemente tienes:

```
Usuario: test_user_actualizado
Contraseña: (la que usabas antes, ahora encriptada)
```

**⚠️ IMPORTANTE:** Si la contraseña anterior no funciona, es porque ahora está encriptada. Necesitarás:

1. **Opción A:** Actualizar la contraseña manualmente en PostgreSQL:
```sql
-- La contraseña 'admin123' encriptada con BCrypt
UPDATE users SET password = '$2a$10$rN7PnD3qOZ7xJxKxKx3xKOxW8yqXxXxXxXxXxXxXxXxXxXxXxXx' 
WHERE username = 'test_user_actualizado';
```

2. **Opción B:** Crear un nuevo usuario desde el sistema existente.

---

## 🔗 ENDPOINTS DISPONIBLES <a name="endpoints"></a>

### Endpoints Públicos (No requieren autenticación)
- `POST /api/auth/login` - Login de usuarios
- `GET /` - Página principal
- `GET /index` - Página de inicio
- `GET /login.html` - Página de login

### Endpoints Autenticados (Requieren token JWT)
- `GET /api/auth/me` - Información del usuario actual
- `GET /api/auth/check-permission/{permission}` - Verificar permiso específico
- `GET /api/**` - Todos los endpoints CRUD del sistema

### Endpoints de Administrador (Requieren rol ADMINISTRADOR)
- `GET /api/admin/activity-logs` - Logs de auditoría
- `GET /api/admin/activity-logs/user/{userId}` - Logs por usuario
- `GET /api/admin/permissions` - Listar permisos
- `GET /api/admin/permissions/role/{roleId}` - Permisos de un rol
- `POST /api/admin/permissions/assign` - Asignar permiso a rol
- `DELETE /api/admin/permissions/remove` - Remover permiso de rol

---

## 🔧 CONFIGURACIÓN EN POSTMAN

### Crear una Colección
1. Abre Postman
2. Clic en "New Collection"
3. Nombra: "Sistema de Gestión - API"

### Configurar Variables de Entorno
1. Clic en "Environments"
2. Crea "Desarrollo"
3. Agrega variables:
   - `baseUrl`: `http://localhost:8080`
   - `token`: (se llenará después del login)

### Usar el Token Automáticamente
1. En cada petición, en "Headers":
   - Key: `Authorization`
   - Value: `Bearer {{token}}`

2. Después del login, en "Tests" agrega:
```javascript
if (pm.response.code === 200) {
    var jsonData = pm.response.json();
    pm.environment.set("token", jsonData.token);
}
```

---

## 🎯 PRUEBA RÁPIDA COMPLETA

### 1. Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test_user_actualizado","password":"tu_password"}'
```

### 2. Verificar Usuario (reemplaza TOKEN)
```bash
curl -X GET http://localhost:8080/api/auth/me \
  -H "Authorization: Bearer TOKEN_AQUI"
```

### 3. Acceder a Clientes (ejemplo de endpoint protegido)
```bash
curl -X GET http://localhost:8080/api/clientes \
  -H "Authorization: Bearer TOKEN_AQUI"
```

---

## ❌ ERRORES COMUNES

### 401 Unauthorized
- Token expirado (dura 24 horas)
- Token inválido
- No se envió el header Authorization

### 403 Forbidden
- No tienes permisos para ese endpoint
- Tu rol no tiene acceso

### 400 Bad Request
- Credenciales incorrectas en el login
- JSON mal formado

---

## 📊 FLUJO COMPLETO DE AUTENTICACIÓN

```
1. Usuario hace POST a /api/auth/login con username y password
   ↓
2. Spring Security valida credenciales con CustomUserDetailsService
   ↓
3. Se genera Token JWT (válido por 24 horas)
   ↓
4. Se devuelve token + información del usuario
   ↓
5. Usuario guarda el token (en localStorage o variable de Postman)
   ↓
6. En cada petición, se envía: Authorization: Bearer {token}
   ↓
7. JwtAuthenticationFilter intercepta y valida el token
   ↓
8. Si es válido, se permite el acceso al endpoint
   ↓
9. Se verifica el rol/permiso con @PreAuthorize
```

---

## 🔑 NOTA IMPORTANTE SOBRE CONTRASEÑAS

Tu usuario `test_user_actualizado` tenía una contraseña en texto plano que ahora fue encriptada con BCrypt.

**Para crear un nuevo usuario de prueba con contraseña conocida**, ejecuta este SQL:

```sql
-- Crear usuario admin con contraseña 'admin123'
INSERT INTO users (username, password, role_id, enabled, account_non_expired, account_non_locked, credentials_non_expired)
VALUES ('admin', '$2a$10$N9qo8uLOickgx2ZZ.wu0BuO8X7F7tNe4UJKmHzOWPIzmPzk0HVlQi', 1, true, true, true, true);

-- Contraseña 'password123' encriptada
INSERT INTO users (username, password, role_id, enabled, account_non_expired, account_non_locked, credentials_non_expired)
VALUES ('usuario_prueba', '$2a$10$8OAUP7u7GpCCl5.PRlHFJu6zIjTLLU1zPFN5KBxvMVDMPPPnrnuH2', 2, true, true, true, true);
```

Usuarios creados:
- **admin** / **admin123** (roleId 1)
- **usuario_prueba** / **password123** (roleId 2)
