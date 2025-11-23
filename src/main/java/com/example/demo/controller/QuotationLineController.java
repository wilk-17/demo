package com.example.demo.controller;

import com.example.demo.model.QuotationLine;
import com.example.demo.repository.QuotationLineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/quotation-lines")
@CrossOrigin(origins = "*")
public class QuotationLineController {

    @Autowired
    private QuotationLineRepository quotationLineRepository;

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping
    public List<QuotationLine> getAllQuotationLines() {
        return quotationLineRepository.findAll();
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/{id}")
    public ResponseEntity<QuotationLine> getQuotationLineById(@PathVariable Long id) {
        Optional<QuotationLine> quotationLine = quotationLineRepository.findById(id);
        return quotationLine.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/quote/{quoteId}")
    public List<QuotationLine> getQuotationLinesByQuote(@PathVariable Long quoteId) {
        return quotationLineRepository.findByQuoteId(quoteId);
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/item/{itemId}")
    public List<QuotationLine> getQuotationLinesByItem(@PathVariable Long itemId) {
        return quotationLineRepository.findByItemId(itemId);
    }

    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PostMapping
    public ResponseEntity<QuotationLine> createQuotationLine(@RequestBody QuotationLine quotationLine) {
        try {
            QuotationLine savedQuotationLine = quotationLineRepository.save(quotationLine);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedQuotationLine);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PutMapping("/{id}")
    public ResponseEntity<QuotationLine> updateQuotationLine(@PathVariable Long id, @RequestBody QuotationLine quotationLineDetails) {
        Optional<QuotationLine> quotationLineOptional = quotationLineRepository.findById(id);
        
        if (quotationLineOptional.isPresent()) {
            QuotationLine quotationLine = quotationLineOptional.get();
            quotationLine.setQuoteId(quotationLineDetails.getQuoteId());
            quotationLine.setDescription(quotationLineDetails.getDescription());
            quotationLine.setQuantity(quotationLineDetails.getQuantity());
            quotationLine.setPrice(quotationLineDetails.getPrice());
            quotationLine.setItemId(quotationLineDetails.getItemId());
            
            QuotationLine updatedQuotationLine = quotationLineRepository.save(quotationLine);
            return ResponseEntity.ok(updatedQuotationLine);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PreAuthorize("hasAuthority('DELETE_QUOTES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQuotationLine(@PathVariable Long id) {
        Optional<QuotationLine> quotationLine = quotationLineRepository.findById(id);
        
        if (quotationLine.isPresent()) {
            quotationLineRepository.delete(quotationLine.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
