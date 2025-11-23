package com.example.demo.controller;

import com.example.demo.model.SalesOrderItem;
import com.example.demo.repository.SalesOrderItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/sales-order-items")
public class SalesOrderItemController {

    @Autowired
    private SalesOrderItemRepository salesOrderItemRepository;

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping
    public ResponseEntity<List<SalesOrderItem>> getAllOrderItems() {
        List<SalesOrderItem> items = salesOrderItemRepository.findAll();
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping("/{id}")
    public ResponseEntity<SalesOrderItem> getOrderItemById(@PathVariable Long id) {
        Optional<SalesOrderItem> item = salesOrderItemRepository.findById(id);
        return item.map(ResponseEntity::ok)
                  .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping("/sales-order/{salesOrderId}")
    public ResponseEntity<List<SalesOrderItem>> getSalesOrderItemsBySalesOrder(@PathVariable Long salesOrderId) {
        List<SalesOrderItem> items = salesOrderItemRepository.findBySalesOrderId(salesOrderId);
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping("/item/{itemId}")
    public ResponseEntity<List<SalesOrderItem>> getOrderItemsByItem(@PathVariable Long itemId) {
        List<SalesOrderItem> items = salesOrderItemRepository.findByItemId(itemId);
        return ResponseEntity.ok(items);
    }

    @PreAuthorize("hasAuthority('WRITE_ORDERS')")
    @PostMapping
    public ResponseEntity<SalesOrderItem> createOrderItem(@RequestBody SalesOrderItem orderItem) {
        SalesOrderItem savedItem = salesOrderItemRepository.save(orderItem);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedItem);
    }

    @PreAuthorize("hasAuthority('WRITE_ORDERS')")
    @PutMapping("/{id}")
    public ResponseEntity<SalesOrderItem> updateOrderItem(@PathVariable Long id, @RequestBody SalesOrderItem orderItemDetails) {
        Optional<SalesOrderItem> itemOptional = salesOrderItemRepository.findById(id);
        
        if (itemOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        SalesOrderItem item = itemOptional.get();
        item.setSalesOrderId(orderItemDetails.getSalesOrderId());
        item.setItemId(orderItemDetails.getItemId());
        item.setQuantity(orderItemDetails.getQuantity());

        SalesOrderItem updatedItem = salesOrderItemRepository.save(item);
        return ResponseEntity.ok(updatedItem);
    }

    @PreAuthorize("hasAuthority('DELETE_ORDERS')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrderItem(@PathVariable Long id) {
        if (!salesOrderItemRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        salesOrderItemRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
