package com.example.demo.controller;

import com.example.demo.model.InvoiceItem;
import com.example.demo.repository.InvoiceItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/invoice-item")
public class InvoiceItemController {

    @Autowired
    private InvoiceItemRepository invoiceItemRepository;

    @GetMapping
    public ResponseEntity<List<InvoiceItem>> getAllInvoiceItems() {
        List<InvoiceItem> items = invoiceItemRepository.findAll();
        return ResponseEntity.ok(items);
    }

    @GetMapping("/{id}")
    public ResponseEntity<InvoiceItem> getInvoiceItemById(@PathVariable Long id) {
        Optional<InvoiceItem> item = invoiceItemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/invoice/{invoiceId}")
    public ResponseEntity<List<InvoiceItem>> getInvoiceItemsByInvoice(@PathVariable Long invoiceId) {
        List<InvoiceItem> items = invoiceItemRepository.findByInvoiceId(invoiceId);
        return ResponseEntity.ok(items);
    }

    @GetMapping("/item/{itemId}")
    public ResponseEntity<List<InvoiceItem>> getInvoiceItemsByItem(@PathVariable Long itemId) {
        List<InvoiceItem> items = invoiceItemRepository.findByItemId(itemId);
        return ResponseEntity.ok(items);
    }

    @PostMapping
    public ResponseEntity<InvoiceItem> createInvoiceItem(@RequestBody InvoiceItem item) {
        InvoiceItem savedItem = invoiceItemRepository.save(item);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedItem);
    }

    @PutMapping("/{id}")
    public ResponseEntity<InvoiceItem> updateInvoiceItem(@PathVariable Long id, @RequestBody InvoiceItem itemDetails) {
        Optional<InvoiceItem> itemOptional = invoiceItemRepository.findById(id);
        
        if (itemOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        InvoiceItem item = itemOptional.get();
        item.setInvoiceId(itemDetails.getInvoiceId());
        item.setItemId(itemDetails.getItemId());
        item.setQuantity(itemDetails.getQuantity());
        item.setPrice(itemDetails.getPrice());

        InvoiceItem updatedItem = invoiceItemRepository.save(item);
        return ResponseEntity.ok(updatedItem);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteInvoiceItem(@PathVariable Long id) {
        if (!invoiceItemRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        invoiceItemRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
