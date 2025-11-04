# 🚀 SCRIPT MAESTRO - Generar TODO el Sistema de Seguridad
# Ejecutar desde: c:\Users\wilke\Documents\Sistemas de BDD 6to\demo
#
# Este script genera TODOS los archivos necesarios para el sistema de seguridad completo

$ErrorActionPreference = "Stop"
$baseDir = "src\main\java\com\example\demo"

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host "  🔐 GENERADOR AUTOMÁTICO DE SISTEMA DE SEGURIDAD  " -ForegroundColor Magenta
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host ""

# Función para crear archivo
function Create-JavaFile {
    param(
        [string]$Path,
        [string]$Content,
        [string]$FileName
    )
    
    $fullPath = "$baseDir\$Path\$FileName"
    Set-Content -Path $fullPath -Value $Content -Encoding UTF8
    Write-Host "  ✅ $FileName" -ForegroundColor Green
}

Write-Host "📦 Creando servicios..." -ForegroundColor Cyan

# AuthService.java
$authService = @'
package com.example.demo.service;

import com.example.demo.dto.AuthResponse;
import com.example.demo.dto.LoginRequest;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuditService auditService;

    @Transactional
    public AuthResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = tokenProvider.generateToken(authentication);

        User user = userRepository.findByUsername(loginRequest.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Actualizar último login
        user.setLastLogin(LocalDateTime.now());
        userRepository.save(user);

        // Registrar login en auditoría
        auditService.logActivity(user.getId(), "LOGIN", "User", user.getId(), 
                "Usuario " + user.getUsername() + " inició sesión", null);

        Set<String> permissions = user.getRole().getPermissions().stream()
                .map(p -> p.getName())
                .collect(Collectors.toSet());

        return new AuthResponse(jwt, user.getId(), user.getUsername(), 
                user.getRole().getName(), permissions);
    }

    public User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Current user not found"));
    }

    public boolean hasPermission(String permission) {
        User user = getCurrentUser();
        return user.getRole().getPermissions().stream()
                .anyMatch(p -> p.getName().equals(permission));
    }
}
'@

Create-JavaFile -Path "service" -Content $authService -FileName "AuthService.java"

# AuditService.java
$auditService = @'
package com.example.demo.service;

import com.example.demo.model.ActivityLog;
import com.example.demo.repository.ActivityLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AuditService {

    @Autowired
    private ActivityLogRepository activityLogRepository;

    @Transactional
    public void logActivity(Long userId, String action, String entity, Long entityId, 
                           String description, String ipAddress) {
        ActivityLog log = new ActivityLog(userId, action, entity, entityId, description, ipAddress);
        activityLogRepository.save(log);
    }

    public List<ActivityLog> getRecentActivities(int limit) {
        return activityLogRepository.findTop100ByOrderByCreatedAtDesc();
    }

    public List<ActivityLog> getActivitiesByUser(Long userId) {
        return activityLogRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public List<ActivityLog> getActivitiesByAction(String action) {
        return activityLogRepository.findByActionOrderByCreatedAtDesc(action);
    }

    public List<ActivityLog> getActivitiesByDateRange(LocalDateTime start, LocalDateTime end) {
        return activityLogRepository.findByCreatedAtBetweenOrderByCreatedAtDesc(start, end);
    }
}
'@

Create-JavaFile -Path "service" -Content $auditService -FileName "AuditService.java"

# PermissionService.java
$permissionService = @'
package com.example.demo.service;

import com.example.demo.model.Permission;
import com.example.demo.model.Role;
import com.example.demo.repository.PermissionRepository;
import com.example.demo.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
public class PermissionService {

    @Autowired
    private PermissionRepository permissionRepository;

    @Autowired
    private RoleRepository roleRepository;

    public List<Permission> getAllPermissions() {
        return permissionRepository.findAll();
    }

    public List<Permission> getPermissionsByModule(String module) {
        return permissionRepository.findByModule(module);
    }

    @Transactional
    public void assignPermissionToRole(Long roleId, Long permissionId) {
        Role role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Role not found"));
        Permission permission = permissionRepository.findById(permissionId)
                .orElseThrow(() -> new RuntimeException("Permission not found"));
        
        role.addPermission(permission);
        roleRepository.save(role);
    }

    @Transactional
    public void removePermissionFromRole(Long roleId, Long permissionId) {
        Role role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Role not found"));
        Permission permission = permissionRepository.findById(permissionId)
                .orElseThrow(() -> new RuntimeException("Permission not found"));
        
        role.removePermission(permission);
        roleRepository.save(role);
    }

    public Set<Permission> getRolePermissions(Long roleId) {
        Role role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Role not found"));
        return role.getPermissions();
    }
}
'@

Create-JavaFile -Path "service" -Content $permissionService -FileName "PermissionService.java"

Write-Host ""
Write-Host "📡 Creando controladores..." -ForegroundColor Cyan

# AuthController.java
$authController = @'
package com.example.demo.controller;

import com.example.demo.dto.AuthResponse;
import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.UserDTO;
import com.example.demo.model.User;
import com.example.demo.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest loginRequest) {
        AuthResponse response = authService.login(loginRequest);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/me")
    public ResponseEntity<UserDTO> getCurrentUser() {
        User user = authService.getCurrentUser();
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setRoleName(user.getRole().getName());
        dto.setPermissions(user.getRole().getPermissions().stream()
                .map(p -> p.getName())
                .collect(Collectors.toSet()));
        dto.setEnabled(user.getEnabled());
        dto.setLastLogin(user.getLastLogin());
        dto.setCreatedAt(user.getCreatedAt());
        return ResponseEntity.ok(dto);
    }

    @GetMapping("/check-permission/{permission}")
    public ResponseEntity<Boolean> hasPermission(@PathVariable String permission) {
        boolean has = authService.hasPermission(permission);
        return ResponseEntity.ok(has);
    }
}
'@

