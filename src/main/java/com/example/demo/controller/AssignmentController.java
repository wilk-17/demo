package com.example.demo.controller;

import com.example.demo.model.Assignment;
import com.example.demo.model.Assignment.AssignmentStatus;
import com.example.demo.repository.AssignmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/assignments")
@CrossOrigin(origins = "*")
public class AssignmentController {

    @Autowired
    private AssignmentRepository assignmentRepository;

    @PreAuthorize("hasAuthority('READ_ASSIGNMENTS')")
    @GetMapping
    public List<Assignment> getAllAssignments() {
        return assignmentRepository.findAll();
    }

    @PreAuthorize("hasAuthority('READ_ASSIGNMENTS')")
    @GetMapping("/{id}")
    public ResponseEntity<Assignment> getAssignmentById(@PathVariable Long id) {
        Optional<Assignment> assignment = assignmentRepository.findById(id);
        return assignment.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_ASSIGNMENTS')")
    @GetMapping("/employee/{employeeId}")
    public List<Assignment> getAssignmentsByEmployee(@PathVariable Long employeeId) {
        return assignmentRepository.findByEmployeeId(employeeId);
    }

    @PreAuthorize("hasAuthority('READ_ASSIGNMENTS')")
    @GetMapping("/item/{itemId}")
    public List<Assignment> getAssignmentsByItem(@PathVariable Long itemId) {
        return assignmentRepository.findByItemId(itemId);
    }

    @PreAuthorize("hasAuthority('READ_ASSIGNMENTS')")
    @GetMapping("/status/{status}")
    public List<Assignment> getAssignmentsByStatus(@PathVariable AssignmentStatus status) {
        return assignmentRepository.findByStatus(status);
    }

    @PreAuthorize("hasAuthority('WRITE_ASSIGNMENTS')")
    @PostMapping
    public ResponseEntity<Assignment> createAssignment(@RequestBody Assignment assignment) {
        try {
            Assignment savedAssignment = assignmentRepository.save(assignment);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedAssignment);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PreAuthorize("hasAuthority('WRITE_ASSIGNMENTS')")
    @PutMapping("/{id}")
    public ResponseEntity<Assignment> updateAssignment(@PathVariable Long id, @RequestBody Assignment assignmentDetails) {
        Optional<Assignment> assignmentOptional = assignmentRepository.findById(id);
        
        if (assignmentOptional.isPresent()) {
            Assignment assignment = assignmentOptional.get();
            assignment.setEmployeeId(assignmentDetails.getEmployeeId());
            assignment.setItemId(assignmentDetails.getItemId());
            assignment.setQuantity(assignmentDetails.getQuantity());
            assignment.setAssignedDate(assignmentDetails.getAssignedDate());
            assignment.setStatus(assignmentDetails.getStatus());
            assignment.setReturnDate(assignmentDetails.getReturnDate());
            assignment.setCondition(assignmentDetails.getCondition());
            assignment.setNotes(assignmentDetails.getNotes());
            
            Assignment updatedAssignment = assignmentRepository.save(assignment);
            return ResponseEntity.ok(updatedAssignment);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Endpoint para marcar como devuelta una asignación
     */
    @PreAuthorize("hasAuthority('WRITE_ASSIGNMENTS')")
    @PostMapping("/{id}/mark-returned")
    public ResponseEntity<Assignment> markReturned(@PathVariable Long id, @RequestBody Map<String, String> request) {
        Optional<Assignment> assignmentOptional = assignmentRepository.findById(id);
        
        if (assignmentOptional.isPresent()) {
            Assignment assignment = assignmentOptional.get();
            String condition = request.get("condition");
            String notes = request.get("notes");
            
            assignment.markReturned(condition, notes);
            Assignment updatedAssignment = assignmentRepository.save(assignment);
            return ResponseEntity.ok(updatedAssignment);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Endpoint para marcar como perdida una asignación
     */
    @PreAuthorize("hasAuthority('WRITE_ASSIGNMENTS')")
    @PostMapping("/{id}/mark-lost")
    public ResponseEntity<Assignment> markLost(@PathVariable Long id, @RequestBody Map<String, String> request) {
        Optional<Assignment> assignmentOptional = assignmentRepository.findById(id);
        
        if (assignmentOptional.isPresent()) {
            Assignment assignment = assignmentOptional.get();
            String notes = request.get("notes");
            
            assignment.markLost(notes);
            Assignment updatedAssignment = assignmentRepository.save(assignment);
            return ResponseEntity.ok(updatedAssignment);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PreAuthorize("hasAuthority('DELETE_ASSIGNMENTS')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAssignment(@PathVariable Long id) {
        Optional<Assignment> assignment = assignmentRepository.findById(id);
        
        if (assignment.isPresent()) {
            assignmentRepository.delete(assignment.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
