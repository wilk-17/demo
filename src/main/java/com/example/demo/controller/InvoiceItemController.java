package com.example.demo.controller;

import com.example.demo.model.InvoiceItem;
import com.example.demo.repository.InvoiceItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/invoice-items")
public class InvoiceItemController {

    @Autowired
    private InvoiceItemRepository invoiceItemRepository;

    @PreAuthorize("hasAuthority('READ_INVOICES')")
    @GetMapping
    public ResponseEntity<List<InvoiceItem>> getAllInvoiceItems() {
        List<InvoiceItem> items = invoiceItemRepository.findAll();
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('READ_INVOICES')")
    @GetMapping("/{id}")
    public ResponseEntity<InvoiceItem> getInvoiceItemById(@PathVariable Long id) {
        Optional<InvoiceItem> item = invoiceItemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_INVOICES')")
    @GetMapping("/invoice/{invoiceId}")
    public ResponseEntity<List<InvoiceItem>> getItemsByInvoice(@PathVariable Long invoiceId) {
        List<InvoiceItem> items = invoiceItemRepository.findByInvoiceId(invoiceId);
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('READ_INVOICES')")
    @GetMapping("/item/{itemId}")
    public ResponseEntity<List<InvoiceItem>> getInvoiceItemsByItem(@PathVariable Long itemId) {
        List<InvoiceItem> items = invoiceItemRepository.findByItemId(itemId);
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('WRITE_INVOICES')")
    @PostMapping
    public ResponseEntity<InvoiceItem> createInvoiceItem(@RequestBody InvoiceItem invoiceItem) {
        InvoiceItem savedItem = invoiceItemRepository.save(invoiceItem);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedItem);
    }

    @PreAuthorize("hasAuthority('WRITE_INVOICES')")
    @PutMapping("/{id}")
    public ResponseEntity<InvoiceItem> updateInvoiceItem(@PathVariable Long id, @RequestBody InvoiceItem invoiceItemDetails) {
        Optional<InvoiceItem> itemOptional = invoiceItemRepository.findById(id);
        
        if (itemOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        InvoiceItem item = itemOptional.get();
        item.setInvoiceId(invoiceItemDetails.getInvoiceId());
        item.setItemId(invoiceItemDetails.getItemId());
        item.setQuantity(invoiceItemDetails.getQuantity());
        item.setPrice(invoiceItemDetails.getPrice());

        InvoiceItem updatedItem = invoiceItemRepository.save(item);
        return ResponseEntity.ok(updatedItem);
    }

    @PreAuthorize("hasAuthority('DELETE_INVOICES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteInvoiceItem(@PathVariable Long id) {
        if (!invoiceItemRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        invoiceItemRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
