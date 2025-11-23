package com.example.demo.controller;

import com.example.demo.model.InventoryItem;
import com.example.demo.repository.InventoryItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/inventory-items")
public class InventoryItemController {

    @Autowired
    private InventoryItemRepository inventoryItemRepository;

    @PreAuthorize("hasAuthority('READ_INVENTORY')")
    @GetMapping
    public ResponseEntity<List<InventoryItem>> getAllItems() {
        List<InventoryItem> items = inventoryItemRepository.findAll();
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('READ_INVENTORY')")
    @GetMapping("/{id}")
    public ResponseEntity<InventoryItem> getItemById(@PathVariable Long id) {
        Optional<InventoryItem> item = inventoryItemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_INVENTORY')")
    @GetMapping("/category/{categoryId}")
    public ResponseEntity<List<InventoryItem>> getItemsByCategoryId(@PathVariable Long categoryId) {
        List<InventoryItem> items = inventoryItemRepository.findByCategoryId(categoryId);
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('READ_INVENTORY')")
    @GetMapping("/brand/{brandId}")
    public ResponseEntity<List<InventoryItem>> getItemsByBrandId(@PathVariable Long brandId) {
        List<InventoryItem> items = inventoryItemRepository.findByBrandId(brandId);
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('WRITE_INVENTORY')")
    @PostMapping
    public ResponseEntity<InventoryItem> createItem(@RequestBody InventoryItem item) {
        InventoryItem savedItem = inventoryItemRepository.save(item);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedItem);
    }

    @PreAuthorize("hasAuthority('WRITE_INVENTORY')")
    @PutMapping("/{id}")
    public ResponseEntity<InventoryItem> updateItem(@PathVariable Long id, @RequestBody InventoryItem itemDetails) {
        Optional<InventoryItem> itemOptional = inventoryItemRepository.findById(id);
        
        if (itemOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        InventoryItem item = itemOptional.get();
        item.setName(itemDetails.getName());
        item.setDescription(itemDetails.getDescription());
        item.setQuantity(itemDetails.getQuantity());
        item.setPrice(itemDetails.getPrice());
        item.setCategoryId(itemDetails.getCategoryId());
        item.setBrandId(itemDetails.getBrandId());

        InventoryItem updatedItem = inventoryItemRepository.save(item);
        return ResponseEntity.ok(updatedItem);
    }

    @PreAuthorize("hasAuthority('DELETE_INVENTORY')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteItem(@PathVariable Long id) {
        if (!inventoryItemRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        inventoryItemRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
