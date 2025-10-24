package com.example.demo.controller;

import com.example.demo.model.SalesOrderItem;
import com.example.demo.repository.SalesOrderItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/sales-order-item")
public class SalesOrderItemController {

    @Autowired
    private SalesOrderItemRepository salesOrderItemRepository;

    @GetMapping
    public ResponseEntity<List<SalesOrderItem>> getAllSalesOrderItems() {
        List<SalesOrderItem> items = salesOrderItemRepository.findAll();
        return ResponseEntity.ok(items);
    }

    @GetMapping("/{id}")
    public ResponseEntity<SalesOrderItem> getSalesOrderItemById(@PathVariable Long id) {
        Optional<SalesOrderItem> item = salesOrderItemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/sales-order/{salesOrderId}")
    public ResponseEntity<List<SalesOrderItem>> getSalesOrderItemsBySalesOrder(@PathVariable Long salesOrderId) {
        List<SalesOrderItem> items = salesOrderItemRepository.findBySalesOrderId(salesOrderId);
        return ResponseEntity.ok(items);
    }

    @GetMapping("/item/{itemId}")
    public ResponseEntity<List<SalesOrderItem>> getSalesOrderItemsByItem(@PathVariable Long itemId) {
        List<SalesOrderItem> items = salesOrderItemRepository.findByItemId(itemId);
        return ResponseEntity.ok(items);
    }

    @PostMapping
    public ResponseEntity<SalesOrderItem> createSalesOrderItem(@RequestBody SalesOrderItem item) {
        SalesOrderItem savedItem = salesOrderItemRepository.save(item);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedItem);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SalesOrderItem> updateSalesOrderItem(@PathVariable Long id, @RequestBody SalesOrderItem itemDetails) {
        Optional<SalesOrderItem> itemOptional = salesOrderItemRepository.findById(id);
        
        if (itemOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        SalesOrderItem item = itemOptional.get();
        item.setSalesOrderId(itemDetails.getSalesOrderId());
        item.setItemId(itemDetails.getItemId());
        item.setQuantity(itemDetails.getQuantity());

        SalesOrderItem updatedItem = salesOrderItemRepository.save(item);
        return ResponseEntity.ok(updatedItem);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSalesOrderItem(@PathVariable Long id) {
        if (!salesOrderItemRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        salesOrderItemRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
