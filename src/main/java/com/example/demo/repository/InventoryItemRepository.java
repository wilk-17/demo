package com.example.demo.repository;

import com.example.demo.model.InventoryItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InventoryItemRepository extends JpaRepository<InventoryItem, Long> {
    List<InventoryItem> findByCategoryId(Long categoryId);
    List<InventoryItem> findByBrandId(Long brandId);
}
