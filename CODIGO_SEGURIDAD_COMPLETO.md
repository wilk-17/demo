# 🚀 SCRIPT DE IMPLEMENTACIÓN AUTOMÁTICA - SISTEMA DE SEGURIDAD

Este documento contiene TODO el código necesario para completar el sistema de seguridad.
Ejecuta el script PowerShell al final para generar todos los archivos automáticamente.

---

## 📦 ARCHIVOS A CREAR

### 1. DTOs (Data Transfer Objects)

#### LoginRequest.java
```java
package com.example.demo.dto;

public class LoginRequest {
    private String username;
    private String password;

    public LoginRequest() {}

    public LoginRequest(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
```

#### AuthResponse.java
```java
package com.example.demo.dto;

import java.util.Set;

public class AuthResponse {
    private String token;
    private String type = "Bearer";
    private Long id;
    private String username;
    private String roleName;
    private Set<String> permissions;

    public AuthResponse(String token, Long id, String username, String roleName, Set<String> permissions) {
        this.token = token;
        this.id = id;
        this.username = username;
        this.roleName = roleName;
        this.permissions = permissions;
    }

    // Getters and Setters
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Set<String> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<String> permissions) {
        this.permissions = permissions;
    }
}
```

#### UserDTO.java
```java
package com.example.demo.dto;

import java.time.LocalDateTime;
import java.util.Set;

public class UserDTO {
    private Long id;
    private String username;
    private String roleName;
    private Set<String> permissions;
    private Boolean enabled;
    private LocalDateTime lastLogin;
    private LocalDateTime createdAt;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Set<String> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<String> permissions) {
        this.permissions = permissions;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
```

---

**CONTINÚA EN EL SIGUIENTE ARCHIVO...**

*Debido a la longitud del código, he creado este archivo que será complementado con un script PowerShell para generar todos los archivos automáticamente.*

**Siguiente paso:** Ejecutar el comando para crear todos los archivos restantes del sistema de seguridad.
