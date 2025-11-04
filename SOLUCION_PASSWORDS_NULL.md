# 🔒 SOLUCIÓN AL PROBLEMA DE CONTRASEÑAS NULL

## 🐛 PROBLEMA IDENTIFICADO

Cuando actualizabas usuarios mediante PUT `/users/{id}`, las contraseñas se guardaban como NULL en la base de datos y no aparecían en las respuestas GET.

### Causas:

1. **`@JsonIgnore` en el campo password**: Impedía que Jackson deserializara (leyera) el campo password del JSON entrante, por lo que siempre era NULL.
2. **Falta de encriptación automática**: El controlador guardaba la contraseña en texto plano sin usar BCrypt.
3. **Contraseñas ya dañadas**: Los usuarios que actualizaste tenían password = NULL en la BD.

---

## ✅ SOLUCIONES IMPLEMENTADAS

### 1️⃣ Cambio de `@JsonIgnore` a `@JsonProperty(access = WRITE_ONLY)`

**Archivo:** `User.java`

```java
// ANTES (mal):
@JsonIgnore
@Column(nullable = false, length = 200)
private String password;

// AHORA (correcto):
@JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
@Column(nullable = false, length = 200)
private String password;
```

**Diferencia:**
- `@JsonIgnore`: Ignora el campo en LECTURA y ESCRITURA (no lo lee del JSON ni lo devuelve)
- `@JsonProperty(access = WRITE_ONLY)`: Solo permite ESCRITURA (lee del JSON pero NO lo devuelve)

**Resultado:**
✅ Ahora puedes enviar `password` en el JSON del PUT/POST
✅ La contraseña NO aparece en las respuestas GET (seguridad)

---

### 2️⃣ Encriptación Automática en el UserController

**Archivo:** `UserController.java`

#### POST - Crear Usuario
```java
@PostMapping
public ResponseEntity<User> createUser(@RequestBody User user) {
    // Encriptar contraseña antes de guardar
    if (user.getPassword() != null && !user.getPassword().isEmpty()) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
    }
    User savedUser = usuarioRepository.save(user);
    return ResponseEntity.status(HttpStatus.CREATED).body(savedUser);
}
```

#### PUT - Actualizar Usuario
```java
@PutMapping("/{id}")
public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User userDetails) {
    return usuarioRepository.findById(id)
      .map(user -> {
        user.setUsername(userDetails.getUsername());
        
        // Solo actualizar contraseña si se envió una nueva
        if (userDetails.getPassword() != null && !userDetails.getPassword().isEmpty()) {
          // Verificar si ya está encriptada (empieza con $2a$)
          if (!userDetails.getPassword().startsWith("$2a$")) {
            user.setPassword(passwordEncoder.encode(userDetails.getPassword()));
          }
        }
        
        user.setRoleId(userDetails.getRoleId());
        return ResponseEntity.ok(usuarioRepository.save(user));
      })
      .orElse(ResponseEntity.notFound().build());
}
```

**Características:**
- ✅ Encripta automáticamente con BCrypt
- ✅ Detecta si ya está encriptada (evita doble encriptación)
- ✅ Permite actualizar sin cambiar la contraseña (no envíes el campo)

---

### 3️⃣ Reparación de Contraseñas NULL

**Script ejecutado:** `DatabaseMigration.java`

```sql
UPDATE users 
SET password = '$2a$10$N9qo8uLOickgx2ZZ.wu0BuO8X7F7tNe4UJKmHzOWPIzmPzk0HVlQi' 
WHERE password IS NULL;
```

**Resultado:**
✅ Todos los usuarios con contraseña NULL ahora tienen la contraseña `admin123` encriptada.

---

## 🎯 CÓMO USAR AHORA

### 📝 Crear Usuario (POST)

**URL:** `POST http://localhost:8080/users`

**Body:**
```json
{
    "username": "nuevo_usuario",
    "password": "miContraseña123",
    "roleId": 1
}
```

**Resultado:**
- La contraseña se encripta automáticamente con BCrypt
- Se guarda en la BD como: `$2a$10$...`
- En la respuesta NO aparece el campo password (seguridad)

---

### ✏️ Actualizar Usuario (PUT)

#### Opción A: Cambiar contraseña
**URL:** `PUT http://localhost:8080/users/1`

**Body:**
```json
{
    "username": "admin",
    "password": "nuevaContraseña456",
    "roleId": 1
}
```

