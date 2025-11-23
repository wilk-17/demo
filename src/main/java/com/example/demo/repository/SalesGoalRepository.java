package com.example.demo.repository;

import com.example.demo.model.SalesGoal;
import com.example.demo.model.SalesGoal.PeriodType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface SalesGoalRepository extends JpaRepository<SalesGoal, Long> {
    
    List<SalesGoal> findByEmployeeId(Long employeeId);
    
    List<SalesGoal> findByBranchId(Long branchId);
    
    List<SalesGoal> findByPeriodType(PeriodType periodType);
    
    List<SalesGoal> findByStartDateBetween(LocalDate startDate, LocalDate endDate);
    
    List<SalesGoal> findByEmployeeIdAndPeriodType(Long employeeId, PeriodType periodType);
    
    List<SalesGoal> findByBranchIdAndPeriodType(Long branchId, PeriodType periodType);
}
