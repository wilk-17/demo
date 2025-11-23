package com.example.demo.repository;

import com.example.demo.model.QuoteItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuoteItemRepository extends JpaRepository<QuoteItem, Long> {
    
    List<QuoteItem> findByQuoteId(Long quoteId);
    
    List<QuoteItem> findByItemId(Long itemId);
    
    void deleteByQuoteId(Long quoteId);
}
