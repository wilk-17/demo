package com.example.demo.controller;

import com.example.demo.model.QuoteItem;
import com.example.demo.repository.QuoteItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/quote-items")
@CrossOrigin(origins = "*")
public class QuoteItemController {

    @Autowired
    private QuoteItemRepository quoteItemRepository;

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping
    public List<QuoteItem> getAllQuoteItems() {
        return quoteItemRepository.findAll();
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/{id}")
    public ResponseEntity<QuoteItem> getQuoteItemById(@PathVariable Long id) {
        Optional<QuoteItem> quoteItem = quoteItemRepository.findById(id);
        return quoteItem.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/quote/{quoteId}")
    public List<QuoteItem> getQuoteItemsByQuote(@PathVariable Long quoteId) {
        return quoteItemRepository.findByQuoteId(quoteId);
    }

    @PreAuthorize("hasAuthority('READ_QUOTES')")
    @GetMapping("/item/{itemId}")
    public List<QuoteItem> getQuoteItemsByItem(@PathVariable Long itemId) {
        return quoteItemRepository.findByItemId(itemId);
    }

    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PostMapping
    public ResponseEntity<QuoteItem> createQuoteItem(@RequestBody QuoteItem quoteItem) {
        try {
            QuoteItem savedQuoteItem = quoteItemRepository.save(quoteItem);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedQuoteItem);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PreAuthorize("hasAuthority('WRITE_QUOTES')")
    @PutMapping("/{id}")
    public ResponseEntity<QuoteItem> updateQuoteItem(@PathVariable Long id, @RequestBody QuoteItem quoteItemDetails) {
        Optional<QuoteItem> quoteItemOptional = quoteItemRepository.findById(id);
        
        if (quoteItemOptional.isPresent()) {
            QuoteItem quoteItem = quoteItemOptional.get();
            quoteItem.setQuoteId(quoteItemDetails.getQuoteId());
            quoteItem.setItemId(quoteItemDetails.getItemId());
            quoteItem.setQuantity(quoteItemDetails.getQuantity());
            
            QuoteItem updatedQuoteItem = quoteItemRepository.save(quoteItem);
            return ResponseEntity.ok(updatedQuoteItem);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PreAuthorize("hasAuthority('DELETE_QUOTES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQuoteItem(@PathVariable Long id) {
        Optional<QuoteItem> quoteItem = quoteItemRepository.findById(id);
        
        if (quoteItem.isPresent()) {
            quoteItemRepository.delete(quoteItem.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
