package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Quote Entity - Cotización
 * Cotizaciones realizadas a clientes por empleados (vendedores)
 */
@Entity
@Table(name = "quote")
public class Quote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "customer_name", nullable = false, length = 200)
    private String customerName;

    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    @Column(precision = 12, scale = 2, nullable = false)
    private BigDecimal total;

    @Column(name = "employee_id", nullable = false)
    private Long employeeId;

    // Relaciones
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id", insertable = false, updatable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private Employee employee;

    @OneToMany(mappedBy = "quote", cascade = CascadeType.ALL, orphanRemoval = true)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private List<QuotationLine> lines = new ArrayList<>();

    // Constructores
    public Quote() {
        this.date = LocalDate.now();
        this.total = BigDecimal.ZERO;
    }

    public Quote(String customerName, Long employeeId) {
        this();
        this.customerName = customerName;
        this.employeeId = employeeId;
    }

    // Métodos de utilidad
    public void addLine(QuotationLine line) {
        lines.add(line);
        line.setQuote(this);
    }

    public void removeLine(QuotationLine line) {
        lines.remove(line);
        line.setQuote(null);
    }

    /**
     * Calcula el total de la cotización a partir de las líneas
     */
    public void calculateTotal() {
        this.total = lines.stream()
                .map(line -> line.getPrice().multiply(BigDecimal.valueOf(line.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @PrePersist
    @PreUpdate
    protected void onSave() {
        if (date == null) {
            date = LocalDate.now();
        }
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public Long getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Long employeeId) {
        this.employeeId = employeeId;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public List<QuotationLine> getLines() {
        return lines;
    }

    public void setLines(List<QuotationLine> lines) {
        this.lines = lines;
    }
}
