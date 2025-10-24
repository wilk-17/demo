package com.example.demo.controller;

import com.example.demo.model.ItemCategory;
import com.example.demo.repository.ItemCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/item-category")
public class ItemCategoryController {

    @Autowired
    private ItemCategoryRepository itemCategoryRepository;

    @GetMapping
    public ResponseEntity<List<ItemCategory>> getAllItemCategories() {
        List<ItemCategory> categories = itemCategoryRepository.findAll();
        return ResponseEntity.ok(categories);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ItemCategory> getItemCategoryById(@PathVariable Long id) {
        Optional<ItemCategory> category = itemCategoryRepository.findById(id);
        return category.map(ResponseEntity::ok)
                      .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<ItemCategory> createItemCategory(@RequestBody ItemCategory category) {
        ItemCategory savedCategory = itemCategoryRepository.save(category);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedCategory);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ItemCategory> updateItemCategory(@PathVariable Long id, @RequestBody ItemCategory categoryDetails) {
        Optional<ItemCategory> categoryOptional = itemCategoryRepository.findById(id);
        
        if (categoryOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        ItemCategory category = categoryOptional.get();
        category.setName(categoryDetails.getName());

        ItemCategory updatedCategory = itemCategoryRepository.save(category);
        return ResponseEntity.ok(updatedCategory);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteItemCategory(@PathVariable Long id) {
        if (!itemCategoryRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        itemCategoryRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
