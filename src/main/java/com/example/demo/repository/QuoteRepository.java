package com.example.demo.repository;

import com.example.demo.model.Quote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface QuoteRepository extends JpaRepository<Quote, Long> {
    
    List<Quote> findByEmployeeId(Long employeeId);
    
    List<Quote> findByCustomerNameContainingIgnoreCase(String customerName);
    
    List<Quote> findByDateBetween(LocalDate startDate, LocalDate endDate);
    
    List<Quote> findByEmployeeIdAndDateBetween(Long employeeId, LocalDate startDate, LocalDate endDate);
}
