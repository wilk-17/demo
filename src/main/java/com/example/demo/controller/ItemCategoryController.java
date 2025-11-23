package com.example.demo.controller;

import com.example.demo.model.ItemCategory;
import com.example.demo.repository.ItemCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/item-categories")
public class ItemCategoryController {

    @Autowired
    private ItemCategoryRepository itemCategoryRepository;

    @PreAuthorize("hasAuthority('READ_CATEGORIES')")
    @GetMapping
    public ResponseEntity<List<ItemCategory>> getAllCategories() {
        List<ItemCategory> categories = itemCategoryRepository.findAll();
        return ResponseEntity.ok(categories);
    }

    @PreAuthorize("hasAuthority('READ_CATEGORIES')")
    @GetMapping("/{id}")
    public ResponseEntity<ItemCategory> getCategoryById(@PathVariable Long id) {
        Optional<ItemCategory> category = itemCategoryRepository.findById(id);
        return category.map(ResponseEntity::ok)
                      .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('WRITE_CATEGORIES')")
    @PostMapping
    public ResponseEntity<ItemCategory> createCategory(@RequestBody ItemCategory category) {
        ItemCategory savedCategory = itemCategoryRepository.save(category);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedCategory);
    }

    @PreAuthorize("hasAuthority('WRITE_CATEGORIES')")
    @PutMapping("/{id}")
    public ResponseEntity<ItemCategory> updateCategory(@PathVariable Long id, @RequestBody ItemCategory categoryDetails) {
        Optional<ItemCategory> categoryOptional = itemCategoryRepository.findById(id);
        
        if (categoryOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        ItemCategory category = categoryOptional.get();
        category.setName(categoryDetails.getName());

        ItemCategory updatedCategory = itemCategoryRepository.save(category);
        return ResponseEntity.ok(updatedCategory);
    }

    @PreAuthorize("hasAuthority('DELETE_CATEGORIES')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCategory(@PathVariable Long id) {
        if (!itemCategoryRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        itemCategoryRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
