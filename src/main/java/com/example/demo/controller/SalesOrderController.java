package com.example.demo.controller;

import com.example.demo.model.SalesOrder;
import com.example.demo.repository.SalesOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/sales-order")
public class SalesOrderController {

    @Autowired
    private SalesOrderRepository salesOrderRepository;

    @GetMapping
    public ResponseEntity<List<SalesOrder>> getAllSalesOrders() {
        List<SalesOrder> orders = salesOrderRepository.findAll();
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/{id}")
    public ResponseEntity<SalesOrder> getSalesOrderById(@PathVariable Long id) {
        Optional<SalesOrder> order = salesOrderRepository.findById(id);
        return order.map(ResponseEntity::ok)
                   .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<List<SalesOrder>> getSalesOrdersByEmployee(@PathVariable Long employeeId) {
        List<SalesOrder> orders = salesOrderRepository.findByEmployeeId(employeeId);
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/status/{status}")
    public ResponseEntity<List<SalesOrder>> getSalesOrdersByStatus(@PathVariable String status) {
        List<SalesOrder> orders = salesOrderRepository.findByStatus(status);
        return ResponseEntity.ok(orders);
    }

    @PostMapping
    public ResponseEntity<SalesOrder> createSalesOrder(@RequestBody SalesOrder order) {
        SalesOrder savedOrder = salesOrderRepository.save(order);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedOrder);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SalesOrder> updateSalesOrder(@PathVariable Long id, @RequestBody SalesOrder orderDetails) {
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

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSalesOrder(@PathVariable Long id) {
        if (!salesOrderRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        salesOrderRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
