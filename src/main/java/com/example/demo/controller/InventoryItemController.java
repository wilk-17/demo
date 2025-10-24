package com.example.demo.controller;

import com.example.demo.model.InventoryItem;
import com.example.demo.repository.InventoryItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/inventory-item")
public class InventoryItemController {

    @Autowired
    private InventoryItemRepository inventoryItemRepository;

    @GetMapping
    public ResponseEntity<List<InventoryItem>> getAllInventoryItems() {
        List<InventoryItem> items = inventoryItemRepository.findAll();
        return ResponseEntity.ok(items);
    }

    @GetMapping("/{id}")
    public ResponseEntity<InventoryItem> getInventoryItemById(@PathVariable Long id) {
        Optional<InventoryItem> item = inventoryItemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<List<InventoryItem>> getInventoryItemsByCategory(@PathVariable Long categoryId) {
        List<InventoryItem> items = inventoryItemRepository.findByCategoryId(categoryId);
        return ResponseEntity.ok(items);
    }

    @GetMapping("/brand/{brandId}")
    public ResponseEntity<List<InventoryItem>> getInventoryItemsByBrand(@PathVariable Long brandId) {
        List<InventoryItem> items = inventoryItemRepository.findByBrandId(brandId);
        return ResponseEntity.ok(items);
    }

    @PostMapping
    public ResponseEntity<InventoryItem> createInventoryItem(@RequestBody InventoryItem item) {
        InventoryItem savedItem = inventoryItemRepository.save(item);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedItem);
    }

    @PutMapping("/{id}")
    public ResponseEntity<InventoryItem> updateInventoryItem(@PathVariable Long id, @RequestBody InventoryItem itemDetails) {
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

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteInventoryItem(@PathVariable Long id) {
        if (!inventoryItemRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        inventoryItemRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
