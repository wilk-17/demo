package com.example.demo.controller;

import com.example.demo.model.SalesOrder;
import com.example.demo.repository.SalesOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/sales-orders")
public class SalesOrderController {

    @Autowired
    private SalesOrderRepository salesOrderRepository;

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping
    public ResponseEntity<List<SalesOrder>> getAllOrders() {
        List<SalesOrder> orders = salesOrderRepository.findAll();
        return ResponseEntity.ok(orders);
    }

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping("/{id}")
    public ResponseEntity<SalesOrder> getOrderById(@PathVariable Long id) {
        Optional<SalesOrder> order = salesOrderRepository.findById(id);
        return order.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.notFound().build());
    }

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<List<SalesOrder>> getOrdersByEmployee(@PathVariable Long employeeId) {
        List<SalesOrder> orders = salesOrderRepository.findByEmployeeId(employeeId);
        return ResponseEntity.ok(orders);
    }

    @PreAuthorize("hasAuthority('READ_ORDERS')")
    @GetMapping("/status/{status}")
    public ResponseEntity<List<SalesOrder>> getOrdersByStatus(@PathVariable String status) {
        List<SalesOrder> orders = salesOrderRepository.findByStatus(status);
        return ResponseEntity.ok(orders);
    }

    @PreAuthorize("hasAuthority('WRITE_ORDERS')")
    @PostMapping
    public ResponseEntity<SalesOrder> createOrder(@RequestBody SalesOrder order) {
        SalesOrder savedOrder = salesOrderRepository.save(order);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedOrder);
    }

    @PreAuthorize("hasAuthority('WRITE_ORDERS')")
    @PutMapping("/{id}")
    public ResponseEntity<SalesOrder> updateOrder(@PathVariable Long id, @RequestBody SalesOrder orderDetails) {
        Optional<SalesOrder> orderOptional = salesOrderRepository.findById(id);
        
        if (orderOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        SalesOrder order = orderOptional.get();
        order.setCustomerName(orderDetails.getCustomerName());
        order.setOrderDate(orderDetails.getOrderDate());
        order.setTotal(orderDetails.getTotal());
        order.setStatus(orderDetails.getStatus());
        order.setEmployeeId(orderDetails.getEmployeeId());
        order.setQuoteId(orderDetails.getQuoteId());

        SalesOrder updatedOrder = salesOrderRepository.save(order);
        return ResponseEntity.ok(updatedOrder);
    }

    @PreAuthorize("hasAuthority('DELETE_ORDERS')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable Long id) {
        if (!salesOrderRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        salesOrderRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
