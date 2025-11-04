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
@CrossOrigin(origins = "*")
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
