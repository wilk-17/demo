package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/debug")
@CrossOrigin(origins = "*")
public class DebugController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/check-password")
    public ResponseEntity<Map<String, Object>> checkPassword(@RequestBody Map<String, String> request) {
        String username = request.get("username");
        String rawPassword = request.get("password");
        
        Map<String, Object> response = new HashMap<>();
        
        User user = userRepository.findByUsername(username).orElse(null);
        
        if (user == null) {
            response.put("error", "Usuario no encontrado");
            response.put("username", username);
            return ResponseEntity.ok(response);
        }
        
        boolean matches = passwordEncoder.matches(rawPassword, user.getPassword());
        
        response.put("username", username);
        response.put("passwordMatches", matches);
        response.put("hashInDB", user.getPassword());
        response.put("enabled", user.getEnabled());
        response.put("accountNonExpired", user.isAccountNonExpired());
        response.put("accountNonLocked", user.isAccountNonLocked());
        response.put("credentialsNonExpired", user.isCredentialsNonExpired());
        response.put("role", user.getRole() != null ? user.getRole().getName() : "null");
        response.put("roleId", user.getRoleId());
        
        return ResponseEntity.ok(response);
    }

    @GetMapping("/generate-hash/{password}")
    public ResponseEntity<Map<String, String>> generateHash(@PathVariable String password) {
        Map<String, String> response = new HashMap<>();
        String hash = passwordEncoder.encode(password);
        response.put("password", password);
        response.put("hash", hash);
        response.put("length", String.valueOf(hash.length()));
        return ResponseEntity.ok(response);
    }
}
