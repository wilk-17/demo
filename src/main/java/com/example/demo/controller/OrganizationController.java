package com.example.demo.controller;

import com.example.demo.model.Organization;
import com.example.demo.repository.OrganizationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/organizations")
public class OrganizationController {

    @Autowired
    private OrganizationRepository organizationRepository;

    @PreAuthorize("hasAuthority('READ_ORGANIZATIONS')")
    @GetMapping
    public ResponseEntity<List<Organization>> getAllOrganizations() {
        List<Organization> organizations = organizationRepository.findAll();
        return ResponseEntity.ok(organizations);
    }

    @PreAuthorize("hasAuthority('READ_ORGANIZATIONS')")
    @GetMapping("/{id}")
    public ResponseEntity<Organization> getOrganizationById(@PathVariable Long id) {
        Optional<Organization> organization = organizationRepository.findById(id);
        return organization.map(ResponseEntity::ok)
                          .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('WRITE_ORGANIZATIONS')")
    @PostMapping
    public ResponseEntity<Organization> createOrganization(@RequestBody Organization organization) {
        Organization savedOrganization = organizationRepository.save(organization);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedOrganization);
    }

    @PreAuthorize("hasAuthority('WRITE_ORGANIZATIONS')")
    @PutMapping("/{id}")
    public ResponseEntity<Organization> updateOrganization(@PathVariable Long id, 
                                                           @RequestBody Organization organizationDetails) {
        Optional<Organization> organizationOptional = organizationRepository.findById(id);
        
        if (organizationOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Organization organization = organizationOptional.get();
        organization.setHistoricalName(organizationDetails.getHistoricalName());
        organization.setCurrentName(organizationDetails.getCurrentName());

        Organization updatedOrganization = organizationRepository.save(organization);
        return ResponseEntity.ok(updatedOrganization);
    }

    @PreAuthorize("hasAuthority('DELETE_ORGANIZATIONS')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrganization(@PathVariable Long id) {
        if (!organizationRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        organizationRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
