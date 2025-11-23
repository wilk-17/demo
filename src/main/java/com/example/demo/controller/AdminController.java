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
@CrossOrigin(origins = "*")
@PreAuthorize("hasAuthority('ADMIN_ALL')")
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
