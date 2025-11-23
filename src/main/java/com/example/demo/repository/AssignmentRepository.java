package com.example.demo.repository;

import com.example.demo.model.Assignment;
import com.example.demo.model.Assignment.AssignmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AssignmentRepository extends JpaRepository<Assignment, Long> {
    
    List<Assignment> findByEmployeeId(Long employeeId);
    
    List<Assignment> findByItemId(Long itemId);
    
    List<Assignment> findByStatus(AssignmentStatus status);
    
    List<Assignment> findByEmployeeIdAndStatus(Long employeeId, AssignmentStatus status);
}
