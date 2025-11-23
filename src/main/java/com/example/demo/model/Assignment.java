package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Assignment Entity - Asignación de Items a Empleados
 * Permite rastrear el inventario asignado a empleados con trazabilidad completa.
 * Estados: ACTIVE (en uso), RETURNED (devuelto), LOST (perdido)
 */
@Entity
@Table(name = "assignment")
public class Assignment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "employee_id", nullable = false)
    private Long employeeId;

    @Column(name = "item_id", nullable = false)
    private Long itemId;

    @Column(nullable = false)
    private Integer quantity;

    @Column(name = "assigned_date", nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate assignedDate;

    @Enumerated(EnumType.STRING)
    @Column(length = 20, nullable = false)
    private AssignmentStatus status;

    @Column(name = "return_date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate returnDate;

    @Column(name = "condition", length = 100)
    private String condition;

    @Column(length = 500)
    private String notes;

    @Column(name = "creation_date", nullable = false, updatable = false)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime creationDate;

    @Column(name = "update_date")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime updateDate;

    // Relaciones
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id", insertable = false, updatable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private Employee employee;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id", insertable = false, updatable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private InventoryItem inventoryItem;

    public enum AssignmentStatus {
        ACTIVE("active"),
        RETURNED("returned"),
        LOST("lost");

        private final String value;

        AssignmentStatus(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

    // Constructores
    public Assignment() {
        this.creationDate = LocalDateTime.now();
        this.status = AssignmentStatus.ACTIVE;
        this.assignedDate = LocalDate.now();
    }

    public Assignment(Long employeeId, Long itemId, Integer quantity) {
        this();
        this.employeeId = employeeId;
        this.itemId = itemId;
        this.quantity = quantity;
    }

    // Métodos de negocio
    /**
     * Marca la asignación como devuelta
     * @param condition Estado del item al devolverlo
     * @param notes Notas sobre la devolución
     */
    public void markReturned(String condition, String notes) {
        this.status = AssignmentStatus.RETURNED;
        this.returnDate = LocalDate.now();
        this.condition = condition;
        this.notes = notes;
        this.updateDate = LocalDateTime.now();
    }

    /**
     * Marca la asignación como perdida
     * @param notes Notas sobre la pérdida
     */
    public void markLost(String notes) {
        this.status = AssignmentStatus.LOST;
        this.notes = notes;
        this.updateDate = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        creationDate = LocalDateTime.now();
        if (assignedDate == null) {
            assignedDate = LocalDate.now();
        }
        if (status == null) {
            status = AssignmentStatus.ACTIVE;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updateDate = LocalDateTime.now();
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Long employeeId) {
        this.employeeId = employeeId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public LocalDate getAssignedDate() {
        return assignedDate;
    }

    public void setAssignedDate(LocalDate assignedDate) {
        this.assignedDate = assignedDate;
    }

    public AssignmentStatus getStatus() {
        return status;
    }

    public void setStatus(AssignmentStatus status) {
        this.status = status;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public LocalDateTime getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(LocalDateTime updateDate) {
        this.updateDate = updateDate;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public InventoryItem getInventoryItem() {
        return inventoryItem;
    }

    public void setInventoryItem(InventoryItem inventoryItem) {
        this.inventoryItem = inventoryItem;
    }
}
