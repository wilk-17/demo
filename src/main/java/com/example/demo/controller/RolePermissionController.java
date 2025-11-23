package com.example.demo.controller;

import com.example.demo.model.Permission;
import com.example.demo.model.Role;
import com.example.demo.repository.PermissionRepository;
import com.example.demo.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/roles/{roleId}/permissions")
@PreAuthorize("hasAuthority('ADMIN_ALL')")
public class RolePermissionController {

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PermissionRepository permissionRepository;

    /**
     * Obtener todos los permisos asignados a un rol
     */
    @GetMapping
    public ResponseEntity<?> getRolePermissions(@PathVariable Long roleId) {
        Optional<Role> roleOpt = roleRepository.findById(roleId);
        
        if (roleOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Rol no encontrado con ID: " + roleId));
        }

        Role role = roleOpt.get();
        Set<Permission> permissions = role.getPermissions();
        
        // Convertir a lista de IDs y nombres para respuesta más limpia
        List<Map<String, Object>> permissionList = permissions.stream()
                .map(p -> Map.of(
                        "id", (Object) p.getId(),
                        "name", p.getName(),
                        "description", p.getDescription() != null ? p.getDescription() : "",
                        "module", p.getModule()
                ))
                .collect(Collectors.toList());

        return ResponseEntity.ok(Map.of(
                "roleId", roleId,
                "roleName", role.getName(),
                "permissions", permissionList
        ));
    }

    /**
     * Asignar un permiso a un rol
     */
    @PostMapping("/{permissionId}")
    public ResponseEntity<?> addPermissionToRole(
            @PathVariable Long roleId,
            @PathVariable Long permissionId) {
        
        Optional<Role> roleOpt = roleRepository.findById(roleId);
        if (roleOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Rol no encontrado con ID: " + roleId));
        }

        Optional<Permission> permissionOpt = permissionRepository.findById(permissionId);
        if (permissionOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Permiso no encontrado con ID: " + permissionId));
        }

        Role role = roleOpt.get();
        Permission permission = permissionOpt.get();

        // Verificar si ya tiene el permiso
        if (role.getPermissions().contains(permission)) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(Map.of("error", "El rol ya tiene este permiso asignado"));
        }

        role.addPermission(permission);
        roleRepository.save(role);

        return ResponseEntity.ok(Map.of(
                "message", "Permiso asignado exitosamente",
                "roleId", roleId,
                "permissionId", permissionId
        ));
    }

    /**
     * Quitar un permiso de un rol
     */
    @DeleteMapping("/{permissionId}")
    public ResponseEntity<?> removePermissionFromRole(
            @PathVariable Long roleId,
            @PathVariable Long permissionId) {
        
        Optional<Role> roleOpt = roleRepository.findById(roleId);
        if (roleOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Rol no encontrado con ID: " + roleId));
        }

        Optional<Permission> permissionOpt = permissionRepository.findById(permissionId);
        if (permissionOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Permiso no encontrado con ID: " + permissionId));
        }

        Role role = roleOpt.get();
        Permission permission = permissionOpt.get();

        // Verificar si tiene el permiso
        if (!role.getPermissions().contains(permission)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "El rol no tiene este permiso asignado"));
        }

        role.removePermission(permission);
        roleRepository.save(role);

        return ResponseEntity.ok(Map.of(
                "message", "Permiso removido exitosamente",
                "roleId", roleId,
                "permissionId", permissionId
        ));
    }

    /**
     * Actualizar todos los permisos de un rol (reemplaza los existentes)
     */
    @PutMapping
    public ResponseEntity<?> updateRolePermissions(
            @PathVariable Long roleId,
            @RequestBody Map<String, List<Long>> request) {
        
        Optional<Role> roleOpt = roleRepository.findById(roleId);
        if (roleOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Rol no encontrado con ID: " + roleId));
        }

        List<Long> permissionIds = request.get("permissionIds");
        if (permissionIds == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", "Se requiere el campo 'permissionIds'"));
        }

        Role role = roleOpt.get();
        
        // Obtener todos los permisos solicitados
        List<Permission> permissions = permissionRepository.findAllById(permissionIds);
        
        // Verificar que todos los IDs existan
        if (permissions.size() != permissionIds.size()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", "Uno o más IDs de permisos no son válidos"));
        }

        // Limpiar permisos actuales y asignar los nuevos
        role.getPermissions().clear();
        permissions.forEach(role::addPermission);
        roleRepository.save(role);

        return ResponseEntity.ok(Map.of(
                "message", "Permisos actualizados exitosamente",
                "roleId", roleId,
                "permissionsCount", permissions.size()
        ));
    }

    /**
     * Obtener todos los permisos disponibles (no asignados a este rol)
     */
    @GetMapping("/available")
    public ResponseEntity<?> getAvailablePermissions(@PathVariable Long roleId) {
        Optional<Role> roleOpt = roleRepository.findById(roleId);
        
        if (roleOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", "Rol no encontrado con ID: " + roleId));
        }

        Role role = roleOpt.get();
        Set<Long> assignedPermissionIds = role.getPermissions().stream()
                .map(Permission::getId)
                .collect(Collectors.toSet());

        // Obtener todos los permisos que NO están asignados
        List<Permission> availablePermissions = permissionRepository.findAll().stream()
                .filter(p -> !assignedPermissionIds.contains(p.getId()))
                .collect(Collectors.toList());

        List<Map<String, Object>> permissionList = availablePermissions.stream()
                .map(p -> Map.of(
                        "id", (Object) p.getId(),
                        "name", p.getName(),
                        "description", p.getDescription() != null ? p.getDescription() : "",
                        "module", p.getModule()
                ))
                .collect(Collectors.toList());

        return ResponseEntity.ok(Map.of(
                "roleId", roleId,
                "availablePermissions", permissionList
        ));
    }
}
