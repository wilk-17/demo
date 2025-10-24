package com.example.demo.repository;

import com.example.demo.model.SalesOrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesOrderItemRepository extends JpaRepository<SalesOrderItem, Long> {
    List<SalesOrderItem> findBySalesOrderId(Long salesOrderId);
    List<SalesOrderItem> findByItemId(Long itemId);
}
