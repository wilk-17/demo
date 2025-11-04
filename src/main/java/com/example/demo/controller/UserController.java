package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

  @Autowired
  private UsuarioRepository usuarioRepository;

  @Autowired
  private PasswordEncoder passwordEncoder;

  @GetMapping
  public List<User> getAllUsers() {
    return usuarioRepository.findAll();
  }

  @GetMapping("/{id}")
  public ResponseEntity<User> getUserById(@PathVariable Long id) {
    return usuarioRepository.findById(id)
      .map(ResponseEntity::ok)
      .orElse(ResponseEntity.notFound().build());
  }

  @PostMapping
  public ResponseEntity<User> createUser(@RequestBody User user) {
    try {
      // Encriptar contraseña antes de guardar
      if (user.getPassword() != null && !user.getPassword().isEmpty()) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
      }
      User savedUser = usuarioRepository.save(user);
      return ResponseEntity.status(HttpStatus.CREATED).body(savedUser);
    } catch (Exception e) {
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }
  }

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
          } else {
            user.setPassword(userDetails.getPassword());
          }
        }
        
        user.setRoleId(userDetails.getRoleId());
        User updatedUser = usuarioRepository.save(user);
        return ResponseEntity.ok(updatedUser);
      })
      .orElse(ResponseEntity.notFound().build());
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
    return usuarioRepository.findById(id)
      .map(user -> {
        usuarioRepository.delete(user);
        return ResponseEntity.ok().<Void>build();
      })
      .orElse(ResponseEntity.notFound().build());
  }
}