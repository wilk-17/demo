package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * SalesGoal Entity - Meta de Ventas
 * Permite al administrador establecer metas mensuales, trimestrales y anuales
 * por empleado (vendedor) o por sucursal.
 * Uno de los dos campos (employeeId o branchId) debe ser nulo.
 */
@Entity
@Table(name = "sales_goal")
public class SalesGoal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Alcance de la meta (uno de los dos debe ser nulo)
    @Column(name = "employee_id")
    private Long employeeId;

    @Column(name = "branch_id")
    private Long branchId;

    // Periodo y fechas
    @Enumerated(EnumType.STRING)
    @Column(name = "period_type", length = 20, nullable = false)
    private PeriodType periodType;

    @Column(name = "start_date", nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;

    // Meta de ventas en dinero
    @Column(name = "target_amount", precision = 12, scale = 2, nullable = false)
    private BigDecimal targetAmount;

    // Metadatos
    @Column(name = "creation_date", nullable = false, updatable = false)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime creationDate;

    @Column(name = "created_by_user_id")
    private Long createdByUserId;

    // Relaciones
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id", insertable = false, updatable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private Employee employee;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id", insertable = false, updatable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private Branch branch;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_user_id", insertable = false, updatable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private User createdByUser;

    public enum PeriodType {
        MONTHLY("monthly"),
        QUARTERLY("quarterly"),
        YEARLY("yearly");

        private final String value;

        PeriodType(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

    // Constructores
    public SalesGoal() {
        this.creationDate = LocalDateTime.now();
        this.targetAmount = BigDecimal.ZERO;
    }

    public SalesGoal(PeriodType periodType, LocalDate startDate, LocalDate endDate, 
                     BigDecimal targetAmount, Long employeeId, Long branchId, Long createdByUserId) {
        this();
        this.periodType = periodType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.targetAmount = targetAmount;
        this.employeeId = employeeId;
        this.branchId = branchId;
        this.createdByUserId = createdByUserId;
    }

    /**
     * Valida que solo uno de employee_id o branch_id esté establecido
     */
    public boolean isValid() {
        return (employeeId != null && branchId == null) || 
               (employeeId == null && branchId != null);
    }

    /**
     * Obtiene el alcance de la meta como string
     */
    public String getScope() {
        if (employeeId != null) {
            return "Employee " + employeeId;
        } else if (branchId != null) {
            return "Branch " + branchId;
        }
        return "Undefined";
    }

    @PrePersist
    protected void onCreate() {
        creationDate = LocalDateTime.now();
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

    public Long getBranchId() {
        return branchId;
    }

    public void setBranchId(Long branchId) {
        this.branchId = branchId;
    }

    public PeriodType getPeriodType() {
        return periodType;
    }

    public void setPeriodType(PeriodType periodType) {
        this.periodType = periodType;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public BigDecimal getTargetAmount() {
        return targetAmount;
    }

    public void setTargetAmount(BigDecimal targetAmount) {
        this.targetAmount = targetAmount;
    }

    public LocalDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public Long getCreatedByUserId() {
        return createdByUserId;
    }

    public void setCreatedByUserId(Long createdByUserId) {
        this.createdByUserId = createdByUserId;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }

    public User getCreatedByUser() {
        return createdByUser;
    }

    public void setCreatedByUser(User createdByUser) {
        this.createdByUser = createdByUser;
    }
}