**Resultado:**
- La nueva contraseña se encripta automáticamente
- Se actualiza en la BD

#### Opción B: NO cambiar contraseña
**Body:**
```json
{
    "username": "admin",
    "roleId": 1
}
```

**Resultado:**
- Solo actualiza username y roleId
- La contraseña NO se modifica (queda la anterior)

---

### 🔍 Obtener Usuario (GET)

**URL:** `GET http://localhost:8080/users/1`

**Respuesta:**
```json
{
    "id": 1,
    "username": "admin",
    "roleId": 1,
    "enabled": true,
    "accountNonExpired": true,
    "accountNonLocked": true,
    "credentialsNonExpired": true,
    "lastLogin": "2025-10-30T21:00:00",
    "createdAt": "2025-10-30T10:00:00"
}
```

**⚠️ NOTA:** El campo `password` NO aparece (es correcto por seguridad)

---

## 🔐 ESTADO ACTUAL DE CONTRASEÑAS

Todos los usuarios en tu BD ahora tienen contraseña encriptada:

| Usuario | Contraseña | Contraseña Encriptada (en BD) |
|---------|-----------|-------------------------------|
| admin | `admin123` | `$2a$10$N9qo8uLOickgx2ZZ...` |
| gerente1 | `admin123` | `$2a$10$N9qo8uLOickgx2ZZ...` |
| vendedor1 | `admin123` | `$2a$10$N9qo8uLOickgx2ZZ...` |
| vendedor2 | `admin123` | `$2a$10$N9qo8uLOickgx2ZZ...` |
| cajero1 | `admin123` | `$2a$10$N9qo8uLOickgx2ZZ...` |
| almacenero1 | `admin123` | `$2a$10$N9qo8uLOickgx2ZZ...` |
| test_user_actualizado | (ya estaba encriptada) | `$2a$10$8OAUP...` |

---

## 🧪 PRUEBAS

### 1. Login con Postman
```
POST http://localhost:8080/api/auth/login
{
    "username": "admin",
    "password": "admin123"
}
```

**Resultado esperado:** ✅ Token JWT generado

---

### 2. Actualizar Contraseña
```
PUT http://localhost:8080/users/1
Headers: Authorization: Bearer <TOKEN>
{
    "username": "admin",
    "password": "miNuevaContraseña",
    "roleId": 1
}
```

**Resultado esperado:** 
✅ Respuesta 200 OK
✅ En PostgreSQL: contraseña encriptada `$2a$10$...`
✅ Puedes hacer login con la nueva contraseña

---

### 3. Verificar que NO se devuelve la contraseña
```
GET http://localhost:8080/users/1
Headers: Authorization: Bearer <TOKEN>
```

**Resultado esperado:**
✅ El campo `password` NO aparece en la respuesta (correcto)

---

## 📊 COMPARACIÓN ANTES/DESPUÉS

| Aspecto | ANTES ❌ | AHORA ✅ |
|---------|---------|---------|
| Enviar password en PUT | No funcionaba (NULL) | Funciona correctamente |
| Encriptación automática | No | Sí (BCrypt) |
| Password en respuesta GET | No aparecía | Sigue sin aparecer (correcto) |
| Seguridad | Baja (contraseñas NULL) | Alta (todas encriptadas) |
| Login funcional | ❌ Con usuarios NULL | ✅ Todos funcionan |

---

## ⚠️ IMPORTANTE

1. **Nunca envíes contraseñas ya encriptadas** (que empiecen con `$2a$`) en PUT/POST a menos que sepas lo que haces.

2. **La contraseña temporal** de todos los usuarios afectados es `admin123`. Cámbialas después.

3. **Para cambiar tu propia contraseña**, haz:
   ```
   PUT http://localhost:8080/users/TU_ID
   {
       "username": "tu_usuario",
       "password": "tu_nueva_contraseña",
       "roleId": TU_ROLE_ID
   }
   ```

4. **El campo password es opcional en PUT**: Si no lo envías, no se modifica.

---

## ✅ CHECKLIST DE VERIFICACIÓN

- [x] Campo password con `@JsonProperty(access = WRITE_ONLY)`
- [x] UserController encripta passwords en POST
- [x] UserController encripta passwords en PUT
- [x] Contraseñas NULL reparadas en BD
- [x] Password NO aparece en respuestas GET
- [x] Login funciona correctamente
- [x] Actualización de usuarios funciona sin resetear password
