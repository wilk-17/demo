package com.example.demo.controller;

import com.example.demo.model.Invoice;
import com.example.demo.repository.InvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/invoice")
public class InvoiceController {

    @Autowired
    private InvoiceRepository invoiceRepository;

    @GetMapping
    public ResponseEntity<List<Invoice>> getAllInvoices() {
        List<Invoice> invoices = invoiceRepository.findAll();
        return ResponseEntity.ok(invoices);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Invoice> getInvoiceById(@PathVariable Long id) {
        Optional<Invoice> invoice = invoiceRepository.findById(id);
        return invoice.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<List<Invoice>> getInvoicesByEmployee(@PathVariable Long employeeId) {
        List<Invoice> invoices = invoiceRepository.findByEmployeeId(employeeId);
        return ResponseEntity.ok(invoices);
    }

    @PostMapping
    public ResponseEntity<Invoice> createInvoice(@RequestBody Invoice invoice) {
        Invoice savedInvoice = invoiceRepository.save(invoice);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedInvoice);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Invoice> updateInvoice(@PathVariable Long id, 
                                                  @RequestBody Invoice invoiceDetails) {
        Optional<Invoice> invoiceOptional = invoiceRepository.findById(id);
        
        if (invoiceOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Invoice invoice = invoiceOptional.get();
        invoice.setCustomerName(invoiceDetails.getCustomerName());
        invoice.setInvoiceDate(invoiceDetails.getInvoiceDate());
        invoice.setTotal(invoiceDetails.getTotal());
        invoice.setEmployeeId(invoiceDetails.getEmployeeId());

        Invoice updatedInvoice = invoiceRepository.save(invoice);
        return ResponseEntity.ok(updatedInvoice);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteInvoice(@PathVariable Long id) {
        if (!invoiceRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        
        invoiceRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
