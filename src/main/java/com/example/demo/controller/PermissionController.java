package com.example.demo.controller;

import com.example.demo.model.Permission;
import com.example.demo.repository.PermissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/permissions")
@CrossOrigin(origins = "*")
@PreAuthorize("hasAuthority('ADMIN_ALL')")
public class PermissionController {

    @Autowired
    private PermissionRepository permissionRepository;

    @GetMapping
    public List<Permission> getAllPermissions() {
        return permissionRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Permission> getPermissionById(@PathVariable Long id) {
        Optional<Permission> permission = permissionRepository.findById(id);
        return permission.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/module/{module}")
    public List<Permission> getPermissionsByModule(@PathVariable String module) {
        return permissionRepository.findByModule(module);
    }

    @GetMapping("/search")
    public List<Permission> searchPermissions(@RequestParam String name) {
        return permissionRepository.findByNameContainingIgnoreCase(name);
    }

    @PostMapping
    public ResponseEntity<Permission> createPermission(@RequestBody Permission permission) {
        try {
            // Verificar si ya existe un permiso con el mismo nombre
            if (permissionRepository.findByName(permission.getName()).isPresent()) {
                return ResponseEntity.status(HttpStatus.CONFLICT)
                        .body(null);
            }
            
            Permission savedPermission = permissionRepository.save(permission);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedPermission);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Permission> updatePermission(@PathVariable Long id, @RequestBody Permission permissionDetails) {
        Optional<Permission> permissionOptional = permissionRepository.findById(id);
        
        if (permissionOptional.isPresent()) {
            Permission permission = permissionOptional.get();
            
            // Verificar si el nuevo nombre ya existe (excepto para este mismo permiso)
            Optional<Permission> existingPermission = permissionRepository.findByName(permissionDetails.getName());
            if (existingPermission.isPresent() && !existingPermission.get().getId().equals(id)) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
            }
            
            permission.setName(permissionDetails.getName());
            permission.setDescription(permissionDetails.getDescription());
            permission.setModule(permissionDetails.getModule());
            
            Permission updatedPermission = permissionRepository.save(permission);
            return ResponseEntity.ok(updatedPermission);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePermission(@PathVariable Long id) {
        Optional<Permission> permission = permissionRepository.findById(id);
        
        if (permission.isPresent()) {
            permissionRepository.delete(permission.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Obtener todos los módulos únicos
     */
    @GetMapping("/modules")
    public ResponseEntity<List<String>> getAllModules() {
        List<String> modules = permissionRepository.findDistinctModules();
        return ResponseEntity.ok(modules);
    }
}
