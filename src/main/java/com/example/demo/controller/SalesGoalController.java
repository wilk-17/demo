package com.example.demo.controller;

import com.example.demo.model.SalesGoal;
import com.example.demo.model.SalesGoal.PeriodType;
import com.example.demo.repository.SalesGoalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/sales-goals")
@CrossOrigin(origins = "*")
public class SalesGoalController {

    @Autowired
    private SalesGoalRepository salesGoalRepository;

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping
    public List<SalesGoal> getAllSalesGoals() {
        return salesGoalRepository.findAll();
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/{id}")
    public ResponseEntity<SalesGoal> getSalesGoalById(@PathVariable Long id) {
        Optional<SalesGoal> salesGoal = salesGoalRepository.findById(id);
        return salesGoal.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/employee/{employeeId}")
    public List<SalesGoal> getSalesGoalsByEmployee(@PathVariable Long employeeId) {
        return salesGoalRepository.findByEmployeeId(employeeId);
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/branch/{branchId}")
    public List<SalesGoal> getSalesGoalsByBranch(@PathVariable Long branchId) {
        return salesGoalRepository.findByBranchId(branchId);
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/period/{periodType}")
    public List<SalesGoal> getSalesGoalsByPeriod(@PathVariable PeriodType periodType) {
        return salesGoalRepository.findByPeriodType(periodType);
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/employee/{employeeId}/period/{periodType}")
    public List<SalesGoal> getSalesGoalsByEmployeeAndPeriod(
            @PathVariable Long employeeId, 
            @PathVariable PeriodType periodType) {
        return salesGoalRepository.findByEmployeeIdAndPeriodType(employeeId, periodType);
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/branch/{branchId}/period/{periodType}")
    public List<SalesGoal> getSalesGoalsByBranchAndPeriod(
            @PathVariable Long branchId, 
            @PathVariable PeriodType periodType) {
        return salesGoalRepository.findByBranchIdAndPeriodType(branchId, periodType);
    }

    @PreAuthorize("hasAuthority('READ_GOALS')")
    @GetMapping("/date-range")
    public List<SalesGoal> getSalesGoalsByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return salesGoalRepository.findByStartDateBetween(startDate, endDate);
    }

    @PreAuthorize("hasAuthority('WRITE_GOALS')")
    @PostMapping
    public ResponseEntity<?> createSalesGoal(@RequestBody SalesGoal salesGoal) {
        try {
            // Validar que solo uno de employeeId o branchId esté presente
            if (!salesGoal.isValid()) {
                return ResponseEntity.badRequest()
                        .body("Debe especificar solo un employeeId O un branchId, no ambos");
            }
            
            SalesGoal savedSalesGoal = salesGoalRepository.save(salesGoal);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedSalesGoal);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PreAuthorize("hasAuthority('WRITE_GOALS')")
    @PutMapping("/{id}")
    public ResponseEntity<?> updateSalesGoal(@PathVariable Long id, @RequestBody SalesGoal salesGoalDetails) {
        Optional<SalesGoal> salesGoalOptional = salesGoalRepository.findById(id);
        
        if (salesGoalOptional.isPresent()) {
            // Validar que solo uno de employeeId o branchId esté presente
            if (!salesGoalDetails.isValid()) {
                return ResponseEntity.badRequest()
                        .body("Debe especificar solo un employeeId O un branchId, no ambos");
            }
            
            SalesGoal salesGoal = salesGoalOptional.get();
            salesGoal.setEmployeeId(salesGoalDetails.getEmployeeId());
            salesGoal.setBranchId(salesGoalDetails.getBranchId());
            salesGoal.setPeriodType(salesGoalDetails.getPeriodType());
            salesGoal.setStartDate(salesGoalDetails.getStartDate());
            salesGoal.setEndDate(salesGoalDetails.getEndDate());
            salesGoal.setTargetAmount(salesGoalDetails.getTargetAmount());
            salesGoal.setCreatedByUserId(salesGoalDetails.getCreatedByUserId());
            
            SalesGoal updatedSalesGoal = salesGoalRepository.save(salesGoal);
            return ResponseEntity.ok(updatedSalesGoal);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PreAuthorize("hasAuthority('DELETE_GOALS')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSalesGoal(@PathVariable Long id) {
        Optional<SalesGoal> salesGoal = salesGoalRepository.findById(id);
        
        if (salesGoal.isPresent()) {
            salesGoalRepository.delete(salesGoal.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
