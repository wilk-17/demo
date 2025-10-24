package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 120)
    private String username;

    @Column(nullable = false, length = 200)
    private String password;

    @Column(name = "role_id", nullable = false)
    private Long roleId;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id", insertable = false, updatable = false)
    private Role role;

  // Getters y setters
   public Long getId() {
    return id;
  }

  public String getUsername() {
    return username;
  }

  public String getPassword() {
    return password;
  }

  public Long getRoleId() {
    return roleId;
  }

  // Setters
  public void setId(Long id) {
    this.id = id;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public void setRoleId(Long roleId) {
    this.roleId = roleId;
  }

  public Role getRole() {
    return role;
  }

  public void setRole(Role role) {
    this.role = role;
  }

  // Constructors
  public User() {}

  public User(String username, String password, Long roleId) {
    this.username = username;
    this.password = password;
    this.roleId = roleId;
  }
}