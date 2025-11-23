package com.example.demo.controller;

import com.example.demo.model.Quote;
import com.example.demo.repository.QuoteRepository;
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
@RequestMapping("/api/quotes")
@CrossOrigin(origins = "*")
public class QuoteController {

    @Autowired
    private QuoteRepository quoteRepository;

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping
    public List<Quote> getAllQuotes() {
        return quoteRepository.findAll();
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/{id}")
    public ResponseEntity<Quote> getQuoteById(@PathVariable Long id) {
        Optional<Quote> quote = quoteRepository.findById(id);
        return quote.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/employee/{employeeId}")
    public List<Quote> getQuotesByEmployee(@PathVariable Long employeeId) {
        return quoteRepository.findByEmployeeId(employeeId);
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/customer")
    public List<Quote> getQuotesByCustomer(@RequestParam String name) {
        return quoteRepository.findByCustomerNameContainingIgnoreCase(name);
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/date-range")
    public List<Quote> getQuotesByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        return quoteRepository.findByDateBetween(startDate, endDate);
    }

    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PostMapping
    public ResponseEntity<Quote> createQuote(@RequestBody Quote quote) {
        try {
            // Calcular total si tiene líneas
            if (quote.getLines() != null && !quote.getLines().isEmpty()) {
                quote.calculateTotal();
            }
            Quote savedQuote = quoteRepository.save(quote);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedQuote);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PutMapping("/{id}")
    public ResponseEntity<Quote> updateQuote(@PathVariable Long id, @RequestBody Quote quoteDetails) {
        Optional<Quote> quoteOptional = quoteRepository.findById(id);
        
        if (quoteOptional.isPresent()) {
            Quote quote = quoteOptional.get();
            quote.setCustomerName(quoteDetails.getCustomerName());
            quote.setDate(quoteDetails.getDate());
            quote.setTotal(quoteDetails.getTotal());
            quote.setEmployeeId(quoteDetails.getEmployeeId());
            
            Quote updatedQuote = quoteRepository.save(quote);
            return ResponseEntity.ok(updatedQuote);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Recalcular el total de la cotización basado en sus líneas
     */
    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PostMapping("/{id}/recalculate-total")
    public ResponseEntity<Quote> recalculateTotal(@PathVariable Long id) {
        Optional<Quote> quoteOptional = quoteRepository.findById(id);
        
        if (quoteOptional.isPresent()) {
            Quote quote = quoteOptional.get();
            quote.calculateTotal();
            Quote updatedQuote = quoteRepository.save(quote);
            return ResponseEntity.ok(updatedQuote);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PreAuthorize("hasAuthority('DELETE_QUOTES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQuote(@PathVariable Long id) {
        Optional<Quote> quote = quoteRepository.findById(id);
        
        if (quote.isPresent()) {
            quoteRepository.delete(quote.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
