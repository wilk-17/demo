package com.example.demo.controller;

import com.example.demo.model.Branch;
import com.example.demo.repository.BranchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/branches")
public class BranchController {

    @Autowired
    private BranchRepository branchRepository;

    @PreAuthorize("hasAuthority('READ_BRANCHES')")
    @GetMapping
    public ResponseEntity<List<Branch>> getAllBranches() {
        List<Branch> branches = branchRepository.findAll();
        return ResponseEntity.ok(branches);
    }

    @PreAuthorize("hasAuthority('READ_BRANCHES')")
    @GetMapping("/{id}")
    public ResponseEntity<Branch> getBranchById(@PathVariable Long id) {
        Optional<Branch> branch = branchRepository.findById(id);
        return branch.map(ResponseEntity::ok)
                    .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_BRANCHES')")
    @GetMapping("/organization/{organizationId}")
    public ResponseEntity<List<Branch>> getBranchesByOrganization(@PathVariable Long organizationId) {
        List<Branch> branches = branchRepository.findByOrganizationId(organizationId);
        return ResponseEntity.ok(branches);
    }

    @PreAuthorize("hasAuthority('READ_BRANCHES')")
    @GetMapping("/city/{cityId}")
    public ResponseEntity<List<Branch>> getCitiesWithBranches(@PathVariable Long cityId) {
        List<Branch> branches = branchRepository.findByCityId(cityId);
        return ResponseEntity.ok(branches);
    }

    @PreAuthorize("hasAuthority('WRITE_BRANCHES')")
    @PostMapping
    public ResponseEntity<Branch> createBranch(@RequestBody Branch branch) {
        Branch savedBranch = branchRepository.save(branch);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedBranch);
    }

    @PreAuthorize("hasAuthority('WRITE_BRANCHES')")
    @PutMapping("/{id}")
    public ResponseEntity<Branch> updateBranch(@PathVariable Long id, @RequestBody Branch branchDetails) {
        Optional<Branch> branchOptional = branchRepository.findById(id);
        
        if (branchOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Branch branch = branchOptional.get();
        branch.setOrganizationId(branchDetails.getOrganizationId());
        branch.setCityId(branchDetails.getCityId());

        Branch updatedBranch = branchRepository.save(branch);
        return ResponseEntity.ok(updatedBranch);
    }

    @PreAuthorize("hasAuthority('DELETE_BRANCHES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBranch(@PathVariable Long id) {
        if (!branchRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        branchRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