Create-JavaFile -Path "controller" -Content $authController -FileName "AuthController.java"

# AdminController.java
$adminController = @'
package com.example.demo.controller;

import com.example.demo.model.ActivityLog;
import com.example.demo.model.Permission;
import com.example.demo.service.AuditService;
import com.example.demo.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMINISTRADOR')")
public class AdminController {

    @Autowired
    private AuditService auditService;

    @Autowired
    private PermissionService permissionService;

    @GetMapping("/activity-logs")
    public ResponseEntity<List<ActivityLog>> getRecentLogs() {
        List<ActivityLog> logs = auditService.getRecentActivities(100);
        return ResponseEntity.ok(logs);
    }

    @GetMapping("/activity-logs/user/{userId}")
    public ResponseEntity<List<ActivityLog>> getUserLogs(@PathVariable Long userId) {
        List<ActivityLog> logs = auditService.getActivitiesByUser(userId);
        return ResponseEntity.ok(logs);
    }

    @GetMapping("/permissions")
    public ResponseEntity<List<Permission>> getAllPermissions() {
        List<Permission> permissions = permissionService.getAllPermissions();
        return ResponseEntity.ok(permissions);
    }

    @GetMapping("/permissions/role/{roleId}")
    public ResponseEntity<Set<Permission>> getRolePermissions(@PathVariable Long roleId) {
        Set<Permission> permissions = permissionService.getRolePermissions(roleId);
        return ResponseEntity.ok(permissions);
    }

    @PostMapping("/permissions/assign")
    public ResponseEntity<String> assignPermission(
            @RequestParam Long roleId,
            @RequestParam Long permissionId) {
        permissionService.assignPermissionToRole(roleId, permissionId);
        return ResponseEntity.ok("Permission assigned successfully");
    }

    @DeleteMapping("/permissions/remove")
    public ResponseEntity<String> removePermission(
            @RequestParam Long roleId,
            @RequestParam Long permissionId) {
        permissionService.removePermissionFromRole(roleId, permissionId);
        return ResponseEntity.ok("Permission removed successfully");
    }
}
'@

Create-JavaFile -Path "controller" -Content $adminController -FileName "AdminController.java"

# UserDTO.java
$userDTO = @'
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
'@

Create-JavaFile -Path "dto" -Content $userDTO -FileName "UserDTO.java"

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host "  ✅ SISTEMA DE SEGURIDAD GENERADO EXITOSAMENTE  " -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host ""
Write-Host "📋 Archivos creados:" -ForegroundColor Yellow
Write-Host "   • AuthService.java" -ForegroundColor White
Write-Host "   • AuditService.java" -ForegroundColor White
Write-Host "   • PermissionService.java" -ForegroundColor White
Write-Host "   • AuthController.java" -ForegroundColor White
Write-Host "   • AdminController.java" -ForegroundColor White
Write-Host "   • UserDTO.java" -ForegroundColor White
Write-Host ""
Write-Host "🔄 Próximos pasos:" -ForegroundColor Yellow
Write-Host "   1. Ejecutar: .\create-security-components.ps1" -ForegroundColor Cyan
Write-Host "   2. Ejecutar: .\create-security-config.ps1" -ForegroundColor Cyan
Write-Host "   3. Ejecutar: .\create-data-initializer.ps1" -ForegroundColor Cyan
Write-Host "   4. Compilar proyecto: .\mvnw clean install" -ForegroundColor Cyan
Write-Host ""
"@

Set-Content -Path "create-all-security.ps1" -Value $content -Encoding UTF8

Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  ✅ SCRIPT MAESTRO CREADO EXITOSAMENTE  " -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Archivos de análisis creados:" -ForegroundColor Cyan
Write-Host "  • ANALISIS_PROYECTO_Y_PENDIENTES.md" -ForegroundColor White
Write-Host "  • GUIA_IMPLEMENTACION_SEGURIDAD.md" -ForegroundColor White
Write-Host "  • ESTADO_IMPLEMENTACION.md" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Scripts PowerShell creados:" -ForegroundColor Cyan
Write-Host "  • create-all-security.ps1 (PRINCIPAL - ejecutar primero)" -ForegroundColor Yellow
Write-Host "  • create-security-components.ps1" -ForegroundColor White
Write-Host "  • create-security-config.ps1" -ForegroundColor White
Write-Host ""
Write-Host "▶️  Para ejecutar todo de una vez:" -ForegroundColor Green
Write-Host "   .\create-all-security.ps1" -ForegroundColor Cyan
Write-Host "   .\create-security-components.ps1" -ForegroundColor Cyan
Write-Host "   .\create-security-config.ps1" -ForegroundColor Cyan
Write-Host ""
