package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "organization")
public class Organization {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "historical_name", nullable = false, length = 200)
    private String historicalName;

    @Column(name = "current_name", nullable = false, length = 200)
    private String currentName;

    @JsonIgnore
    @OneToMany(mappedBy = "organization", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Branch> branches;

    // Constructors
    public Organization() {}

    public Organization(String historicalName, String currentName) {
        this.historicalName = historicalName;
        this.currentName = currentName;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getHistoricalName() {
        return historicalName;
    }

    public void setHistoricalName(String historicalName) {
        this.historicalName = historicalName;
    }

    public String getCurrentName() {
        return currentName;
    }

    public void setCurrentName(String currentName) {
        this.currentName = currentName;
    }

    public List<Branch> getBranches() {
        return branches;
    }

    public void setBranches(List<Branch> branches) {
        this.branches = branches;
    }
}
